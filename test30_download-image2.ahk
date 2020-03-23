#SingleInstance Force

/*
儲存格式：
1=原始檔名
2=日期-時間
3=日期-計數器
*/
sSaveFormat := "2"
sSaveDir := "z:\pic"  ;; 儲存資料夾
isDisplay := true  ;; 是否顯示存檔圖片視窗
iCounter := 0

MButton::
`::
  Send {RButton}
  Send {O}
  ClipWait 5
  sImageURL = %Clipboard%
  Clipboard := ""
  isDataImage := false
  iPos := InStr(sImageURL, "data:image/")
  if (iPos > 0) {  ;; 圖片資料字串, 存檔格式固定為 2
    isImageData := true
    sFilename = %A_YYYY%%A_MM%%A_DD%-%A_Hour%%A_Min%%A_Sec%.jpg
    Base64ImageData := Substr(sImageURL, 24, StrLen(sImageURL))  ;; skip data:image/jpeg;base64,
    nBytes := Base64Dec( Base64ImageData, Bin )
    File := FileOpen(sSaveDir . "\" . sFilename, "w")
    File.RawWrite(Bin, nBytes)
    File.Close()
    if (isDisplay) {
      displayImage(sSaveDir . "\" . sFilename)
    }
    Return 
  } else {
    iPos := InStr(sImageURL, "/", false, -1)
  }
  if (sSaveFormat = "1" && iPos > 0) {
    sFilename := SubStr(sImageURL, iPos+1, 30)
    iPos := InStr(sFilename, ".")
    sFilename := SubStr(sFilename, 1, iPos-1)
    
    iPos := InStr(sFilename, "?")
    if (iPos > 0) {
      sFilename := SubStr(sFilename, 1, iPos-1)
    }
  } else if (sSaveFormat = "2") {
    sFilename = %A_YYYY%%A_MM%%A_DD%-%A_Hour%%A_Min%%A_Sec%.jpg
  } else if (sSaveFormat = "3") {
    iCounter++
    sFilename = %A_YYYY%%A_MM%%A_DD%-%iCounter%.jpg
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

displayImage(sFilename) {
  Gui, New
  Gui, Add, Picture, w256 h256, %sFilename%
  Gui, Show
  Return
}

Base64Dec( ByRef B64, ByRef Bin ) {  ; By SKAN / 18-Aug-2017
Local Rqd := 0, BLen := StrLen(B64)                 ; CRYPT_STRING_BASE64 := 0x1
  DllCall( "Crypt32.dll\CryptStringToBinary", "Str",B64, "UInt",BLen, "UInt",0x1
         , "UInt",0, "UIntP",Rqd, "Int",0, "Int",0 )
  VarSetCapacity( Bin, 128 ), VarSetCapacity( Bin, 0 ),  VarSetCapacity( Bin, Rqd, 0 )
  DllCall( "Crypt32.dll\CryptStringToBinary", "Str",B64, "UInt",BLen, "UInt",0x1
         , "Ptr",&Bin, "UIntP",Rqd, "Int",0, "Int",0 )
Return Rqd
}