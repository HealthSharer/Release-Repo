[Setup]
AppName=HealthSharer
AppVersion=1.0
DefaultDirName={pf}\HealthSharer
DefaultGroupName=HealthSharer
OutputDir=.
OutputBaseFilename=HealthSharerSetup
Compression=lzma
SolidCompression=yes

[Files]
; Main Electron app
Source: "release-build\webapp\*"; DestDir: "{app}\webapp"; Flags: ignoreversion recursesubdirs; Excludes: "node_modules\*"
; File Processor
Source: "release-build\fileprocessor\*"; DestDir: "{app}\fileprocessor"; Flags: ignoreversion recursesubdirs
; IPFS
Source: "release-build\ipfsnode\ipfs.exe"; DestDir: "{app}\ipfsnode"; Flags: ignoreversion

[Run]
; Clear existing IPFS bootstrap
Filename: "{app}\ipfsnode\ipfs.exe"; Parameters: "bootstrap rm --all"; Flags: runhidden

; Add new IPFS bootstrap address
Filename: "{app}\ipfsnode\ipfs.exe"; Parameters: "bootstrap add /ip4/82.24.183.42/tcp/4001/p2p/12D3KooWC1kQN58S9LM8o4GjVZbs3FTZpR4Vt7tf9P6tyCuAyzSB"; Flags: runhidden

[Icons]
Name: "{group}\HealthSharer"; Filename: "{app}\HealthSharer.exe"
Name: "{group}\File Processor"; Filename: "{app}\file-processor.exe"
Name: "{group}\IPFS"; Filename: "{app}\ipfs.exe"

[Registry]
; Set ASPNETCORE_ENVIRONMENT
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "ASPNETCORE_ENVIRONMENT"; ValueData: "Development"; Flags: preservestringtype

; Set MessageQueue_HostName
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "MessageQueue_HostName"; ValueData: "localhost"; Flags: preservestringtype

; Set MessageQueue_Username
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "MessageQueue_Username"; ValueData: "guest"; Flags: preservestringtype

; Set MessageQueue_Password
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "MessageQueue_Password"; ValueData: "guest"; Flags: preservestringtype

[Run]
; Uncomment these lines if you want to auto-run after install
; Filename: "{app}\ipfs.exe"; Description: "Run IPFS"; Flags: nowait postinstall skipifsilent
; Filename: "{app}\file-processor.exe"; Description: "Run File Processor"; Flags: nowait postinstall skipifsilent
; Filename: "{app}\HealthSharer.exe"; Description: "Run HealthSharer"; Flags: nowait postinstall skipifsilent