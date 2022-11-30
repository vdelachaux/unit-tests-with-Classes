//%attributes = {"invisible":true}
#DECLARE($test : Integer) : Picture

var myPicture : Picture
CLEAR VARIABLE:C89(myPicture)

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		// Emptry picture
		
		//______________________________________________________
	Else 
		
		CREATE THUMBNAIL:C679(myPicture; myPicture; 12; 12)
		
		//______________________________________________________
End case 

return myPicture