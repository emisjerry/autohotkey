#SingleInstance Force

!1::
  SetDefaultKeyboard(0x0409)  ;; 切換為英文輸入
  return

!2::
  SetDefaultKeyboard(0x0404)  ;; 切換為中文輸入
  return

!0::
  V++
  M := mod(V,2)  ;; 模數
  if M=1
    SetDefaultKeyboard(0x0404)  ;; 切換為中文輸入
  else
    SetDefaultKeyboard(0x0409)  ;; 切換為英文輸入
  return

SetDefaultKeyboard(LocaleID) {
  Global SPI_SETDEFAULTINPUTLANG := 0x005A
  SPIF_SENDWININICHANGE := 2
  Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
  VarSetCapacity(Lan%LocaleID%, 4, 0)
  NumPut(LocaleID, Lan%LocaleID%)
  ;Lan := 0xE0090404
  DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
  WinGet, windows, List
  Loop %windows% {
    PostMessage 0x50, 0, %Lan%, , % "ahk_id " windows%A_Index%
  }
}
