//%attributes = {}
#DECLARE($test : Integer) : Collection

var myCollection : Collection

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		myCollection:=New collection:C1472("foo"; "BAR")
		
		//______________________________________________________
	: ($test=2)
		
		myCollection:=New collection:C1472("foo"; New collection:C1472(1; 2; 3))
		
		//______________________________________________________
	: ($test=3)
		
		myCollection:=New collection:C1472("foo"; New collection:C1472("foo"; "BAR"))
		
		//______________________________________________________
	Else 
		
		myCollection:=New collection:C1472("foo"; "bar")
		
		//______________________________________________________
End case 

return myCollection