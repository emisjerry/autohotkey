;; 列出Excel.Application能使用的顏色碼
;ComObjError(false) ; Disable COM Object error notification
excelApp := ComObjCreate("Excel.Application") 
workBook := excelApp.Workbooks.Add

excelApp.Visible := True
workBook.ActiveSheet.Columns("B").ColumnWidth := 5

iCol := 0
iRow := 1
Loop 100
{
  try 
  {
    workBook.ActiveSheet.Range("A" . A_INDEX).Value := A_INDEX
    excelApp.Range("B" . A_INDEX).Interior.ColorIndex := A_INDEX
    
    Random, iRandom, 1, 10000
    excelApp.Range("C" . A_INDEX).value := iRandom
    oRange := excelApp.Range("C" . A_INDEX)
    oRange.Font.Bold := 1
    oRange.Font.ColorIndex := A_INDEX
    borders(oRange)
  } catch e {
    ; Do nothing
  }
}

workBook.SaveAs("c:\temp\colors.xlsx")
workBook.Close()

Run, c:\temp\colors.xlsx

borders(oRange) {
  Loop 4 {
    oRange.Borders(A_INDEX+6).LineStyle := 1
    oRange.Borders(A_INDEX+6).ColorIndex := 3
  }
}
