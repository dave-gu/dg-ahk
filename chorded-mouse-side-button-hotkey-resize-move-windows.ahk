SetTitleMatchMode, 2
;Changes the Title match mode to match rather than exact

MakeChord("LButton","XButton1","MoveIt")
MakeChord("LButton","XButton2","SizeBR")
;on my mouse (Logitech G400S which is mx518 / g5 styled) there are two side buttons
;XButton2 is the forwards button and XButton1 is the back button
;to trigger the Resize, hit XButton2 first and then LButton (the left mouse button)
;likewise to trigger the Move, hit XButton1 first and then LButton (the left mouse button)

MakeChord("RButton","XButton1","Trans1")
MakeChord("RButton","XButton2","Trans2")
;based on the above info its pretty easy to try to understand how to use these transparency options
SetKeyDelay(70)
;this is specific to the chord.ahk... the line #include, chord.ahk is present later.

gT:="t"
gW:=2
gH:=3
gX:=4
gY:=5

#IfWinActive cmd.exe
;paste in cmd prompt with normal Ctrl+V shortcut
^v::
CoordMode, Mouse, Relative
WinGetActiveStats, gT,gW,gH,gX,gY
MouseMove, gW-75,gH-50,0
Sleep 20
Send {RButton}
Send p
Return

#IfWinActive chrome
XButton2::
tooltip, whoops
sleep 800
tooltip,
Return
;if you're doing something serious in the browser you'd better not accidentally hit the back button.

#IfWinActive
;resets IfWinActive to apply to anything

MoveIt:
Send !{Space}r
sleep 30
Send !{Space}m
Sleep 30
Send {Up}
Return
SizeBR:
Send !{Space}r
Sleep 30
Send !{Space}s
Sleep 30
Send {down}{right}
Return
#include, chord.ahk

Trans1:
WinSet, Trans, 200, A
Return

Trans2:
WinSet, Trans, 255, A
Return