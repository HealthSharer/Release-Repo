
[Setup]
AppName=HealthSharer
AppVersion=1.0
DefaultDirName={code:GetInstallDir}
DefaultGroupName=HealthSharer
OutputDir=.
OutputBaseFilename=HealthSharerSetup
Compression=lzma
SolidCompression=yes

[Code]
// Allow user to choose install directory
function GetInstallDir(Default: String): String;
begin
	Result := ExpandConstant('{pf}\HealthSharer');
end;



[Files]
; Main Electron app
Source: "release-build\webapp\*"; DestDir: "{app}\webapp"; Flags: ignoreversion recursesubdirs; 
; File Processor
Source: "release-build\desktopBuild\fileprocessor\*"; DestDir: "{app}\fileprocessor"; Flags: ignoreversion recursesubdirs; Excludes: "*.pdb *.log"
; IPFS
Source: "release-build\ipfsnode\*"; DestDir: "{app}\ipfsnode"; Flags: ignoreversion
; Supervisor processor
Source: "release-build\desktopBuild\publish\*"; DestDir: "{app}"; Flags: ignoreversion



[Run]
; Clear existing IPFS bootstrap
Filename: "{app}\ipfsnode\ipfs.exe"; Parameters: "bootstrap rm --all"; Flags: runhidden

; Add new IPFS bootstrap address
Filename: "{app}\ipfsnode\ipfs.exe"; Parameters: "bootstrap add /ip4/healthsharer.live/tcp/4001/p2p/12D3KooWEC7MkH8dHyALpkU4HaeLc8AdLyns7vS1faoTrzVvWEon"; Flags: runhidden



[Icons]
Name: "{group}\HealthSharer"; Filename: "{app}\webapp\HealthSharer.exe"
Name: "{group}\File Processor"; Filename: "{app}\fileprocessor\FileProcessor.exe"
Name: "{group}\IPFS"; Filename: "{app}\ipfsnode\ipfs.exe"
Name: "{group}\Run All"; Filename: "{app}\run-all.bat"; WorkingDir: "{app}"



[Registry]
; Set ASPNETCORE_ENVIRONMENT to Desktop
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "ASPNETCORE_ENVIRONMENT"; ValueData: "Desktop"; Flags: preservestringtype

; Set MessageQueue_Username
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "MessageQueue_Username"; ValueData: "guest"; Flags: preservestringtype

; Set MessageQueue_Password
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "MessageQueue_Password"; ValueData: "guest"; Flags: preservestringtype



[UninstallDelete]
Type: filesandordirs; Name: "{app}"



[Registry]
; Remove registry keys on uninstall
Root: HKCU; Subkey: "Environment"; ValueType: none; ValueName: "ASPNETCORE_ENVIRONMENT"; Flags: deletevalue uninsdeletevalue
Root: HKCU; Subkey: "Environment"; ValueType: none; ValueName: "MessageQueue_Username"; Flags: deletevalue uninsdeletevalue
Root: HKCU; Subkey: "Environment"; ValueType: none; ValueName: "MessageQueue_Password"; Flags: deletevalue uninsdeletevalue