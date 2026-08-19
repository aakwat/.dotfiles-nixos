{ pkgs, ... }:

{
  home.packages = [ pkgs.niri ];

  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us"
        }
      }
    }
    
    binds {
      Mod+Return { spawn "kitty"; }
      Mod+E { spawn "nemo"; }
      Mod+B { spawn "librewolf"; }
      Mod+Space { spawn "tofi-run" "--drun-print-desktop-entry=true"; }
      Mod+Q { close-window; }
    }
  '';
}
