(function () {
  const OPENER = "@opener@";

  try {
    const prefs = Cc["@mozilla.org/preferences-service;1"].getService(Ci.nsIPrefBranch);
    const obs = Cc["@mozilla.org/observer-service;1"].getService(Ci.nsIObserverService);
    const wm = Cc["@mozilla.org/appshell/window-mediator;1"].getService(Ci.nsIWindowMediator);

    const getPref = (name) => {
      try {
        return prefs.getStringPref(name);
      } catch (e) {
        return "";
      }
    };

    const log = (...args) => {
      const path = getPref("webapps.externalLinks.debugLog");
      if (!path) return;
      try {
        const file = Cc["@mozilla.org/file/local;1"].createInstance(Ci.nsIFile);
        file.initWithPath(path);
        const stream = Cc["@mozilla.org/network/file-output-stream;1"].createInstance(
          Ci.nsIFileOutputStream
        );
        stream.init(file, 0x02 | 0x08 | 0x10, 0o644, 0);
        const line = args.join(" ") + "\n";
        stream.write(line, line.length);
        stream.close();
      } catch (e) {}
    };

    const later = (ms, fn) => {
      const timer = Cc["@mozilla.org/timer;1"].createInstance(Ci.nsITimer);
      timer.initWithCallback({ notify: fn }, ms, Ci.nsITimer.TYPE_ONE_SHOT);
    };

    const isAllowed = (host, allowed) =>
      allowed.some((d) => host === d || host.endsWith("." + d));

    const openExternal = (profile, url) => {
      const file = Cc["@mozilla.org/file/local;1"].createInstance(Ci.nsIFile);
      file.initWithPath(OPENER);
      const proc = Cc["@mozilla.org/process/util;1"].createInstance(Ci.nsIProcess);
      proc.init(file);
      proc.runwAsync([profile, url], 2);
    };

    const countBrowserWindows = () => {
      let n = 0;
      const e = wm.getEnumerator("navigator:browser");
      while (e.hasMoreElements()) {
        e.getNext();
        n++;
      }
      return n;
    };

    const closeIfBlank = (bc, attempts) => {
      const retry = () => {
        if (attempts > 0) later(100, () => closeIfBlank(bc, attempts - 1));
      };
      if (bc.isDiscarded) return;
      const win = bc.topChromeWindow;
      const browser = bc.top.embedderElement;
      const gBrowser = win && win.gBrowser;
      const tab = gBrowser && browser && gBrowser.getTabForBrowser(browser);
      log("closeIfBlank", attempts, !!tab, win?.gBrowserInit?.delayedStartupFinished);
      if (!tab || !win.gBrowserInit?.delayedStartupFinished) return retry();

      const spec = browser.currentURI?.spec ?? "";
      if (browser.canGoBack || !(spec === "" || spec === "about:blank")) return;
      if (gBrowser.tabs.length > 1) {
        gBrowser.removeTab(tab);
      } else if (countBrowserWindows() > 1) {
        win.close();
      }
    };

    obs.addObserver(
      {
        observe(subject) {
          const allowedPref = getPref("webapps.externalLinks.allowedHosts");
          const profile = getPref("webapps.externalLinks.profile");
          if (!allowedPref || !profile) return;

          const channel = subject.QueryInterface(Ci.nsIHttpChannel);
          const loadInfo = channel.loadInfo;
          if (
            !loadInfo ||
            loadInfo.externalContentPolicyType !== Ci.nsIContentPolicy.TYPE_DOCUMENT
          )
            return;

          const allowed = allowedPref
            .split(",")
            .map((s) => s.trim())
            .filter(Boolean);
          if (isAllowed(channel.URI.host, allowed)) return;

          log("redirect", channel.URI.spec);
          channel.cancel(Components.results.NS_BINDING_ABORTED);
          openExternal(profile, channel.URI.spec);
          const bc = loadInfo.browsingContext;
          if (bc) later(0, () => closeIfBlank(bc, 30));
        },
      },
      "http-on-modify-request"
    );
  } catch (e) {
    Components.utils.reportError(e);
  }
})();
