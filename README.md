# Disable Double Tap to Dodge Script
* [Introduction](#introduction)
* [Running The Script](#running-the-script)
* [Should something go wrong](#should-something-go-wrong)
## Introduction
Thank you to [u/TheKnoxFool](https://www.reddit.com/user/TheKnoxFool) and [u/Tehni](https://www.reddit.com/user/Tehni/) everyone else on this [thread](https://www.reddit.com/r/cyberpunkgame/comments/ka62x8/how_to_turn_off_doubletap_to_dodge_mkb/) for figuring out the fix for this issue.

I figured I'd automate disabling double tap to dodge and setting the doubletap key since I think others would benefit from having a script. I also don't know if the config will break after updates.

The script works by backing up and then modifying the two files responsible for Double Tap to Dodge and it's keybind. The two files are `inputUserMappings.xml`and `inputContexts.xml`.

Because I don't know a good place in the registry to find the Cyberpunk install path, providing it is required by the script. Also, the script automatically sets `Alt` as the new dodge button but you can set a different key by supplying the key to `-DodgeKey`, the value supplied is added to the line `<button id="IK_$DodgeKey" />` where `$DodgeKey` gets replaced with what you supply.

I would wrap this up as an EXE and maybe have a textbox for the key but I don't really want to go through the trouble right now. I'm hoping that I wrote this guide in a way anyone will be able to follow it but I might come back and make it an exe.

## Running the script

Download the script [here](/Disable_Double_Tap_To_Dodge.ps1).

1. Open up PowerShell, there are a number of ways to do this but the easier method is hitting "Win" + "X" on your keyboard and selecting PowerShell.
    * Please note you may need to run as Administrator depending on where Cyberpunk is installed.

2. Once in PowerShell run the command below
    * The command allows us to run scripts but only in this PowerShell session, so once you close the PowerShell window will need to run this command again.
```powershell
Set-ExecutionPolicy Bypass -Scope Process
```
3. Go to the `Cyberpunk 2077` parent directory.
4. While holding "Shift", Right Click the `Cyberpunk 2077` folder.

5. Select `Copy as path`

![Copy As Path](/src/CopyAsPath.png)

6. Run the script using the command below replacing everything inside the `<>` brackets with the path we copied.
    * Depending on where your downloads save to the next command can change. I have my script downloaded to `C:\Users\<Username>\Downloads` so the command I used uses the `~` key which acts as an alias to my home folder.
```powershell
& ~\Downloads\Disable_Double_Tap_To_Dodge.ps1 -InstallPath <Right Click to Paste Path>
```
![Run PowerShell Script](/src/RunPowerShellScript.png)
7. Should I want the dodge button to be my Left Shift key I would use the following command instead.
```powershell
& ~\Downloads\Disable_Double_Tap_To_Dodge.ps1 -InstallPath <Right Click to Paste Path> -DodgeKey "LShift"
```

---
### Should something go wrong
1. Delete `inputUserMappings.xml`and `inputContexts.xml`
2. Rename `inputUserMappings.xml.bak`and `inputContexts.xml.bak` without the `.bak` extension.
    * This will reset the configuration back to default.