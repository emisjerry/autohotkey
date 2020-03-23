; 範例：搜尋奇摩股市並產生技術分析的螢幕快照
#SingleInstance Force

global driver, by, waiter

driver := ComObjCreate("Selenium.ChromeDriver")
driver.setBinary("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
driver.SetProfile("z:\chrome")
;driver.addArgument("auto-open-devtools-for-tabs")  ; 自動開啟DevTools

by := ComObjCreate("Selenium.By")  ;建立 By 物件

driver.get("https://tw.stock.yahoo.com/")

driver.findElementByID("stock_id").SendKeys("2330").submit()

;driver.wait(500)
;driver.waitForScript("return document.readyState == 'complete'", , 10000)
by1 := by.XPath("//div[text()='台積電']")
fn := Func("isExist").bind(by1)
driver.Until(fn, 10000)

ele := driver.findElement(by1, 10000, false)
if (not ele.IsPresent) {
  MsgBox 元素不存在
}

driver.findElementByXPath("//a[text()='技術分析']").Click()

; 尋找技術分析圖 
sXPath := "//html/body/center/table/tbody/tr/td/table[2]/tbody/tr[2]/td"
fn := Func("isExist").bind(by.XPath(sXPath))
driver.Until(fn, 10000)

ele := driver.findElementByXPath(sXPath)
ele.ScrollIntoView(true)

imageEle := ele.TakeScreenshot()
imageFull := driver.takeScreenshot()
imageEle.SaveAs("c:\temp\screen-element.png", true)
imageFull.SaveAs("c:\temp\screen-full.png", true)

msgbox Wait...

run c:\temp\screen-element.png
run c:\temp\screen-full.png

driver.quit()
driver := ""

; 頁面元素是否存在
; 傳入 By 物件
; 傳回 Boolean
isExist(by) {
  ele := driver.findElement(by)
  ;driver.executeScript("console.log('*******exist=" . ele.IsPresent . "');")
  return ele.IsPresent
}
