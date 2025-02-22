## About
This repo contains code, that allows you to configure a unattended Windows 11 install, with custom settings as well as preinstalled packages. This means the only thing you need to do is to boot from your installation medium, after that the windows install as well as package installs will run without any user input.

## Prerequisites
You need a Windows 11 installation medium. (e.g. download the iso here: [https://www.microsoft.com/de-de/software-download/windows11](https://www.microsoft.com/de-de/software-download/windows11) and then flash a usb stick with rufus: [https://rufus.ie/en/](https://rufus.ie/en/)). The installation medium needs to have the drive letter D, as some paths are hardcoded as of now.

## Configuration
### Package Installation with winget (preferred)
1. You can specify packages you want to be installed with winget in the packages.yaml file. This requires the package to be available in the winget repository. You can search for packages here: [https://winget.run/](https://winget.run/). Once you found your package you can add the package to the package.yaml file in the following format:
```
packages:
  yourpackagename:
    id: WingetId
    option1: value
    option2: value
    ...
```
`yourpackagename` can be any string, it is just for display purpose during the installtion process. The `id` needs to be a valid winget id. You can find the id by searching the winget repository with the link above. They normaly consist of the publisher and the name of the programm e.g. `Mozilla.Firefox`. The options can include any winget install options. See: [https://learn.microsoft.com/en-us/windows/package-manager/winget/install](https://learn.microsoft.com/en-us/windows/package-manager/winget/install) If you do not specify any options, the default values located in the package.yaml will be used. The defaults are set to install the package silently and machine wide. This is mostly fine, however there are some exceptions. Some packages can not be installed machine wide and will fail to install if you try to install the system wide. Also packages will install with default settings. In most cases you can change/add these these settings later on, however, in some cases packages will default to install additional bloatware (e.g. Teamspeak) or will have settings that can not be changed after install. In this case you might prefer to set the `interactive: true` option. This requires user input tho.

### Package Installation from a local Installer
TODO

### Windows Answer File
To install windows silently, a so called answer file is required. This answer file includes all the settings that you would normaly set during installation, e.g. language or user accounts. You can either manually edit the answer file or use a generator e.g. [https://schneegans.de/windows/unattend-generator/](https://schneegans.de/windows/unattend-generator/). Be aware, that some settings need to reflect the Windows Image you downloaded as well as your target. If you downloaded a Windows Image with the german language pack, you can not set the language in the answer file to anything else than german for example. If you have a PC with an UEFI BIOS, you need to use GPT as your partition layout... If your Windows installation fails, most likely your answer file is faulty. The included answer file is a good starting point if you want a fully unattended german install targeting a UEFI BIOS. If you just want to adjust some settings, or create additional users, you can use the included answer file as a base by clicking this [link](https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=de-DE&Locale=de-DE&Keyboard=00000407&GeoLocation=94&ProcessorArchitecture=amd64&ComputerNameMode=Random&CompactOsMode=Default&TimeZoneMode=Implicit&PartitionMode=Unattended&PartitionLayout=GPT&EspSize=300&RecoveryMode=Partition&RecoverySize=1000&WindowsEditionMode=Generic&WindowsEdition=pro&UserAccountMode=Unattended&AccountName0=Admin&AccountDisplayName0=&AccountPassword0=%21Perlio123&AccountGroup0=Administrators&AccountName1=baltic&AccountDisplayName1=Baltic&AccountPassword1=baltic1%21&AccountGroup1=Administrators&AccountName2=&AccountName3=&AccountName4=&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=Hidden&TaskbarSearch=Box&TaskbarIconsMode=Default&StartTilesMode=Default&StartPinsMode=Default&AllowPowerShellScripts=true&EffectsMode=Default&DesktopIconsMode=Default&WifiMode=Skip&ExpressSettings=DisableAll&KeysMode=Skip&ColorMode=Default&WallpaperMode=Script&WallpaperScript=%23+Photo+by+Jess+Loiterton%3A+https%3A%2F%2Fwww.pexels.com%2Fphoto%2Fmountains-and-beach-under-dramatic-sky-5007737%2F%0D%0A%24url+%3D+%27https%3A%2F%2Fimages.pexels.com%2Fphotos%2F5007737%2Fpexels-photo-5007737.jpeg%27%3B%0D%0Areturn+%28+Invoke-WebRequest+-Uri+%24url+-UseBasicParsing+-TimeoutSec+30+%29.Content%3B&FirstLogonScript1=powershell.exe+-WindowStyle+Normal+-NoProfile+-Command+%22Get-Content+-LiteralPath+%27D%3A%5Cautounattend-after-install.ps1%27+-Raw+%7C+Invoke-Expression%3B%22&FirstLogonScriptType1=Ps1&WdacMode=Skip). If you want to create you own answer file from scratch and use the package installer etc., you need to include the following command in your `unattend-01.ps1` file: `powershell.exe -WindowStyle Normal -NoProfile -Command "Get-Content -LiteralPath 'D:\autounattend-after-install.ps1' -Raw | Invoke-Expression;"`.
	

### Windows Settings
TODO

### Windows Updates and Drivers
After installing Windows, the script will automatically install Windows Updates and Drivers. If needed it will restart the PC automatically.


## Installation
Once you are done with configuration and have a Windwos 11 installation medium, you need to pull all the files in the root directory of your installation medium. Then you just need to plug the medium into the pc, boot from it and sit back. Be aware, that once you boot from the medium it will wipe your entire disk without any further user interaction. YOU SHOULD NEVER plug the medium into a computer at boot time, that you dont want to wipe. Depending on your BIOS settings, the medium might boot, even if you did not choose it explicity. TODO: Have at least one confirmation screen asking the user if he is sure he wants to wipe his pc, to prevent accidential wipes. During installation a powershell window is open, giving some basic information about the current state. The install process is completed, once the window close. In there are updates to install, which is almost always the case after a fresh install, the computer will reboot automatically and you will be greeted with a login screen.
