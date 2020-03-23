; 示範常用類別
#SingleInstance Force

driver := ComObjCreate("Selenium.ChromeDriver")
;driver.addArgument("auto-open-devtools-for-tabs")  ; 自動開啟DevTools
driver.setBinary("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
driver.SetProfile("z:\chrome")

driver.get("https://tw.stock.yahoo.com/")

ele := driver.findElementByID("stock_id").SendKeys("2330")

MsgBox Wait...

by := ComObjCreate("Selenium.By")  ;建立 By 物件

ele := driver.findElement(By.ID("stock_id")).Clear().SendKeys("2382")

MsgBox Wait 2...

ele.submit()

imageFull := driver.takeScreenshot()
imageFull.SaveAs("c:\temp\screen-full.png", true)

msgbox Wait the last one...

run c:\temp\screen-full.png

driver.quit()
driver := ""

