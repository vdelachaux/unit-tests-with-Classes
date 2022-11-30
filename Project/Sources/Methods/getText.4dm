//%attributes = {}
#DECLARE($test : Integer) : Text

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		myText:="HELLO WORLD"
		
		//______________________________________________________
	Else 
		
		myText:="Hello World"
		
		//______________________________________________________
End case 

return myText