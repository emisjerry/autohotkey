#SingleInstance Force

!NumpadAdd:: Send {Volume_Up} ;//Alt + numpad plus
!NumpadSub:: Send {Volume_Down} ;//Alt + numpad minus
!Numpad0::Send {Volume_Mute} ;//Alt + numpad 0 

~MButton::
  WinGetClass,sClass,A
  ;//MsgBox class=%sClass%
  ;//FM=7-zip window, TFcFormMain=FreeCommander
  if (sClass="TFcFormMain" || sClass="FM" || sClass="MultiCommander MainWnd") {
    Send, {BS}
  } else if (sClass="CabinetWClass") {
    Send, !{up}
  } else if (sClass="MozillaWindowClass" || sClass="Chrome_WidgetWin_1") {
    WinGetTitle, sTitle, A
    ;//MsgBox title=%sTitle%
    if (InStr(sTitle, "Gmail") > 0) {
      Send {j}
    } else if (InStr(sTitle, "Twitter") > 0) {
      Send {j}
    }
  } 
  return

~+MButton::
  WinGetClass,sClass,A
  ;//MsgBox $%sClass%$
  if (sClass = "MozillaWindowClass" || sClass="Chrome_WidgetWin_1") {
    WinGetTitle, sTitle, A
    if (InStr(sTitle, "Gmail") > 0 || InStr(sTitle, "Facebook") > 0) {
      Send {k}
    } else if (InStr(sTitle, "Twitter") > 0) {
      Send {k}
    }
  }
  return
  
!a::
  MouseGetPos, MouseX, MouseY
  PixelGetColor, color, %MouseX%, %MouseY%, RGB  
  Clipboard := "#" . SubStr(color, 3)
  MsgBox, Current color is `n %Clipboard%
  return
  
!F12::
  date = %A_YYYY%年%A_MM%月%A_DD%日
  Speak("今天日期是 " . date)
  time = %A_Hour%點 %A_Min%分 %A_Sec%秒
  Speak("現在時間是 " . time)
  return

Speak(say) {
  spovice:=ComObjCreate("sapi.spvoice")
  spovice.Speak(say)
}
  
