rem
rem this bat file will set up the required permissions to use ssh on windows
rem when ssh-keygen is used the create the key pair the correct permissions are assigned but when
rem downloaded from EC2 (and Azure) they are just text files and their permissions can be too broad to use
rem my experiments have shown using the directly downloaded private key file is ok, it's when you copy that key file
rem the permissions become too broad
rem https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc753525(v=ws.11) and
rem https://superuser.com/questions/322423/explain-the-output-of-icacls-exe-line-by-line-item-by-item have some starter information
rem

rem we need to remove inheritance from the permissions set
icacls  %1 /inheritance:d

rem remove the permissions that are too broad
icacls  %1 /remove:g BUILTIN\Users
icacls  %1 /remove:g "NT AUTHORITY\Authenticated Users"

rem these 2 permissions are left intact when ssh-keygen is used, but if they cause trouble, remove the rem at the start 

rem icacls  %1 /remove:g BUILTIN\Administrators
rem icacls  %1 /remove:g "NT AUTHORITY\SYSTEM"

rem ssh-keygen gives explicit permissions to the current user. This looks not to be needed but for consistency I'll leave it in
icacls  %1 /grant %USERNAME%:(M)

rem what ya got ?
icacls %1
