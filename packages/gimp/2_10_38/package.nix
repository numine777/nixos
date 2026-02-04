{ stdenv, lib, fetchurl, autoreconfHook, gettext, intltool, pkg-config, babl, gegl, gtk2, glib, pango, cairo, gdk-pixbuf, libjpeg, libtiff, libpng, librsvg, libexif, lcms2, poppler, libgsf, libxml2, libxslt, python3, mypaint-brushes, gexiv2, harfbuzz, fontconfig, freetype, webkitgtk_4_1, appstream-glib, desktop-file-utils, shared-mime-info, xorg, alsa-lib, libwebp, libheif, openexr, ghostscript, lua5_3, json-glib, vala }:

stdenv.mkDerivation rec {
  pname = "gimp";
  version = "2.10.38";

  src = fetchurl {
    url = "https://download.gimp.org/pub/gimp/v2.10/gimp-${version}.tar.bz2";
    sha256 = "sha256-UKhF7sEciDH+hmFweVD1uERuNfMO37ms+Y+FwRM/hW4=";
  };

  patches = [
    # Your existing patches here, e.g.:
    (fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/graphics/gimp/remove-cc-reference.patch";
      sha256 = "sha256-3xP+hqEDbjjC4tsenZ+8/NxIj6Ls+JHUgeOOB8ZSjVA="; # Replace with actual hash
    })
    # Add others as needed
  ];

  nativeBuildInputs = [ autoreconfHook gettext intltool pkg-config python3 appstream-glib desktop-file-utils shared-mime-info vala ];

  buildInputs = [
    babl
    gegl
    gtk2
    glib
    pango
    cairo
    gdk-pixbuf
    libjpeg
    libtiff
    libpng
    librsvg
    libexif
    lcms2
    poppler
    libgsf
    libxml2
    libxslt
    mypaint-brushes
    gexiv2
    harfbuzz
    fontconfig
    freetype
    webkitgtk_4_1
    libwebp
    libheif
    openexr
    ghostscript
    lua5_3
    json-glib
    xorg.libXpm
    xorg.libXmu
    xorg.libXcursor
    xorg.libXfixes
    alsa-lib
    # Add any other dependencies as per your setup
  ];

  configureFlags = [
    "--disable-python" # Adjust as needed
    "--enable-default-bin" # Example flags; customize based on requirements
  ];

  postPatch = ''
    # Apply any additional post-patch commands if needed
  '';

  meta = with lib; {
    description = "The GNU Image Manipulation Program";
    homepage = "https://www.gimp.org/";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = [ maintainers.example ]; # Optional
  };
}
