# Nix configuration

My system configuration using [Nix][nix] and [Home Manager][home-manager].

## macOS

Install Nix using the [Determinate Nix Installer][determinate-installer]:

```
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Install [nix-darwin][nix-darwin] and the configuration:

```
$ sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#<name>
```

Apply changes to the system:

```
$ sudo darwin-rebuild switch --flake .#<name>
```


## Linux

TODO


[nix]: https://nixos.org
[determinate-installer]: https://github.com/DeterminateSystems/nix-installer
[nix-darwin]: https://github.com/LnL7/nix-darwin/blob/master/README.md
[home-manager]: https://github.com/nix-community/home-manager
