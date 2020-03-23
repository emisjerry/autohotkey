;; 將DOCX匯出為PDF

sFolder := "Z:\DOC"
sOutputExt := ".pdf"

Loop %sFolder%\*.docx {
  sInputFilename = %A_LoopFileName%
  ;MsgBox filename=%sPdfFileName%
  iPos := InStr(sInputFilename, "~")
  if (iPos = 1) {
    Continue
  }
  Docx2Pdf(sFolder . "\" . sInputFilename, sOutputExt)
}

Docx2Pdf(sInputFilename, sOutputExt) {
  WD := ComObjCreate("Word.Application")  ; Create Word object
  WD.Documents.Open(sInputFilename) ;open this file
  WD.visible:=0 ;make visible for this example.  Normally set to zero
  iFormat := 17
  sOutputFilename := StrReplace(sInputFilename, ".docx", ".pdf")
  ;MsgBox fn=%sOutputFilename%, ext=%sOutputExt%, format=%iFormat%
  ;;WdSaveFormat https://docs.microsoft.com/zh-tw/office/vba/api/word.wdsaveformat
  
  OpenAfterExport := True
  OptimizeFor := False
  Range := 0
  From := 1
  To := False
  /*
  Item:= 0
  IncludeDocProps := False
  KeepIRM := True
  reateBookmarks := wdExportCreateHeadingBookmarks := 1
  ocStructureTags := False
  BitmapMissingFonts := True
  UseISO19005_1 := False
  */
    
  ;; WD.ActiveDocument.ExportAsFixedFormat(sOutputFilename, 17, OpenAfterExport, OptimizeFor, Range, From, To, Item, IncludeDocProps, KeepIRM, CreateBookmarks, DocStructureTags, BitmapMissingFonts, UseISO19005_1)    

  WD.ActiveDocument.ExportAsFixedFormat(sOutputFilename,17,OpenAfterExport,OptimizeFor,Range,From,To)  

  WD.quit ; quit Word
  WD := ""
}
