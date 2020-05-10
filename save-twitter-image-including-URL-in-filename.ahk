clipboardvar := Clipboard
controldirectory:= "D:\downloab\twittermeta\"
MyEditsPath:= " "
SetTitleMatchMode, 2
;Remember - the best editor for autohotkey is SciTE4AutoHotkey
;Ctrl Shift Tilde/Backtick. this is the only active hotkey in this file.
^+~::
;GoSub, saveimage
GoSub, saveimagenodir
Return
;To configure the F5 -> Go functionality you need to go to Options - ahk.properties
;and configure the line similarly "AutoHotkeyDir=C:\autohotkey"
;and also set the line similarly: command.go.$(file.patterns.ahk)="$(AutoHotkeyDir)\AutoHotkey.exe" /ErrorStdOut "$(FileNameExt)"
;What does the script do?
;If you are viewing an image on twitter in the expanded view
;the URL shows similarly to https://twitter.com/username24680/status/6789345012789456321/photo/1
;On my system at least, this will copy the url, begin saving the image, and set the filename to
;in this case username24680-6789345012789456321
;and then wait for you to confirm. i would usually postfix something like "=cat" so that i can find images with a certain subject
;later you would be able to relocate the source of the image from the info in the filename.
ProcString(clips)
{
theclipboard = %clips%
;MsgBox, %theclipboard%
position1:= 0
position1:= instr(theclipboard, "/",False, 9)
;MsgBox, %position1%
len1 := StrLen(theclipboard)
position2:= len1 - position1
theclipboard := SubStr(theclipboard,position1,position2)
;MsgBox, %theclipboard%
len2 := StrLen(theclipboard)
theclipboard := SubStr(theclipboard,2)
;MsgBox %theclipboard%
theclipboard := StrReplace(theclipboard,"/status/","-")
theclipboard := StrReplace(theclipboard,"photo","")
theclipboard := StrReplace(theclipboard,"/","")
;MsgBox %theclipboard%
return theclipboard
}

saveimage:
;assumes mouse is over image and focused on browser window
SendPlay !d
Sleep 100
SendPlay ^c
Sleep 100
thisvar := clipboard
Sleep 100
thisvarproc := ProcString(thisvar)
Sleep 100
SendPlay {RButton}
Sleep 100
SendPlay v
Sleep 100
SendPlay {Home}
Sleep 100
clipboard := controldirectory
Sleep 100
SendPlay ^v
Sleep 100
clipboard := thisvarproc
Sleep 100
SendPlay ^v
Sleep 100
Return

saveimagenodir:
;assumes mouse is over image and focused on browser window
SendPlay !d
Sleep 100
SendPlay ^c
Sleep 100
thisvar := clipboard
Sleep 100
thisvarproc := ProcString(thisvar)
Sleep 100
SendPlay {RButton}
Sleep 100
SendPlay v
Sleep 100
SendPlay {Home}
Sleep 100
clipboard := controldirectory
Sleep 100
;SendPlay ^v
;nodir^
Sleep 100
clipboard := thisvarproc
Sleep 100
SendPlay ^v
Sleep 100
Return

openimage:
SendPlay !{Appskey}
;SendPlay aa{Enter} ;now path is copied
SendPlay a
Sleep 30
filepath := clipboard
Sleep 50
SendPlay !d
Sleep 30
SendPlay ^c
Sleep 30
directorypath := clipboard
filepath := StrReplace(filepath, """", "")
MsgBox, %filepath%
filepath := StrReplace(filepath, directorypath, "")
MsgBox, %filepath%
Return
/*
delete the properties dialog method
openimage:
SendPlay {AppsKey}
Sleep 150
SendPlay r
Sleep 300
SendPlay !{Tab}
Sleep 60
SendPlay !{Tab} ;goes to the filename portion of properties window
Sleep 60
SendPlay ^c ;now clipboard has it
Sleep 100
clipdump1 := clipboard
dashlocation := instr(clipdump1, "-",False,0)
userhandle := substr(clipdump1,1,dashlocation - 1)

MsgBox, %dashlocation% " " %userhandle%

Return
*/
;segment the clipboard variable into the desired username and statusnumber strings
Return

ButtonOK:
Gui, Submit
GuiControlGet, controldirectory
MsgBox, %controldirectory%
MsgBox, %MyEditsPath%
Return

GuiClose:
Gui, Submit
GuiControlGet, controldirectory
MsgBox, %controldirectory%
Return

configure:
;Gui, Wumbo:New
;Gui, Wumbo:Add, Text,, Path to save to:
;Gui, Wumbo:Add, Edit, vMyEditsPath
;Gui, Wumbo:Add, Button, default, OK
;Gui, Wumbo:Show
Gui,New
Gui,Add, Text,, Path to save to:
Gui,Add, Edit, vMyEditsPath
Gui,Add, Button, default, OK
Gui,Show
Return