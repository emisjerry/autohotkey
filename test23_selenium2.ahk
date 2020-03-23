#SingleInstance Force

;ComObjError(false)
sURL := "https://www.mobile01.com/"

iBrowser := 1

if (iBrowser = 1) {
  driver:= ComObjCreate("Selenium.ChromeDriver")
  driver.setBinary("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
  driver.SetProfile("z:\chrome")
} else if (iBrowser = 2) {
  driver:= ComObjCreate("Selenium.IEDriver")
} else if (iBrowser = 3) {
  driver:= ComObjCreate("Selenium.FireFoxDriver") 
} else if (iBrowser = 4) {
  driver := ComObjCreate("Selenium.PhantomJSDriver")  ; headless 無視窗的瀏覽器
}

driver.Get(sURL)

By := ComObjCreate("Selenium.By")

isPresent := driver.IsElementPresent(By.XPath("//span[text()='jerry20191111']"), 5000)

;ele := driver.findElementsByXPath("//span[text()='jerry20191111']")
;ele := driver.findElementByXPath("//span[text()='jerry20191111']", 0, false)
;isPresent:= ele.IsPresent
MsgBox count=%isPresent%
if (isPresent) {
  driver.findElementByXPath("//span[text()='jerry20191111']").Click()
  driver.findElementByXPath("//a[text()='登出']").click()
}

driver.findElementByCSS(".c-login").Click()

driver.wait(1500)  ; wait for 500 miliseconds

driver.findElementByCSS("#regEmail").SendKeys("jerry20191111@outlook.com")
driver.wait(1000)  ; Mobile01似乎有偵測輸入速度，太快會無法登入
driver.findElementByCSS("#regPassword").SendKeys("20191111jerry")
driver.wait(1500)
driver.findElementByID("submitBtn").Click()  ; 用Click亦可

driver.wait(1000)

ele := driver.findElementByXPath("//*[contains(@class, 'c-menuLv1')]//a[text()='筆電']")
driver.Actions.MoveToElement(ele).Perform()

driver.wait(500)

ele := driver.findElementByXPath("//*[contains(@class, 'c-menuLv1')]/li[4]/ul/li[2]/a")
driver.Actions.MoveToElement(ele).Perform()

ele := driver.findElementByXPath("//a[text()='MSI']").Click()

driver.findElementByCSS("#keyword").SendKeys("Prestige 15").SendKeys(driver.Keys.ENTER)

;driver.executeScript("alert('這是瀏覽器彈出的對話窗。網頁標題: ' + document.title);")

MsgBox 這是AutoHotkey的對話窗...

try {
  if (driver.findElementByXPath("//span[text()='jerry20191111']")) {
    driver.findElementByXPath("//span[text()='jerry20191111']").click()
    driver.wait(500)
    driver.findElementByXPath("//a[text()='登出']").click()
  }
} catch e {
}  

driver.quit()
driver := ""

