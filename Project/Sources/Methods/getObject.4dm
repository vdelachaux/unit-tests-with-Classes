//%attributes = {}
#DECLARE($test : Integer) : Object

If (False:C215)
	C_LONGINT:C283(getObject; $1)
	C_OBJECT:C1216(getObject; $0)
End if 

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		myObject:=New object:C1471(\
			"foo"; "BAR")
		
		//______________________________________________________
	: ($test=2)
		
		myObject:=New object:C1471
		
		//______________________________________________________
	: ($test=3)
		
		myObject:=New object:C1471(\
			"foo"; New object:C1471(\
			"foo"; New collection:C1472(\
			"foo"; New collection:C1472(\
			1; 2; New object:C1471(\
			"foo"; "BAR")))))
		
		//______________________________________________________
	Else 
		
		myObject:=New object:C1471(\
			"foo"; "bar")
		
		//______________________________________________________
End case 

return myObject