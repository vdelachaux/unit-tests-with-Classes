property desc : Text
property type : Integer
property bypassed; noReport; not; success; strict; try : Boolean
property expected; result : Variant
property os : Collection
property srcExpected; srcResult : Text
property error : Text
property typeResult; keepError : Integer
property deferredError : Object

Class constructor($desc : Text; $type)
	
	This:C1470.desc:=$desc
	This:C1470.type:=$type
	This:C1470.expected:=Null:C1517
	This:C1470.result:=Null:C1517
	This:C1470.typeResult:=Null:C1517
	This:C1470.bypassed:=Null:C1517
	This:C1470.noReport:=False:C215
	This:C1470.not:=False:C215
	This:C1470.try:=False:C215
	This:C1470.success:=False:C215
	This:C1470.strict:=False:C215
	This:C1470.os:=Null:C1517
	
	This:C1470.srcExpected:=Null:C1517
	This:C1470.srcResult:=Null:C1517
	
	This:C1470.error:=Null:C1517
	This:C1470.keepError:=0  // Deferred flag
	This:C1470.deferredError:=Null:C1517
	
	// === === === === === === === === === === === === === === === === ===
Function setExpected($value; $type : Integer) : Variant
	
	If (Value type:C1509($value)=Is object:K8:27)\
		 && (OB Instance of:C1731($value; 4D:C1709.Function))
		
		// Keep the formula source
		This:C1470.srcExpected:=$value.source
		
		// Evaluating the result
		$value:=$value.call()
		
	End if 
	
	If ($type#0)
		
		This:C1470.type:=$type
		
	Else 
		
		$type:=Value type:C1509($value)
		
		// Treat undefined to null
		$type:=$type=Is undefined:K8:13 ? Is null:K8:31 : $type
		
		// Treat all numeric values as real
		$type:=$type=Is longint:K8:6 ? Is real:K8:4 : $type
		
		If ($type=Is object:K8:27)\
			 && ((OB Instance of:C1731($value; 4D:C1709.File)) | (OB Instance of:C1731($value; 4D:C1709.Folder)))
			
			$type:=-Is object:K8:27
			
		End if 
		
		This:C1470.type:=This:C1470.type || $type
		
	End if 
	
	// Store the expected value
	This:C1470.expected:=This:C1470.type=Is time:K8:8 ? ?00:00:00?+$value : $value
	
	return $value
	
	// === === === === === === === === === === === === === === === === ===
Function setResult($value; $type : Integer) : Variant
	
	If (Value type:C1509($value)=Is object:K8:27)\
		 && (OB Instance of:C1731($value; 4D:C1709.Function))
		
		// Keep the formula source
		This:C1470.srcResult:=$value.source
		
		// Evaluating the result
		$value:=$value.call()
		
	End if 
	
	If ($type#0)
		
		This:C1470.typeResult:=$type
		
	Else 
		
		$type:=Value type:C1509($value)
		
		// Treat undefined to null
		$type:=$type=Is undefined:K8:13 ? Is null:K8:31 : $type
		
		// Treat all numeric values as real
		$type:=$type=Is longint:K8:6 ? Is real:K8:4 : $type
		
		If ($type=Is object:K8:27)\
			 && ((OB Instance of:C1731($value; 4D:C1709.File)) | (OB Instance of:C1731($value; 4D:C1709.Folder)))
			
			$type:=-Is object:K8:27
			
		End if 
		
		
		This:C1470.typeResult:=This:C1470.typeResult || $type
		
	End if 
	
	// Store the result value
	This:C1470.result:=This:C1470.typeResult=Is time:K8:8 ? ?00:00:00?+$value : $value
	
	return $value
	
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
	
	return (This:C1470.type=Is undefined:K8:13) | (This:C1470.type=Is null:K8:31)
	
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
	
	return Abs:C99(This:C1470.type)=Is object:K8:27
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isFile() : Boolean
	
	If (This:C1470.type#-Is object:K8:27) || (This:C1470.expected=Null:C1517)
		
		return 
		
	End if 
	
	return OB Instance of:C1731(This:C1470.expected; 4D:C1709.File)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isFolder() : Boolean
	
	If (This:C1470.type#-Is object:K8:27) || (This:C1470.expected=Null:C1517)
		
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