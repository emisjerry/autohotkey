; conv.ahk有兩種模式
;  1. conv.ahk 輸入路徑檔名 輸出路徑檔名
;     必須含有資料夾，否則會出錯
;  2. conv.ahk 輸入路徑檔名有星號  輸出副檔名
;     將輸入資料夾裡符合的檔案轉換成輸出副檔名格式

iParamCount := A_Args.Length()
if (iParamCount <> 2) {
  MsgBox 命令：conv.ahk 輸入檔名 輸出檔名`n　　　conv.ahk 有萬用字元的檔名 輸出副檔名`n`n請重新執行。`n
  Exit 1
}
sInputFilename := A_Args[1]
sOutputFilename := A_Args[2]

if !FileExist(sInputFilename) {
  MsgBox %sInputFilename% 檔案不存在！`n請重新執行。`n
  Exit 2
}
;MsgBox in=%sInputFilename%, out=%sOutputFilename%

iPos1 := InStr(sInputFilename, ".xlsx")
iPos2 := InStr(sOutputFilename, ".xlsx")
if (iPos1 > 0 || iPos2 > 0) {
  MsgBox 尚未提供Excel轉檔功能
  Exit 3
}

iPos1 := InStr(sInputFilename, "*")
if (iPos1 > 0) {  ; 輸入檔名有星號時，第二個參數是要輸出的副檔名(必須含.)
  sFileExtension := sOutputFilename
  Loop %sInputFilename% {
    sFilename = %A_LoopFileName%
    if (InStr(sFilename, "~") >= 1) {  ; 略過Office的暫存檔
      Continue
    }
    sFolderName = %A_LoopFileDir%
    iPos1 := InStr(sFilename, ".")
    sOutputFilename := sFolderName . "\" . Substr(sFilename,1,iPos1-1) . sFileExtension
    sCurrentInputFilename := sFolderName . "\" . sFilename
    convertFile(sCurrentInputFilename, sOutputFilename)
  }
} else {
  convertFile(sInputFilename, sOutputFilename)
}

convertFile(sInputFilename, sOutputFilename) {
  WD := ComObjCreate("Word.Application")  ; Create Word object
  WD.Documents.Open(sInputFilename) ;open this file
  WD.visible:=0 ;make visible for this example.  Normally set to zero
  
  iOutputFormat := getDocFormat(sOutputFilename)
  if (iOutputFormat = -1) {
    Return
  }
  ;MsgBox format=%iOutputFormat%
  if (iOutputFormat = 17) {  ; convert to PDF
    OpenAfterExport := True
    OptimizeFor := False
    Range := 0
    From := 1
    To := False

    WD.ActiveDocument.ExportAsFixedFormat(sOutputFilename,17,OpenAfterExport,OptimizeFor,Range,From,To)
  } else {
    WD.ActiveDocument.SaveAs2(sOutputFilename, iOutputFormat)
    Run %sOutputFilename%
  }
  WD.quit ; quit Word
  WD := ""
}

getDocFormat(sFilename) {
  iPos := InStr(sFilename, ".")
  if (iPos = 0) {
    Return -1  
  }
  ;;WdSaveFormat https://docs.microsoft.com/zh-tw/office/vba/api/word.wdsaveformat
  sExt := Substr(sFilename, iPos, 5)  ; 由.開始取5個字元
  if (sExt = ".docx") 
    iFormat := 16
  else if (sExt = ".doc") 
    iFormat := 0
  else if (sExt = ".txt") 
    iFormat := 2
  else if (sExt = ".html") 
    iFormat := 8
  else if (sExt = ".odf") 
    iFormat := 23
  else if (sExt = ".rtf") 
    iFormat := 6
  else if (sExt = ".pdf") 
    iFormat := 17
  
  Return iFormat
}
