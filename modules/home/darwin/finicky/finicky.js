export default {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: (_url, { opener }) =>
        ["com.apple.mail", "com.microsoft.Outlook"].includes(opener?.bundleId ?? ""),
      browser: "Microsoft Edge",
    },
  ],
};
