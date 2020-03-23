; 範例：把硬碟裡的圖片插入Word檔裡
#SingleInstance Force

::,pp::
iCount := 60

driver:= ComObjCreate("Selenium.ChromeDriver")
driver.setBinary("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
driver.SetProfile("z:\chrome")
driver.addArgument("no-sandbox")
driver.get("https://www.google.com")

;; image := ComObjCreate("Image")
word := ComObjCreate("word.Application")
word.Documents.Add()
word.visible:=1

list := ComObjCreate("Selenium.List")
;image := ComObjCreate("Selenium.Image")
sDir := "c:\temp\screen"

Loop %sDir%\*.* {
  list.add(A_LoopFileName)
}
list.sort()

iCount := list.Count
image := driver.TakeScreenshot(100)

Loop %iCount% {
  sFilename := list.item[A_INDEX]
  ;try {
    image1 := image.Load("c:\temp\screen\" + sFilename)
    ;image1.Resize(1080.0, 2240.0)  ; cannot work
    image1.Copy(true)  ; copy to clipboard; true=Auto dispose
    word.Selection.TypeText(sFilename)
    word.Selection.Paste
    word.Selection.TypeText("`n")
    ;driver.wait(200)
  ;} catch e {
    ; do nothing
  ;}
  image1.Dispose()
  image1 := ""
  Clipboard := ""
}
driver.quit()
