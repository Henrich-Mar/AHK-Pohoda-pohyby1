#NoEnv
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay, 20
SetWinDelay 0
SetKeyDelay 20,20
SetMouseDelay -1
;~ Autor : Henrich Marcinov
;~ -------------------------

Gui, Add, Text, x12 y29 w100 h30 , Spo��tanie Firiem
Gui, Add, Button, x12 y59 w100 h30 , Ok
; Generated using SmartGUI Creator for SciTE
Gui, Show, w130 h106, Untitled GUI
return

ButtonOk:
{
WinActivate , ahk_exe Pohoda.exe
Sleep, 100
Send, ^u
Sleep, 100


Loop,
 {
	Sleep, 2000
	ControlGetText,PU,Button7, ahk_exe Pohoda.exe
	if PU = Podvojn� ��tovn�ctvo
		break
 }
Send, ^{Home}
Sleep, 150

StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
Lista = %Lista%
Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	
Opakovania := SubStr(Lista_cista, 2, -1)

Sleep, 150
Gui, destroy,
}

;MsgBox, %Opakovania%
Sleep, 150

StatusBarGetText, rok,3, ahk_exe Pohoda.exe
rok = %rok%
rok2 := rok+1

;~ I�o;Firma;Celkov� Po�et pohybov;Po�et pohybov - Banka%rok%,Po�et pohybov - Banka%rok2%;Vystaven� fakt�ry; Import vystaven�ch Fakt�r;Mzdy; `n
FileAppend,		 ; Vytvorenie nov�ho s�boru test s d�tumom
(
I�o;Firma;Celkov� Po�et pohybov;Po�et pohybov rok n;Po�et pohybov n+1; Po�et pohybov - Banka rok n;Po�et pohybov - Banka n+1;Agenda Banka; Import Banka;`n
),C:\Users\Henrich\Desktop\Plocha\Nov� prie�inok (3)\Pohyby\Pohyb%A_DD%%A_MM%%A_YYYY%.txt

