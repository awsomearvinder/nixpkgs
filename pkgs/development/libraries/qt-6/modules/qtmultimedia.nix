{ qtModule
, lib
, stdenv
, qtbase
, qtdeclarative
, qtshadertools
, qtsvg
, pkg-config
, alsa-lib
, gstreamer
, gst-plugins-base
, gst-plugins-good
, gst-libav
, gst-vaapi
, libpulseaudio
, wayland
, elfutils
, libunwind
, orc
, VideoToolbox
}:

qtModule {
  pname = "qtmultimedia";
  qtInputs = [ qtbase qtdeclarative qtsvg qtshadertools ];
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libunwind orc ]
    ++ lib.optionals stdenv.isLinux [ libpulseaudio elfutils alsa-lib wayland ];
  propagatedBuildInputs = [ gstreamer gst-plugins-base gst-plugins-good gst-libav ]
    ++ lib.optionals stdenv.isLinux [ gst-vaapi ]
    ++ lib.optionals stdenv.isDarwin [ VideoToolbox ];

  NIX_CFLAGS_COMPILE = lib.optionalString stdenv.isDarwin
    "-include AudioToolbox/AudioToolbox.h";
  NIX_LDFLAGS = lib.optionalString stdenv.isDarwin
    "-framework AudioToolbox";
}
