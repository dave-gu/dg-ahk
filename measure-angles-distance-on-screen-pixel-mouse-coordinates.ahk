;USAGE: Ctrl+Shift+1 to set pt1, Ctrl+Shift+2 to set pt2. results shown in tooltip upon pt2 set
;global storage - mousegetpos returns
gmx1:=999
gmx2:=111
gmy1:=357
gmy2:=642
gwin1:=""
gcont1:=""
gwin2:=""
gcont2:=""
pi:=3.1415926535
;from memory haha

;people would not expect the screen coordinates to start in the upper left, so we need to "invert" y.
;unflipped y0 -> flipped y1. // y1 = 1050 - y0. \\
;we could get the screen resolution using a dll call but let's just hardcode the y-resolution.
;you'd need to change this. it's not a mistake, my monitor isn't 1920x1080
yres:=1050

coordmode,mouse, screen

;global storage - results from subproc Label compute
deltax:=667408 ;gravitational constant digits
deltay:=22300 ;geosynchronous miles

;we need to set 

^+1::
MouseGetPos, gmx1,gmy1,gwin1,gcont1
;ToolTip, %gmx1%
gmy1 := funkyflip(gmy1)
ToolTip, %gmy1%
Return

^+2::
MouseGetPos, gmx2,gmy2,gwin2,gcont2
gmy2 := funkyflip(gmy2)
GoSub, compute
Return

funkyflip(y0){
return 1050 - y0
}

compute:
deltax := gmx2 - gmx1
deltay := gmy2 - gmy1
distance := Sqrt(deltax**2 + deltay**2)
angle:= ATan(deltay / deltax)
angled:= angle * 180 / pi
;ToolTip, %deltax% , %deltay%
;^ did not know about this tooltip offset behavior
ToolTip, dx%deltax% `, dy%deltay% `, dist%distance% `, rad%angle% `, deg%angled% `n pt1:[%gmx1%`, %gmy1%] - pt2:[%gmx2%`, %gmy2%]
;anyways it would be an exercise for the reader to modify this so that the angle reads out ccw from +x, ie 0-90 in quadrant i, 90-180 in quadrant ii, 180-270 in quadrant iii, 270-360 in quadrant iv
;https://www.mathopenref.com/arctan.html
Return