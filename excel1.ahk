;; 列出Excel.Application能使用的顏色碼
;ComObjError(false) ; Disable COM Object error notification
excelApp := ComObjCreate("Excel.Application") 
workBook := excelApp.Workbooks.Add

excelApp.Visible := True
workBook.ActiveSheet.Columns("B").ColumnWidth := 5

Loop 100
{
  try 
  {
    workBook.ActiveSheet.Range("A" . A_INDEX).Value := A_INDEX
    excelApp.Range("B" . A_INDEX).Interior.ColorIndex := A_INDEX
  } catch e {
     ;; do nothing
  }
}

workBook.SaveAs("c:\temp\colors.xlsx")
workBook.Close()

Run, c:\temp\colors.xlsx