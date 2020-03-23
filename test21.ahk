#SingleInstance Force

#include d:\util\autohotkey\WinClipAPI.ahk
#include d:\util\autohotkey\WinClip.ahk

;; C:\Windows should change to %A_WinDir% for better compatibility.
;; r=rectangle 矩形剪取
^+4::
  run, "%A_WinDir%\system32\SnippingTool.exe"
  Sleep, 500
  WinActivate, "Snipping Tool"
  send, !m
  send, r
  Return

;; w=window 視窗剪取
^+5::
  run, "C:\Windows\system32\SnippingTool.exe"
  Sleep, 500
  WinActivate, "Snipping Tool"
  send, !m
  send, w
  Return

;; f=free-hand 任意剪取
^+6::
  run, "C:\Windows\system32\SnippingTool.exe"
  Sleep, 500
  WinActivate, "Snipping Tool"
  send, !m
  send, f
  Return

;; s=screen 全螢幕剪取
^+7::
  run, "C:\Windows\system32\SnippingTool.exe"
  Sleep, 500
  WinActivate, "Snipping Tool"
  send, !m
  send, s
  Return

^+0::
  RunWait "C:\Windows\system32\SnippingTool.exe" /clip
  ;圖檔檔名: SCREEN-年月日-時分秒.png
  imageFile = c:\temp\SCREEN-%A_YYYY%%A_MM%%A_DD%-%A_Hour%%A_Min%%A_Sec%.png
  ;SaveBitmap第2個參數選項：bmp,jpeg,gif,tiff,png
  WinClip.SaveBitmap(imageFile, "png")
  ;run, %imageFile%
  run, mspaint %imageFile%
  Return





