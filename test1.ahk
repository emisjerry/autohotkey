#SingleInstance, force
    
:CO:,pc::電腦
:O:,tw::台灣
:*:,ks::高雄
:O:,addr::
    (
    台北市
    信義區
    信義路100號
    )
    
:*B0:<li>::</li>{left 5}
    
#n::Run notepad  ; Win+n

; 系統所有的右鍵功能表都變成新的設定了
;RButton::MsgBox 你按了滑鼠右鍵

; 系統的右鍵功能表與新的設定同時存在
;~RButton::MsgBox 你按了滑鼠右鍵

; 會不斷輸出 bcbcbcbcbcbcbc....
;a::Send abc

; 正常輸出 abc
;$a::Send abc

; 完全停用某個按鍵。下例停用{右Win}
>#::return
PrintScreen::return

^!f4::
  ; 把作用中(Active)的視窗類別存入變數 sClass
  WinGetClass, sClass, A
  ; 關閉相同的類別視窗
  while WinExist("ahk_class " . sClass) {
    WinClose
  }
  return

~LButton & Escape::
  WinGetActiveTitle, Title
  WinClose, %Title%
  return

~Backspace::
  WinGetClass,sClass,A
  WinGetTitle, sTitle, A
  ;;MsgBox $%sTitle%$,class=%sClass%
  ;;iTitle := InStr(sTitle, "Multi Commander")
  ;;MsgBox %iTitle%
  ;; FM=7-zip window, Afx:... is MultiCommander
  if (sClass="TFcFormMain" || sClass="FM" || InStr(sTitle, "Multi Commander") > 0) {
    Send, {BS}
  } else if (sClass="CabinetWClass" || sClass="#32770") {
    Send, !{up}
  } else if (sClass="MozillaWindowClass" || sClass="Chrome_WidgetWin_1" || InStr(sTitle, "Google Chrome") > 0) {
    WinGetTitle, sTitle, A
    ;;MsgBox title=%sTitle%
    if (InStr(sTitle, "Google+") >  || InStr(sTitle, "Gmail") > 0 || InStr(sTitle, "Facebook") > 0) {
      Send {j}
    } else if (InStr(sTitle, "Twitter") > 0) {
      Send {j}
    } else if (InStr(sTitle, "Google ") > 0) {
      Send {n}
    }
  } else {
    CoordMode, Mouse, Screen
    MouseGetPos, x, y, WinUnderMouseID
    ;WinActivate, ahk_id %WinUnderMouseID%
    ;Get y position relative to the bottom of the screen.
    yBottom := A_ScreenHeight - y
    ;;MsgBox %yBottom%
    ; Close taskbar program on middle click, if click on a taskbar icon
    if (yBottom <= 40) {
      BlockInput On
      Send, +{Click %x% %y% right} ;shift right click
      Sleep, 100
      Send, C ;send c which is Close All Windows
      WinWaitNotActive, ahk_class Shell_TrayWnd,, 0. ; wait for save dialog, etc
      if (ErrorLevel = 1)
        Send, {Escape} ;hides context menu if no program icon clicked.
      BlockInput Off
    }
  }
  return

#IfWinActive ahk_class Notepad
  ::,t1::輸出在Notepad
#IfWinActive
  ::,t1::輸出在其他的應用程式

#h::  ; Win+H 热键
; 获取当前选择的文本. 使用剪贴板代替
; "ControlGet Selected", 是因为它可以工作于更大范围的编辑器
; (即文字处理软件). 保存剪贴板当前的内容
; 以便在后面恢复. 尽管这里只能处理纯文本,
; 但总比没有好:
AutoTrim Off  ; 保留剪贴板中任何前导和尾随空白字符.
ClipboardOld := ClipboardAll
Clipboard := ""  ; 必须清空, 才能检测是否有效.
Send ^c
ClipWait 1
if ErrorLevel  ; ClipWait 超时.
    return
; 替换 CRLF 和/或 LF 为 `n 以便用于 "发送原始模式的" 热字串:
; 对其他任何在原始模式下可能出现问题
; 的字符进行相同的处理:
StringReplace, Hotstring, Clipboard, ``, ````, All  ; 首先进行此替换以避免和后面的操作冲突.
StringReplace, Hotstring, Hotstring, `r`n, ``r, All  ; 在 MS Word 等软件中中使用 `r 会比 `n 工作的更好.
StringReplace, Hotstring, Hotstring, `n, ``r, All
StringReplace, Hotstring, Hotstring, %A_Tab%, ``t, All
StringReplace, Hotstring, Hotstring, `;, ```;, All
Clipboard := ClipboardOld  ; 恢复剪贴板之前的内容.
; 这里会移动 InputBox 的光标到更人性化的位置:
SetTimer, MoveCaret, 10
; 显示 InputBox, 提供默认的热字串:
InputBox, Hotstring, New Hotstring, Type your abreviation at the indicated insertion point. You can also edit the replacement text if you wish.`n`nExample entry: :R:btw`::by the way,,,,,,,, :R:`::%Hotstring%
if ErrorLevel  ; 用户选择了取消.
    return
if InStr(Hotstring, ":R`:::")
{
    MsgBox You didn't provide an abbreviation. The hotstring has not been added.
    return
}
; 否则添加热字串并重新加载脚本:
FileAppend, `n%Hotstring%, %A_ScriptFullPath%  ; 在开始处放置 `n 以防文件末尾没有空行.
Reload
Sleep 200 ; 如果加载成功, reload 会在 Sleep 期间关闭当前实例, 所以永远不会执行到下面的语句.
MsgBox, 4,, The hotstring just added appears to be improperly formatted. Would you like to open the script for editing? Note that the bad hotstring is at the bottom of the script.
IfMsgBox, Yes, Edit
return

MoveCaret:
IfWinNotActive, New Hotstring
    return
; 否则移动 InputBox 中的光标到用户输入缩写的位置.
Send {Home}{Right 3}
SetTimer, MoveCaret, Off
return


:R:s11::中華民國基於三民主義，為民有民治民享之民主共和國。
:R:s12::第 2 條 中華民國之主權屬於國民全體。
:R:s13::第 3 條`r具有中華民國國籍者為中華民國國民。
:O:,ak::AutoHotkey