選擇後傳出ErrorLevel
#SingleInstance Force

; Y/N/Cancel=3, 問號圖示=32, 預設按鈕2=256.
; 3+32+256=291
MsgBox, 291,, 是否繼續執行? (點擊 是 或 否)
IfMsgBox Yes 
{
    ;MsgBox You pressed Yes.
    ExitApp, 1
} 
else IfMsgBox No 
{
    ;MsgBox You pressed No.
    ExitApp, 2
}    
Else
{
    ExitApp, 3
}