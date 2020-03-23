#SingleInstance Force

sFileName := A_Args[1]  ;; 傳入參數必須帶有路徑
if (sFileName = "") {
  MsgBox 必須傳入完整檔名
  return
}  
pmsg := ComObjCreate("CDO.Message")
;;pmsg.Charset := "UTF-8"
pmsg.From := """SendByAHK"" <你的Gmail帳號@gmail.com>"
pmsg.To := "你的Kindle帳號@kindle.com"
pmsg.BCC := ""   ; Blind Carbon Copy, Invisable for all, same syntax as CC
pmsg.CC := ""   
pmsg.Subject := "傳送Kindle檔名:" . sFileName

;You can use either Text or HTML body like
pmsg.TextBody := "傳送檔名:" . sFileName
;OR
;pmsg.HtmlBody := "<html><head><title>Hello</title></head><body><h2>Hello</h2><p>Testing!</p></body></html>"

;;MsgBox %sFileName%
sAttach := sFileName ; can add multiple attachments, the delimiter is |

fields := Object()
fields.smtpserver := "smtp.gmail.com" ; specify your SMTP server
fields.smtpserverport := 465 ; 25
fields.smtpusessl := True ; False
fields.sendusing := 2   ; cdoSendUsingPort
fields.smtpauthenticate := 1   ; cdoBasic
fields.sendusername := "你的Gmail帳號@gmail.com"
fields.sendpassword := "你的Gmail帳號密碼"
fields.smtpconnectiontimeout := 60
schema := "http://schemas.microsoft.com/cdo/configuration/"

pfld := pmsg.Configuration.Fields

For field,value in fields
    pfld.Item(schema . field) := value
pfld.Update()

Loop, Parse, sAttach, |, %A_Space%%A_Tab%
    pmsg.AddAttachment(A_LoopField)

pmsg.Send()

