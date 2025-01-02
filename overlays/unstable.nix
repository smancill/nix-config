final: prev:

let
  customVim = (final.vim_configurable.override {
    config = {
      vim = {
        gui = "none";
        darwin = final.stdenv.isDarwin;
        lua = true;
        perl = false;
        ruby = false;
      };
    };
  }).overrideAttrs (finalAttrs: rec {
    pname = "vim-custom";
  });

in
{
  neovim = final.wrapNeovim final.neovim-unwrapped
  {
    withPython3 = true;
    withRuby = false;
    withNodeJs = true;
  };

  vim = final.symlinkJoin {
    name = "vim-${customVim.version}";
    paths = [ customVim ];

    # CoC support
    buildInputs = [ prev.makeWrapper final.nodejs ];
    postBuild = ''
      wrapProgram "$out/bin/vim" --prefix PATH : "${final.nodejs}/bin"
    '';
  };
}
