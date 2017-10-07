#Include %A_ScriptDir%
#SingleInstance, Force
#NoEnv
#Persistent
SetTitleMatchMode, 2
SetBatchLines, -1
DetectHiddenWindows, on
DetectHiddenText, on



Gui, Stek:New, +AlwaysOnTop -Caption +ToolWindow +LastFound +Disabled
WinSet, Transcolor, 000999 255,
Gui, Stek:Color, 000999
Gui, Stek:Add, Picture, x30 y338 w260 h-1 Background000999, %A_ScriptDir%\Ўл€па(визор).png
Gui, Stek:Show, x1345 y580 w293 h800 , Losos1 


Gui, 12:New, +AlwaysOnTop -Caption +ToolWindow +LastFound
;Gui, 12:Add, Text,,PP
WinSet, Transcolor, 000992 255,
Gui, 12:Color, 000992
Gui, 12:Add, Progress, x40 y230 w242 h65 cRed Background000992 vBarr
Gui, 12:Font, s25 Bold, Headliner No. 45
Gui, 12:Add, Text, x0 y120 vTT cred w150
Gui, 12:Show, x1345 y680 w293 h480, Losos12



Img = %A_ScriptDir%\7.GIF



Gui, 34:New,+AlwaysOnTop -Caption +ToolWindow +LastFound +Disabled
hwnd := WinExist()
WinSet, TransColor, 474747 255,
Gui, 34:Color, 474747
Gui, 34:Add, Picture, x0 y100 w293 h-1 Background474747, %A_ScriptDir%\Ўл€па.png
Gui, 34:Show, x1345 y680 w293 h800, Losos34



Gui, 35:New,+AlwaysOnTop -Caption +ToolWindow +LastFound +Disabled
WinSet, TransColor, 484848 255,
Gui, 35:Color,  484848
Gui, 35:Add, Picture, x1020 y100 w50 h-1 Background484848 vPict, %A_ScriptDir%\tm.png
Gui, 35:Add, Picture, x960 y110 w50 h-1 Background484848 vPict1, %A_ScriptDir%\z.png
Gui, 35:Add, Picture, x1083 y120 w40 h-1 Background484848 vPict2, %A_ScriptDir%\r2.png
Gui, 35:Add, Picture, x1025 y160 w40 h-1 Background484848 vPict3, %A_ScriptDir%\x.png
GuiControl, 35:Hide, pict3
Gui, 35:Add, Progress, x317 y325 w400 h5 c990066 Background484848 vZarr2
Gui, 35:Show, x445 y680 w1300 h400, Losos35
   


Gui 32:New, +HwndhGUI +AlwaysOnTop -Caption +ToolWindow +LastFound 
Gui, 32:Color, A2ADD0
gif1 := AnimatedGif( hGUI, Img, 90, 325, 50, 50, "A2ADD0", "MyGif", "myGif_" )
WinSet, Transcolor, A2ADD0 255,
Gui 32:Show, x1269 y679 hide, Losos32

return

ButtonStart:
Gui, Submit, NoHide
;Gui, Destroy


m1:=Edit2*60
s1:=Edit3
tm:=120 ;m1+s1


Restart:
SoundBeep, 450, 100
	Gui, 55:-Caption +ToolWindow +AlwaysOnTop +Lastfound
	Gui, 55:Color, 000333
	Gui, 55:Font, s50, Headliner No. 45 
	Gui, 55:Add, Text, x60 y80 vKrug cFFD700 w25
	Gui, 55:Add, Text, x180 y80 vFarrsum cFFD700 w100
	WinSet, Transcolor, 000333 255,
	Gui, 55:Show, x1350 y750, Losos55 

	Gui, 2:-Caption +ToolWindow +AlwaysOnTop +Lastfound
	Gui, 2:Color, 000111
	Gui, 2:Font, s47, Headliner No. 45
	Gui, 2:Add, Text, x45 y50 cred w700
	WinSet, Transcolor, 000111,
	Gui, 2:Show, x1375 y935 NA, Losos2
	
