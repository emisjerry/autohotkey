#SingleInstance Force

/*
儲存格式：
1=原始檔名
2=日期-時間
3=日期-計數器
*/
sSaveFormat := "2"
sSaveDir := "z:\pic"  ;; 儲存資料夾
sFileExt := ".png"  ;; 副檔名
isDisplay := true  ;; 是否顯示下載後圖片
iCounter := 0

MButton::
`::
  Send {RButton}
  Send {O}
  sImageURL = %Clipboard%
  iPos := InStr(sImageURL, "/", false, -1)
  if (sSaveFormat = "1" && iPos > 0) {
    sFilename := SubStr(sImageURL, iPos+1, 30)
    iPos := InStr(sFilename, ".")
    sFilename := SubStr(sFilename, 1, iPos-1)
    
    iPos := InStr(sFilename, "?")
    if (iPos > 0) {
      sFilename := SubStr(sFilename, 1, iPos-1)
    }
  } else if (sSaveFormat = "2") {
    sFileExt := getFileExt(sFilename)
    sFilename = %A_YYYY%%A_MM%%A_DD%-%A_Hour%%A_Min%%A_Sec%%sFileExt%
  } else if (sSaveFormat = "3") {
    iCounter++
    sFilename = %A_YYYY%%A_MM%%A_DD%-%iCounter%%sFileExt%
  }
  ;;MsgBox sFilename=%sFilename%, URL=%sImageURL%
  UrlDownloadToFile, %sImageURL%, %sSaveDir%\%sFilename%
  if errorlevel {
    msgbox 圖片下載失敗 (Error: %errorlevel%)
  } else {
    if (isDisplay) {
      displayImage(sSaveDir . "\" . sFilename)
    }
  }
  Return

;; 顯示圖片小視窗
displayImage(sFilename) {
  Gui, New
  Gui, Add, Text,, %sFilename%
  Gui, Add, Picture, w256 h256, %sFilename%
  Gui, Show
  Return
}

;; 傳回副檔名
getFileExt(sFileName) {
  iPos := InStr(sFileName, ".jpg")
  if (iPos > 0) Return ".png"
  iPos := InStr(sFileName, ".gif")
  if (iPos > 0) Return ".gif"
  
  Return ".png"
}