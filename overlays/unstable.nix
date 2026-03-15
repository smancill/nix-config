final: prev:

let
  vim-custom = (final.vim-full.override {
    config = {
      vim = {
        gui = "none";
        darwin = final.stdenv.hostPlatform.isDarwin;
        lua = true;
        perl = false;
        ruby = false;
      };
    };
  }).overrideAttrs {
    pname = "vim-custom";
  };

in
{
  neovim = final.wrapNeovim final.neovim-unwrapped
  {
    withPython3 = true;
    withRuby = false;
    withNodeJs = true;
  };

  vim = final.symlinkJoin {
    name = "vim-${vim-custom.version}";
    paths = [ vim-custom ];

    # CoC support
    buildInputs = [ final.makeWrapper final.nodejs ];
    postBuild = ''
      wrapProgram "$out/bin/vim" --prefix PATH : "${final.nodejs}/bin"
    '';
  };
}
