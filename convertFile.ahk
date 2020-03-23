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
