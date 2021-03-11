#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2
#IfWinActive Power BI Desktop
^Enter::
Clipboard :=
WinTag := WinActive("A")
Send, {Ctrl down}a{Ctrl up}
Send, {Ctrl down}c{Ctrl up}
CLipWait, 2
DAX := clipboard
DAXFormatter := "https://www.daxformatter.com/raw/"
ie := ComObjCreate("InternetExplorer.Application")
ie.Visible := False
ie.Navigate(DAXFormatter)
while (ie.ReadyState != 4) || (ie.Busy)
	Sleep, 100
ie.document.getElementsByTagName("textarea")[0].value := DAX
while (ie.ReadyState != 4) || (ie.Busy)
	Sleep, 100
ie.document.getElementsByClassName("btn")[0].Click()
while (ie.ReadyState != 4) || (ie.Busy)
	Sleep, 100
FormattedCode := ie.document.getElementsByClassName("formatted")[0].innerText
Clipboard := FormattedCode
ie.quit
WinActivate, ahk_id %WinTag%
Send, {Ctrl down}v{Ctrl up}
