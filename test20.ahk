#SingleInstance Force
#include d:\util\autohotkey\WinClipAPI.ahk
#include d:\util\autohotkey\WinClip.ahk

^t::
  wc := new WinClip()
  wc.iCopy()   ; clear current inner buffer then send Ctrl+c
  _sSearch := wc.iGetText()
  translate(_sSearch)
  Return
  
translate(sSearch) {
  url := "https://tw.dictionary.search.yahoo.com/search?p=" . sSearch . "&fr=sfp&iscqry="

  httpClient := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  httpClient.Open("POST", url, false)  ; false=not async
  ;httpClient.SetRequestHeader("User-Agent", User-Agent)
  ;httpClient.SetRequestHeader("Content-Type", Content-Type)
  ;httpClient.SetRequestHeader("Cookie", Cookie)

  httpClient.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
  httpClient.Send()
  httpClient.WaitForResponse()
  Result := httpClient.ResponseText

  html := ComObjCreate("HTMLFile")
  html.write(Result)
  elements := html.getElementsByTagName("div") 

  _sPronounce := ""  ; 發音
  _sNotion := ""     ; 詞類
  _sDictionaryExplanation := ""  ; 解釋
  Loop % elements.length
  {
     ele := elements[A_Index-1] ; zero based collection
     _sClassName := ele.className
     if (InStr(_sClassName, "pos_button") > 0) {
       _sNotion := ele.innerText
     } else if (InStr(_sClassName, "compList d-ib") > 0) {
       _sPronounce := ele.innerText
     } else if (InStr(_sClassName, "dictionaryExplanation") > 0) {
       _sDictionaryExplanation .= _sNotion "`t" ele.innerText . "`r"
       _sNotion := ""
     }
  }
  MsgBox % sSearch  "`r`r"  _sPronounce  "`r----------`r" _sDictionaryExplanation
  return ""
}