{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    google-fonts
    rictydiminished-with-firacode
    source-han-mono
    source-han-code-jp
    source-han-sans-japanese
    source-han-serif-japanese
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  # fonts.enableDefaultFonts = true;
  # fonts.fontconfig.defaultFonts = {
  #  serif = [ " ];
  #  sansSerif = [ "Nikukyu" "RoundedMplus1c" ];
  #  monospace = [ ];
  # };
}
