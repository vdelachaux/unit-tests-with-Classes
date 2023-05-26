Class constructor($desc : Text; $type)
	
	This:C1470.desc:=$desc
	This:C1470.type:=$type
	This:C1470.success:=False:C215
	This:C1470.expected:=Null:C1517
	This:C1470.result:=Null:C1517
	This:C1470.typeResult:=Null:C1517
	This:C1470.not:=False:C215
	This:C1470.bypassed:=Null:C1517
	This:C1470.os:=Null:C1517
	This:C1470.strict:=False:C215
	This:C1470.noReport:=False:C215
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get successful() : Boolean
	
	return Bool:C1537(This:C1470.success)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get failed() : Boolean
	
	return Not:C34(Bool:C1537(This:C1470.success))
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isText() : Boolean
	
	return This:C1470.type=Is text:K8:3
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isNumeric() : Boolean
	
	If (This:C1470.type#Is null:K8:31)
		
		return (This:C1470.type=Is longint:K8:6) | (This:C1470.type=Is real:K8:4)
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isReal() : Boolean
	
	If (This:C1470.isNumeric)
		
		var $t : Text
		GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $t)
		return Match regex:C1019("^\\d*["+$t+"]\\d*$"; String:C10(This:C1470.expected); 1)
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isInteger() : Boolean
	
	If (This:C1470.isNumeric)
		
		return Not:C34(This:C1470.isReal)
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isNull() : Boolean
	
	return This:C1470.type=Is null:K8:31
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isUndefined() : Boolean
	
	return This:C1470.type=Is undefined:K8:13
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isBoolean() : Boolean
	
	return This:C1470.type=Is boolean:K8:9
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isPicture() : Boolean
	
	return This:C1470.type=Is picture:K8:10
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isBlob() : Boolean
	
	return This:C1470.type=Is BLOB:K8:12
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isObject() : Boolean
	
	return This:C1470.type=Is object:K8:27
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isFile() : Boolean
	
	If (This:C1470.type#Is object:K8:27) || (This:C1470.expected=Null:C1517)
		
		return 
		
	End if 
	
	return OB Instance of:C1731(This:C1470.expected; 4D:C1709.File)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isFolder() : Boolean
	
	If (This:C1470.type#Is object:K8:27) || (This:C1470.expected=Null:C1517)
		
		return 
		
	End if 
	
	return OB Instance of:C1731(This:C1470.expected; 4D:C1709.Folder)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isCollection() : Boolean
	
	return This:C1470.type=Is collection:K8:32
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isPointer() : Boolean
	
	return This:C1470.type=Is pointer:K8:14
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isDate() : Boolean
	
	return This:C1470.type=Is date:K8:7
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isTime() : Boolean
	
	return This:C1470.type=Is time:K8:8
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get onMac() : Boolean
	
	return (This:C1470.os=Null:C1517) || (This:C1470.os.indexOf("macOS")#-1)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get onWindows() : Boolean
	
	return (This:C1470.os=Null:C1517) || (This:C1470.os.indexOf("Windows")#-1)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get onLinux() : Boolean
	
	return (This:C1470.os=Null:C1517) || (This:C1470.os.indexOf("Linux")#-1)