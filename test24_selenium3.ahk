; 範例：搜尋PCHome線上購物，將查詢的商品逐一開啟其訊息網頁
#SingleInstance Force

driver:= ComObjCreate("Selenium.ChromeDriver")

driver.setBinary("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
driver.SetProfile("z:\chrome")
driver.addArgument("auto-open-devtools-for-tabs")

driver.get("https://shopping.pchome.com.tw")

MsgBox 1

driver.FindElementByID("keyword").SendKeys("MSI Prestige 14")
driver.FindElementByID("doSearch").Click()

Msgbox 2
driver.wait(500)

MsgBox Wait...

;elements := driver.findElementsByClass("prod_name")
;iCount := elements.Count
;eleProdNumbers := driver.findElementsByClass("col3f")

eleLinks := driver.findElementsByCSS(".prod_name > a")
iCount := eleLinks.Count

;name := driver.findElementsByClass("prod_name").item[1].Attribute("innerText")

Loop %iCount% {
  ;sProdName := elements.item[A_INDEX].Attribute("innerText")
  ;sProdNumber := eleProdNumbers.item[A_INDEX].Attribute("id")
  sLink := eleLinks.item[A_INDEX].Attribute("href")

  ;MsgBox %sProdName%, %sProdNumber%, %sLink%
  ;driver.findElementByTag("body").SendKeys(driver.Keys.CONTROL, "t")
  driver.executeScript("window.open('" . sLink . "');")
}

msgbox 共開啟 %iCount% 個網頁...

driver.quit()
driver := ""