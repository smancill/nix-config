# Nix configuration

My system configuration using Nix and [Home Manager][home-manager].

## macOS

Install Nix using the [Determinate Nix Installer][determinate-installer]:

```
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Install [nix-darwin][nix-darwin] and the configuration:

```
$ nix run nix-darwin -- switch --flake .#<name>
```

Apply changes to the system:

```
$ darwin-rebuild switch --flake .#<name>
```

## Linux

TODO


[determinate-installer]: https://github.com/DeterminateSystems/nix-installer
[nix-darwin]: https://github.com/LnL7/nix-darwin/blob/master/README.md
[home-manager]: https://github.com/nix-community/home-manager
