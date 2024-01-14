{ 
lib
, buildDotnetModule
, dotnetCorePackages
, gcc
, zlib
, linkNugets ? true 
}:
buildDotnetModule rec {
  dotnet-sdk  = dotnetCorePackages.sdk_8_0;
  pname = "CsharpAot";
  version = "0.0.1";
  src = ./.;
  nugetDeps = ./deps.nix;
  projectFile = "./csharp/CsharpAot.csproj";
  selfContainedBuild = true;
  nativeBuildInputs = [
    gcc
    zlib
  ];
  dotnetFlags = [
    #  "-bl"
    #  "-v diag"
  ];

  postConfigure = lib.optional linkNugets ''
    TOOLS="$HOME/.nuget/packages/microsoft.netcore.app.crossgen2.linux-x64/8.0.0/tools/"
    TOOLS="$TOOLS:$HOME/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/tools/"
    export LD_LIBRARY_PATH="$LDLIBRARY_PATH:$TOOLS"
  '';

  preInstall = ''
    gcc -v
    # export LD_DEBUG=libs
  '';
  
  meta = with lib; {
    name = "CsharpAot";
    description = "Csharp Aot repro";
    license = licenses.mit;
    maintainers = with maintainers; [ anpin ];
    platforms = [ "x86_64-linux"  ];
  };
}
