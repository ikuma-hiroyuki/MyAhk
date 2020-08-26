; ^ = Ctrl
; + = shIft
; ! = alt
; # = win
; VK1C = 変換
; VK1D = 無変換

#SingleInstance, Force
#UseHook
#NoEnv
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include, %A_ScriptDir%\lib\component.ahk
#Include, %A_ScriptDir%\lib\window_Controller.ahk
#Include, %A_ScriptDir%\lib\search.ahk
#Include, %A_ScriptDir%\lib\symbol_sand.ahk

~vk1d & 0::Reload

; 拡張コンテキストメニュー表示
~vk1d & r::send,+{F10}

; ウィンドウ操作-----------------------------------------------------------------------------------------
; ウィンドウ切り替え
~vk1c & o::AltTab
~vk1c & i::ShiftAltTab

;ウィンドウを閉じる
~vk1d & 4::send,!{F4}

; ウィンドウを最小化する
~vk1d & 1::WinMinimize, A

;文字列操-----------------------------------------------------------------------------------------
; カーソルが途中でも下に一行挿入
#Enter::send,{end}{enter}

; delete
~vk1d & d::send,{delete}

; backspace
~vk1d & b::send,{backspace}

; クリップボード履歴表示
~vk1d & v::send,#v

; 一行削除
~vk1d & x::send,{end}{home}

; 日付を出力
~VK1C & d::CurrentDate()

; 記号ペア出力-----------------------------------------------------------------------------------------
~VK1D & m::SymbolSandwichMenu()
~VK1D & 2::gosub, doubleCrotation
~VK1D & 7::gosub, singleCrotation
~VK1D & 8::gosub, roundBracket
~VK1D & 9::gosub, kagikakko
~VK1D & i::gosub, anySymbol
~VK1D & [::
    if GetKeyState("Shift"){
        gosub, curlyBrackets
    } else {
        gosub, squareBrackets
    }
    Return

; 検索系-----------------------------------------------------------------------------------------
; 選択した文字をgoogle検索する
~vk1d & s::runGoogleSerch()

; 選択した文字をAmazon検索する
~vk1d & a::runAmazonSerch()

; 選択した文字を翻訳する
~vk1d & t::
    if GetKeyState("vk1c") {
        runDeepLTrans()
    }else{
        runGoogleTrans()
    }
    Return

; window移動-----------------------------------------------------------------------------------------
~vk1d & left::WindowMove(-25, 0)
~vk1d & Right::WindowMove(25, 0)
~vk1d & up::WindowMove(0, -25)
~vk1d & down::WindowMove(0, 25)
~VK1D & e::WinMoveCenter()
~vk1d & w::
    if GetKeyState("vk1c"){
        WinResizeMenu()
    } else {
        WinAutoResize()
    }
    Return

;マウス操作-----------------------------------------------------------------------------------------
~VK1C & l::Click,Left
~VK1C & r::Click,Right
~VK1C & j::Click,WheelDown
~VK1C & k::Click,WheelUp

!left::MouseCursorMove("left")
!right::MouseCursorMove("right")
!up::MouseCursorMove("up")
!down::MouseCursorMove("down")

+!left::MouseCursorMove("left", true)
+!right::MouseCursorMove("right", true)
+!up::MouseCursorMove("up", true)
+!down::MouseCursorMove("down", true)

; !left::MouseCursorMove(-mouseSpeed, 0)
; !right::MouseCursorMove(mouseSpeed, 0)
; !up::MouseCursorMove(0, -mouseSpeed)
; !down::MouseCursorMove(0, mouseSpeed)

; +!left::MouseCursorMove(-mouseSpeed, 0, true)
; +!right::MouseCursorMove(mouseSpeed, 0, true)
; +!up::MouseCursorMove(0, -mouseSpeed, true)
; +!down::MouseCursorMove(0, mouseSpeed, true)

#IFWinActive ahk_exe Explorer.EXE
    F1::send,!vsf
#IFWinActive
