{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let x11libs = lib.makeLibraryPath [ alsa-lib atkmm xorg.libX11 xorg.libXcursor xorg.libXrandr xorg.libXi libglvnd vulkan-loader vulkan-validation-layers SDL2 ];
in
mkShell {
  nativeBuildInputs = [ gdb cargo rustc rustfmt libiconv pkg-config wrapGAppsHook ];
  buildInputs = [ glibc ffmpeg-full atkmm gtk3 gdk-pixbuf cairo clang cmake pango SDL2 ];

  LIBCLANG_PATH="${libclang.lib}/lib";
  LD_LIBRARY_PATH="${x11libs}";
  XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS";
}
