//%attributes = {}
#DECLARE($test : Integer) : Object

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		return New object:C1471(\
			"foo"; "BAR")
		
		//______________________________________________________
	Else 
		
		return New object:C1471(\
			"foo"; "bar")
		
		//______________________________________________________
End case 