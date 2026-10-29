{ perSystem, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    # 曜日や月は英語、時刻は 24 時間表記
    LC_TIME = "C.UTF-8";
  };

  environment.systemPackages = [ perSystem.self.man-pages-ja ];
  # LANG は英語のまま man だけ日本語のページを優先する
  environment.sessionVariables.MANOPT = "-L ja_JP.UTF-8";
}
