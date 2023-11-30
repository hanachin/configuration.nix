{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    google-fonts
    nerdfonts
    rictydiminished-with-firacode
    source-han-mono
    source-han-code-jp
    source-han-sans-japanese
    source-han-serif-japanese
  ];
  # fonts.enableDefaultFonts = true;
  # fonts.fontconfig.defaultFonts = {
  #  serif = [ " ];
  #  sansSerif = [ "Nikukyu" "RoundedMplus1c" ];
  #  monospace = [ ];
  # };
}
