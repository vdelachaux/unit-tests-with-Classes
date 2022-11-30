//%attributes = {"invisible":true}
#DECLARE($test : Integer) : Blob

var myBlob : Blob
SET BLOB SIZE:C606(myBlob; 0)

Case of 
		
		//______________________________________________________
	: ($test=1)
		
		LONGINT TO BLOB:C550(8858; myBlob)
		
		//______________________________________________________
	Else 
		
		// Empty blob
		
		//______________________________________________________
End case 

return myBlob