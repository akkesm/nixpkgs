{ lib
, fetchurl
, appimageTools
}:

let
  pname = "nuclear";
  version = "9545bf";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/nukeop/nuclear/releases/download/${version}/${name}.AppImage";
    sha256 = "12gq5wiw885083byyg1za8jr08p62p0j707jl2g5gnrq3fj47g8p";
  };

  appimageContents = appimageTools.extract { inherit name src; };
in appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}

    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "Streaming music player that finds free music for you";
    homepage = "https://nuclear.js.org/";
    license = licenses.agpl3Plus;
    maintainers = [ maintainers.ivar ];
    platforms = [ "x86_64-linux" ];
  };
}