Loop, %Opakovania% 			; Za��name s opakovan�m , �o sa mus� v�dy sta� pri ka�dom zopakovan�
{
WinActivate , ahk_exe Pohoda.exe
Sleep, 150
Send, ^u
Sleep, 150
Send, ^{Home}			; Zapla sa pohoda zapli sme zoznam firiem cez Ctr+u a ctrl home aby sme sa dostali na prv� poz�ciu zoznamu

Sleep, 150
Jojo := A_Index - 1 ; Tu m�me variabiln� ktor� n�m po��ta v ktorej iter�cii loopu sme (na za�iatku je to 1 ale potrebujeme od nej odpo��ta� 1 kv�li prvej firme v zozname)
Sleep,100
	Loop, %Jojo%           ; ko�ko kr�t m� �s� dole ��pka v�dy je to n-1 loopu 
	{
		Sleep,100
		Send, {Down}
	}

Sleep, 150
ControlGetText, ICO , Edit18, ahk_exe Pohoda.exe			; zist�me I�O cez simplespy (google simplespy ahk)
ControlGetText, DIC , Edit19, ahk_exe Pohoda.exe
ControlGetText, Spol , Edit2, ahk_exe Pohoda.exe
Spol = %Spol%
Send, {Enter}
Sleep, 1000
Send, {Esc}
Sleep, 500                                            ;U� sme vo firme 
StatusBarGetText, Firma_lista,2, ahk_exe Pohoda.exe
Firma_lista = %Firma_lista%

Test_zapnutia_firmy:
If (Spol != Firma_lista)
	{
		MsgBox, nieco sa stalo, stla� - A - ke� sa nastav� na hlavn� stranu firmy 
		KeyWait, a, D
			
	}	

Send, ^d
Sleep, 150
Send, {Enter}
Sleep, 1000
Send, ^{Home}
Sleep, 150
Send, {Home}
Zber_celkovych_pohybov:
 {
	StatusBarGetText, Lista,1, ahk_exe Pohoda.exe 
	Lista = %Lista%
	Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	
	Pohyby := SubStr(Lista_cista, 2, -1)
	Celkove_pohyby = %Pohyby%
}
	
Sleep, 150
Send, +{F10}

Sleep, 150
Send, {Down}{Down}{Down}
Sleep, 150
Send, {Enter}

tabulka:
{
	WinWait, ahk_class #32770
	Sleep, 150
	ControlClick, Button7, ahk_class #32770
	Sleep, 150
	Send,{Enter}
	ControlSetText, Edit1, Zdroj
	Sleep, 150
	Send, {Tab}
	Sleep, 150
	Send, {Tab}
	Sleep, 150
	Send, {space}
	Sleep, 150
	Send, {Enter}
}
Sleep, 150
rok2 := ""
StatusBarGetText, rok,3, ahk_exe Pohoda.exe
rok = %rok%
rok2 := rok+1
Sleep, 150
Send, %rok%
Sleep, 150
Send, {Enter}
Sleep, 150
Send, ^{Home}
Sleep, 150

Zber_pohybov_n_:
	{
	StatusBarGetText, Lista,1, ahk_exe Pohoda.exe    			; Dostali sme sa na pohyby tak vytiahneme zo spodnej li�ty celkov� po�et pohybov aj n�zov firmy
	StatusBarGetText, Firma,2, ahk_exe Pohoda.exe

	Lista = %Lista%
	Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	; mus�me vy�isti� variabiln� o text lebo my chceme iba ��sla 
	Pohyby := SubStr(Lista_cista, 2, -1)                       	; rozdel�me si variabiln� aby n�m brala poz�ciu od 2 (ignorovala aktu�lny z�znam) aby sme dostali celkov� po�et pohybov a e�te -1 je kv�li tomu �e na konci textu je F1 ale v�etky jedni�ky nechceme vymaza� predo�l�m pr�kazom tak len t�to jedni�ku vynech�me od konca.
	Pohyby_n = %Pohyby%
	}
Pohyby := ""

Zber_pohybov_zdroj_Banka_n:
{
	Sleep, 150
	Send, {Right}
	Sleep, 150
	Send, banka
	Loop, 3
	{
		Sleep, 150
		Send, {Enter}
	}
	Sleep, 150
	Send, ^{Home}
	Sleep, 150
	Send, {Home}
	StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		Lista = %Lista%
	Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	
	Pohyby := SubStr(Lista_cista, 2, -1)
	Pohyby_n_banka = %Pohyby%
	if ( Pohyby_n = Pohyby_n_banka)
		Pohyby_n_banka := 0
}
Sleep, 150
Pohyby := ""
Sleep, 150
Send, !v
Sleep, 150
Send, {Home}
Sleep, 150
Send, {Right}
Sleep, 150
Send, %rok2%
Loop, 3
	{
	Sleep, 150
	Send, {Enter}
	}
Sleep, 150
Send, ^{Home}
Sleep, 150
Send, {Home}

Zber_pohybov_n_plus_1:
	{
		StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		Lista = %Lista%
	Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	
	Pohyby := SubStr(Lista_cista, 2, -1)
	Pohyby_n_plus_1 = %Pohyby%
	if ( Celkove_pohyby = Pohyby_n_plus_1)
		Pohyby_n_plus_1 := 0
	}
Pohyby := ""
Zber_pohybov_zdroj_Banka_n_plus_1:
{
Sleep,150
Loop, 2
	{
	Sleep, 150
	Send, {Right}
	}
Sleep,150
Send, banka
	Loop, 3
	{
		Sleep, 150
		Send, {Enter}
	}
Sleep,150
Send, ^{Home}
	Sleep, 150
	Send, {Home}
	StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		Lista = %Lista%
	Lista_cista := RegExReplace(Lista, "[a-zA-Z��.()/]", "")  	
	Pohyby := SubStr(Lista_cista, 2, -1)
	Pohyby_n_banka_plus_1 = %Pohyby%
	if ( Pohyby_n = Pohyby_n_banka)
		Pohyby_n_banka := 0
}
Zber_pohybov_Banka:
{
	Pohyby := ""
Sleep,150
Send,^b
Sleep, 200
ControlGetText, banka, Static10, ahk_exe Pohoda.exe
 banka = %banka%
	loop,
	{
		if (banka != "D�tum v�pisu")
		{
		Sleep,200
		Send,^b
		}
		if (banka != "D�tum v�pisu")
		break
	}		
Sleep,150
Send, ^{Home}
Sleep,150
Send, {Home}
Sleep,300

;~ StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		;~ Lista = %Lista%
	;~ Lista_cista := SubStr(Lista,3,10)
	;~ MsgBox,%Lista_cista%
	;~ Lista_cista := RegExReplace(Lista_cista, "[a-zA-Z��.()/]", "")
	;~ MsgBox,%Lista_cista%
	;~ Pohyby := SubStr(Lista_cista,1)
	;~ Pohyby_agenda_banka = %Pohyby%
Sleep,150	
Send, +{F10}
Sleep, 150
Send, {Down}{Down}
Sleep, 150
Send, {Enter}

tabulka2:
{
	WinWait, ahk_class #32770
	Sleep, 150
	ControlClick, Button7, ahk_class #32770
	Sleep, 150
	Send,{Enter}
	ControlSetText, Edit1, Zdroj
	Sleep, 150
	Send, {Tab}
	Sleep, 150
	Send, {Tab}
	Sleep, 150
	Send, {space}
	Sleep, 150
	Send, {Enter}
}
Sleep,150
Send, {Home}
Sleep, 150
Send, ^{Home}
Sleep, 150
StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		Lista = %Lista%
	Lista_cista := SubStr(Lista,3,10)
	Lista_cista := RegExReplace(Lista_cista, "[a-zA-Z��.()/]", "")
	Pohyby := SubStr(Lista_cista,1)
	Pohyby_agenda_banka = %Pohyby%

Sleep,150
Send, {End}
Sleep,150
Send, homebanking
Loop, 3
	{
	Sleep, 150
	Send, {Enter}
	}
Sleep,150
Send, ^{Home}
Sleep,150
Pohyby := ""
StatusBarGetText, Lista,1, ahk_exe Pohoda.exe
		Lista = %Lista%
	Lista_cista := SubStr(Lista,3,10)
	Lista_cista := RegExReplace(Lista_cista, "[a-zA-Z��.()/]", "")
	Pohyby := SubStr(Lista_cista,1)
	Pohyby_import_banka = %Pohyby%
	if ( Pohyby_import_banka = Pohyby_agenda_banka)
		Pohyby_import_banka := 0
}

MsgBox, Celkove pohyby:%Celkove_pohyby% , rokN:%Pohyby_n% , RokN+1:%Pohyby_n_plus_1%, BankaN:%Pohyby_n_banka%,BankaN+1:%Pohyby_n_banka_plus_1%,Banka:%Pohyby_agenda_banka%,Import banka:%Pohyby_import_banka%
Sleep,150

FileAppend,                                  				 ; Nakoniec dop�eme do vytvoren�ho textu s hlavi�kami na�e ��sla a n�zvy firiem :)
(
%ICO%;%Firma%;%Celkove_pohyby%;%Pohyby_n%;%Pohyby_n_plus_1%;%Pohyby_n_banka%;%Pohyby_n_banka_plus_1%;%Pohyby_agenda_banka%;%Pohyby_import_banka%`n
),C:\Users\Henrich\Desktop\Plocha\Nov� prie�inok (3)\Pohyby\Pohyb%A_DD%%A_MM%%A_YYYY%.txt
}
return

