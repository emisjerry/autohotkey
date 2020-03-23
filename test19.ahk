#SingleInstance Force

#include d:\util\autohotkey\WinClipAPI.ahk
#include d:\util\autohotkey\WinClip.ahk

^+g::
  current_clipboard = %Clipboard%   ; 把目前的剪貼簿內容存起來供後面還原
  Send ^c   ; 把選取字串用〔Ctrl+C〕存入剪貼簿
  ClipWait,1
  ; 下行使用Google執行搜尋動作，要搜尋的字串就是剪貼簿內容
  Run http://www.google.com.tw/search?hl=zh-TW&q=%Clipboard%
  Clipboard = %current_clipboard%   ; 還原先前的剪貼簿內容
  return

; https://tw.dictionary.search.yahoo.com/search?p=flutter&fr=sfp&iscqry=
:O:,dic::https://tw.dictionary.search.yahoo.com/

^t::
  wc := new WinClip()
  wc.iCopy()   ; clear current inner buffer then send Ctrl+c
  t := wc.iGetText()
  ;MsgBox text=%t%
  Run https://tw.dictionary.search.yahoo.com/search?p=%t%&fr=sfp&iscqry=
  wc.iClear()
  return