Loop
{
	Lap := 1001
	Farrsum := 0
	Startishe:
	Start := A_TickCount
	GuiControl, 55:, Static1, % Krug := (Lap - 1000)// 2
	GuiControl, 55:, Static2, % Farrsum
	GuiControl, 35:, Zarr2, %Farrsum% * 5
	Timer:
		GuiControl, 2:, Static1, % Format(Rest := tm - ((A_TickCount - Start)// 1000))
		SetTimer, % Rest <= 0 ? "Hide" : "Timer", % "-" (999 - A_MSec) + 100
		GuiControl, 12: +Range-%tm%-0, Barr
		GuiControl, 12:, Barr, -%Rest%
		
		
		
		If Lap in 1002,1004,1006,1008,1010,1012,1014
			{
			if (Rest = 45)
			SoundBeep, 750, 300
			if (Rest = 1)
			SoundBeep, 750, 750
			}
		Else
			{
			if (Rest = tm)
				Gui 32:Show, NA
			if (Rest = 2)
				Gui 32:Show, Hide
			if (Rest = 1)
				SoundPlay, %A_ScriptDir%\pip.mp3
			}
		Return
	Hide:
		Lap++
		List := {1002: 300, 1003:300, 1004:210, 1005:202, 1006:150, 1007:90, 1008:120, 1009:90, 1010:120, 1:.4, 2:.6, 3:.8, 4:1, 5:3, 6:5, 7:7, 8:11}
		if List.HasKey(Lap)
		tm := List[Lap]
		If List.HasKey(Krug)
		Farrsum := List[Krug]
		Goto Startishe
		Return
	Format(NumberOfSeconds)
	{
    time = 19990101
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
	}
}
Return


AnimatedGif( ByRef guiHwnd, Image, X, Y, W, H, BackgroundColor:="White", Id:="AnimatedGif", eventHandler:="" ) {
	if BackgroundColor in system
	{
		A_FI := A_FormatInteger
		SetFormat Integer, Hex
		BGR := DllCall( "GetSysColor", Int, 15 ) + 0x1000000
		SetFormat Integer, %A_FI%
		StringMid R, BGR, 8, 2
		StringMid G, BGR, 6, 2
		StringMid B, BGR, 4, 2
		BackgroundColor := R G B
		StringUpper BackgroundColor, BackgroundColor
		BackgroundColor := "#" BackgroundColor
	}
	Gui %guiHwnd%:Add, ActiveX, x%X% y%Y% w%W% h%H% +HwndGifHwnd, MSHTML:
	GuiControlGet HtmlObj, %guiHwnd%:, %GifHwnd%
	HtmlObj.parentWindow.execScript( "document.oncontextmenu = function(){return false;}" )
	HtmlObj.Body.style.BackgroundColor := BackgroundColor
	HtmlObj.Body.style.margin := 0
	HtmlObj.Body.style.padding := 0
	out := HtmlObj.createElement( "img" )
	out.id := Id
	out.src := Image
	out.style.position := "absolute"
	out.style.left := 0
	out.style.top := 0
	out.style.width := "100%"
	out.style.height := "100%"
	out.style.minWidth := "100%"
	out.style.minHeight := "100%"
	out.style.visibility := "visible"
	HtmlObj.Body.appendChild( out )
	if eventHandler
		ComObjConnect( out, eventHandler )
	return out
}




return

vk09 & vk0d::goto ButtonStart
!F8::     ;GuiControl,  (u := !u) ? "Show" : "hide" , Losos

!F6:: Msgbox % (u := !u) ? "Hide" : ""



Gui, stek: Show, %u%
Gui, 12: Show, %u%
Gui, 34: Show, %u%
Gui, 35: Show, %u%
Gui, 32: Show, %u%
Gui, 55: Show, %u%







!f7::Gui, 34:destroy
!F9::Reload
!F10::
GuiEscape:
GuiClose:
ButtonCancel:
ExitApp