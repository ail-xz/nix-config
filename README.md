# nixos-config

[blueprint](https://github.com/numtide/blueprint) を使った NixOS / nix-darwin / home-manager の設定

## 構成

```
.
├── flake.nix
├── hosts/<hostname>/                 # ホスト名のディレクトリ
│   ├── configuration.nix             # NixOS の場合
│   ├── darwin-configuration.nix      # nix-darwin の場合
│   └── users/<user>/                 # ユーザー名のディレクトリ
│       └── home-configuration.nix    # home-manager
├── modules/
│   ├── common/                       # NixOS, nix-darwin 共通モジュール
│   ├── nixos/                        # NixOS 用モジュール
│   ├── darwin/                       # nix-darwin 用モジュール
│   └── home/                         # home-manager モジュール
│       ├── nixos/                    # NixOS 用 home-manager モジュール
│       └── darwin/                   # macOS 用 home-manager モジュール
├── packages/                         # 自前パッケージ
└── devshells/                        # devShell
```

blueprint がディレクトリ構成から flake の output を作る

- `hosts/<name>/configuration.nix` → `nixosConfigurations.<name>`
- `hosts/<name>/darwin-configuration.nix` → `darwinConfigurations.<name>`
- `modules/<type>/<name>.nix` → `<type>` が `nixos` / `darwin` / `home` ならそれぞれ `nixosModules` / `darwinModules` / `homeModules`、それ以外は `modules.<type>.<name>`
- `packages/<name>/default.nix` → `packages.<system>.<name>` (モジュールからは `perSystem.self.<name>`)
- `devshells/<name>.nix` → `devShells.<system>.<name>` (`nix develop .#<name>`)

`networking.hostName` は `hosts/` 配下のディレクトリ名になる  
ユーザー名はホストの `my.primaryUser` で指定する。`hosts/<hostname>/users/<user>/` のディレクトリ名と一致させる

## 初回

- `my.primaryUser` と同じ名前のユーザーで実行する
- `~/nix` 以外に置く場合はホストの home 設定で `programs.nh.flake` を上書きする (macOS のアプリ設定のリンク先もこれに従う)
- `<hostname>` は `hosts/` 配下のディレクトリ名。新しいホストは `hosts/<hostname>/` を作って `git add` する (flake は git 管理外のファイルを無視する)

### NixOS

```sh
nix-shell -p git
git clone https://github.com/ail-xz/nix-config.git ~/nix
cd ~/nix
nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware-configuration.nix
git add hosts/<hostname>    # 新しいホストの場合
NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --sudo --flake .#<hostname>
```

### macOS

[Nix (Lix Installer)](https://lix.systems/install/#on-any-other-linuxmacos-system) と [Homebrew](https://brew.sh/) をインストールする (nix-darwin は Homebrew 自体をインストールしない)

```sh
git clone https://github.com/ail-xz/nix-config.git ~/nix
cd ~/nix
sudo nix --extra-experimental-features "nix-command flakes" \
  run nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname>
```

LinearMouse と Snapzy の設定 (`modules/home/darwin/linearmouse/`、`modules/home/darwin/snapzy/`) は、リポジトリ内のディレクトリを直接リンクしている。アプリで設定を変えるとこのファイルが書き換わり、git の差分になる

## 適用

`rebuild` エイリアス ([nh](https://github.com/nix-community/nh))

```sh
rebuild    # nh os switch / nh darwin switch
```

## 更新

```sh
nix flake update          # すべての input
nix flake update nixpkgs  # 特定の input
rebuild
```

更新後に問題が出たら lock を戻して `rebuild` する

- コミット前: `git checkout flake.lock`
- コミット後: `git revert <コミット>`

NixOS が起動しなくなった場合は、ブートローダーで前の世代を選ぶ

## フォーマット

```sh
nix fmt
```

blueprint のデフォルト (`nixfmt-tree`) が使われる

## GC

`nh clean all --keep 5 --keep-since 30d` が毎週実行される (`programs.nh.clean`、`modules/common/shared.nix`)

あわせて `nix.optimise.automatic` でストアの重複排除も行う (`modules/common/shared.nix`)。
