; 範例：把硬碟裡的圖片插入Word檔裡
#SingleInstance Force

::,1::
  Send ^!i
  sleep 500
  Send c:\temp\screen\ahk1.jpg{Enter}{down}
  Return

::,2::
  insertPicture(2)
  Return

::,3::
  insertPicture(3)
  Return

::,4::
  insertPicture(4)
  Return

insertPicture(iNo)
{
  Send ^!i
  sleep 500
  Send c:\temp\screen\ahk%iNo%.jpg{Enter}{down}
}