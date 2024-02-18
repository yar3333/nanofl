[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CAEA4425-C437-48AD-8F0D-72F88D066D6D}
AppName=NanoFL
AppVersion={#VERSION}
AppVerName=NanoFL {#VERSION}
AppPublisher=nanofl.com
AppPublisherURL=http://nanofl.com/
AppSupportURL=http://nanofl.com/
AppUpdatesURL=http://nanofl.com/
DefaultDirName={pf}\NanoFL
DefaultGroupName=
LicenseFile=C:\MyProg\NanoFL\installer\license_free.rtf
OutputDir=C:\MyProg\NanoFL\installer\bin
OutputBaseFilename=nanofl-{#VERSION}
Compression=lzma
SolidCompression=yes
DisableWelcomePage=no
DisableDirPage=no
DisableProgramGroupPage=yes
DisableReadyPage=yes
PrivilegesRequired=admin
UninstallDisplayIcon={app}\NanoFL.exe
ChangesAssociations=yes
ChangesEnvironment=true

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: desktopicon;      Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}
Name: startmenuicon;    Description: "Create a Start Menu icon"; GroupDescription: {cm:AdditionalIcons}
Name: nflAssociation;   Description: "Associate NanoFL with documents (*.nfl; *.nflz)"; GroupDescription: "Additional tasks"
Name: jsnfAssociation;  Description: "Associate NanoFL with script files (*.jsnf)"; GroupDescription: "Additional tasks"
Name: svgAssociation;   Description: "Associate NanoFL with SVG files (*.svg)"; GroupDescription: "Additional tasks"; flags: unchecked
Name: modifypath;       Description: "Add application directory to the PATH"; GroupDescription: "Additional tasks"; flags: unchecked

[Files]
Source: "C:\MyProg\NanoFL\ide\bin\*"; DestDir: "{app}"; Flags: ignoreversion createallsubdirs recursesubdirs; MinVersion: 0,5.0; Languages: english; Excludes: "\examples"
Source: "C:\MyProg\NanoFL\ide\bin\examples\*"; DestDir: "{userdocs}\NanoFL\Examples"; Flags: ignoreversion createallsubdirs recursesubdirs; MinVersion: 0,5.0; Languages: english

[Icons]
Name: "{commonstartmenu}\NanoFL"; Filename: "{app}\NanoFL.exe"; IconFilename: "{app}\NanoFL.exe"
Name: "{commondesktop}\NanoFL"; Filename: "{app}\NanoFL.exe"; IconFilename: "{app}\NanoFL.exe"; Tasks: desktopicon

[Registry]
Root: HKCR; Subkey: ".nfl"; ValueType: string; ValueName: ""; ValueData: "NanoFL.Document"; Flags: uninsdeletevalue; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.Document"; ValueType: string; ValueName: ""; ValueData: "Document"; Flags: uninsdeletekey; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.Document\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\NanoFL.exe,0"; Flags: uninsdeletekey; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.Document\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\NanoFL.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: nflAssociation

Root: HKCR; Subkey: ".nflz"; ValueType: string; ValueName: ""; ValueData: "NanoFL.ZippedDocument"; Flags: uninsdeletevalue; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.ZippedDocument"; ValueType: string; ValueName: ""; ValueData: "ZippedDocument"; Flags: uninsdeletekey; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.ZippedDocument\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\NanoFL.exe,0"; Flags: uninsdeletekey; Tasks: nflAssociation
Root: HKCR; Subkey: "NanoFL.ZippedDocument\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\NanoFL.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: nflAssociation

Root: HKCR; Subkey: ".jsnf"; ValueType: string; ValueName: ""; ValueData: "NanoFL.Script"; Flags: uninsdeletevalue; Tasks: jsnfAssociation
Root: HKCR; Subkey: "NanoFL.Script"; ValueType: string; ValueName: ""; ValueData: "Script"; Flags: uninsdeletekey; Tasks: jsnfAssociation
Root: HKCR; Subkey: "NanoFL.Script\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\NanoFL.exe,0"; Flags: uninsdeletekey; Tasks: jsnfAssociation
Root: HKCR; Subkey: "NanoFL.Script\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\NanoFL.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: jsnfAssociation

Root: HKCR; Subkey: ".svg"; ValueType: string; ValueName: ""; ValueData: "NanoFL.SVG"; Flags: uninsdeletevalue; Tasks: svgAssociation
Root: HKCR; Subkey: "NanoFL.SVG"; ValueType: string; ValueName: ""; ValueData: "Scalable Vector Graphics"; Flags: uninsdeletekey; Tasks: svgAssociation
Root: HKCR; Subkey: "NanoFL.SVG\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\NanoFL.exe,0"; Flags: uninsdeletekey; Tasks: svgAssociation
Root: HKCR; Subkey: "NanoFL.SVG\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\NanoFL.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: svgAssociation

Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\NanoFL.exe"; ValueType: string; ValueName: ""; ValueData: """{app}\NanoFL.exe"""; Flags: uninsdeletekey


[Code]
const
	ModPathName = 'modifypath';
	ModPathType = 'system';

function ModPathDir(): TArrayOfString;
begin
	setArrayLength(Result, 1)
	Result[0] := ExpandConstant('{app}');
end;
#include "modpath.iss"