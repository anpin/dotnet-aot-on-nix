# Reproduction of dotnet native AOT publishing failure on linux

Pick your build falvour:
- ```nix build github:anpin/dotnet-aot-on-nix```
- ```docker build https://github.com/anpin/dotnet-aot-on-nix.git```
- (clone repo, enter its directory and then run) ```nix develop --command bash build.sh``` (this runs in the local shell and saves binlog which is already included in the repo)

All three commands would fail with:
```
"/home/a/projects/dotnet-aot-on-nix/csharp/CsharpAot.csproj" (Publish target) (1:7) ->
                   (LinkNative target) ->
                     collect2 : error : ld returned 1 exit status [/home/a/projects/dotnet-aot-on-nix/csharp/CsharpAot.csproj]
                     /home/a/.nuget/packages/microsoft.dotnet.ilcompiler/8.0.0/build/Microsoft.NETCore.Native.targets(364,5): error MSB3073: The command ""gcc" "obj/Release/net8.0/linux-x64/native/CsharpAot.o" -o "bin/Release/net8.0/linux-x64/native/CsharpAot" -gz=zlib -fuse-ld=bfd /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/sdk/libbootstrapper.o /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/sdk/libRuntime.WorkstationGC.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/sdk/libeventpipe-disabled.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/sdk/libstdc++compat.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/framework/libSystem.Native.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/framework/libSystem.Globalization.Native.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/framework/libSystem.IO.Compression.Native.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/framework/libSystem.Net.Security.Native.a /home/a/.nuget/packages/runtime.linux-x64.microsoft.dotnet.ilcompiler/8.0.0/framework/libSystem.Security.Cryptography.Native.OpenSsl.a -g -Wl,-rpath,'$ORIGIN' -Wl,--build-id=sha1 -Wl,--as-needed -pthread -ldl -lz -lrt -lm -pie -Wl,-pie -Wl,-z,relro -Wl,-z,now -Wl,--eh-frame-hdr -Wl,--discard-all -Wl,--gc-sections" exited with code 1. [/home/a/projects/dotnet-aot-on-nix/csharp/CsharpAot.csproj]
```