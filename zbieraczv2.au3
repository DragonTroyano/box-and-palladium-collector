HotKeySet("{ESC}", "myExit")

;$Screen1[0] = 423
;$Screen1[1] = 196

;$Screen2[0] = 1497
;$Screen2[1] = 946

MsgBox(0,"Calibration: Left part","Set Mouse in upper left corner")
$Screen1 = MouseGetPos()

MsgBox(0,"Calibration: Right part","Set Mouse in upper Right corner")
$Screen2 = MouseGetPos()

;$MiniMapX1 = 1560
;$MiniMapY1 = 818
;$MiniMapX2 = 1887
;$MiniMapY2 = 1015

MsgBox(0,"Calibration: Minimaps", "Set Mouse to the top left corner of the minimap")
$MiniMap1 = MouseGetPos()

MsgBox(0,"Calibration: Minimaps", "Set Mouse to the top right corner of the minimap")
$MiniMap2 = MouseGetPos()

;surki

$Palla_color_1 = 0x57C1E3 ;jasno niebieski
$Palla_color_2 = 0x378AD8 ;ciemno niebieski

;Boxy

$Box1_color_1 = 0xFFFFFF
$Box1_color_2 = 0xFFDAAA

$ShadeVariant =  20

$ColorSearchCounter = 0

$HuntCounter = 0


MouseClick("right",$MiniMap1[0],$MiniMap1[1],1)
Sleep(10000)

$CurrentHuntPoint = $MiniMap1

$X_Steps = ($MiniMap2[0] - $MiniMap1[0]) / 5
$Y_Steps = ($MiniMap2[1] - $MiniMap1[1]) / 5

$Hunting = True

While(1)
   WinActivate("DarkOrbit")

   SearchForColor($Palla_color_1, $Palla_color_2)
   SearchForColor($Box1_color_1,$Box1_color_2)
   sleep(250)

   if $Hunting = True Then
	  $HuntCounter = $HuntCounter + 1
	  if $HuntCounter = 10 Then
		 $HuntCounter = 0
			if $CurrentHuntPoint[0] + $X_Steps >  $MiniMap2[0] Then
			   if $CurrentHuntPoint[1] + $Y_Steps > $MiniMap2[1] Then
				  $CurrentHuntPoint = $MiniMap1
			   Else
				  $CurrentHuntPoint[0] = $MiniMap1[0] ;ustawieie pozycji x
				  $CurrentHuntPoint[1] = $CurrentHuntPoint[1] + $Y_Steps ;ipmlemetacja osy Y
			   EndIf
			Else
			   $CurrentHuntPoint[0] = $CurrentHuntPoint[1] +$X_Steps
			EndIf
		 MouseClick("right",$CurrentHuntPoint[0],$CurrentHuntPoint[1],'1')
	  EndIf
   EndIf
WEnd



func SearchForColor($col1, $col2)
	  $Found = PixelSearch($Screen1[0],$Screen1[1] , $Screen2[0], $Screen2[1], $col1,$ShadeVariant)
	  If Not  @error Then
			SetError(0)
			$Found = PixelSearch($Found[0] - 32,$Found[1] - 32 , $Found[0] + 32, $Found[1] + 32, $col2, $ShadeVariant)
			If Not @error Then
			   MouseClick("right",$Found[0],$Found[1],1,1)
			   sleep(3000)
			   SearchForColor($col1, $clol2)
			EndIf
		 EndIf

	  $Found = PixelSearch($Screen2[0],$Screen2[1], $Screen1[0], $Screen1[1], $col1,$ShadeVariant)
	  If Not @error Then
		 SetError(0)
		 $Found = PixelSearch($Found[0] - 32,$Found[1] - 32 , $Found[0] + 32, $Found[1] + 32, $col2,$ShadeVariant)
		 If Not @error Then
			MouseClick("right",$Found[0],$Found[1],1,1)
			sleep(3000)
		 EndIf
	  EndIf
EndFunc





Func myExit()
   Exit
EndFunc
