//%attributes = {}
#DECLARE($test : Integer) : Collection

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		return New collection:C1472("foo"; "BAR")
		
		//______________________________________________________
	Else 
		
		return New collection:C1472("foo"; "bar")
		
		//______________________________________________________
End case 