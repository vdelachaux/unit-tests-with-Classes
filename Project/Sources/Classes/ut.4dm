Class constructor
	
	This:C1470.suite()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function suite($desc : Text) : cs:C1710.ut
	
	This:C1470.desc:=(Length:C16($desc)=0) ? "No name" : $desc
	This:C1470.tests:=New collection:C1472
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function test($desc : Text; $type : Integer) : cs:C1710.ut
	
	This:C1470.current:=New object:C1471(\
		"desc"; $desc; \
		"success"; False:C215; \
		"expected"; Null:C1517; \
		"result"; Null:C1517; \
		"type"; Count parameters:C259>=2 ? $type : Null:C1517)
	
	This:C1470.tests.push(This:C1470.current)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function expect($value) : cs:C1710.ut
	
	If (This:C1470.current.type=Null:C1517)\
		 || (Value type:C1509($value)=This:C1470.current.type)
		
		This:C1470.current.expected:=$value
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function strict() : cs:C1710.ut
	
	This:C1470.current.strict:=True:C214
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function noAssert() : cs:C1710.ut
	
	This:C1470.current.noAssert:=True:C214
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function macOS() : cs:C1710.ut
	
	This:C1470.current.os:=This:C1470.current.os || New collection:C1472
	This:C1470.current.os.push("macOS")
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function Windows() : cs:C1710.ut
	
	This:C1470.current.os:=This:C1470.current.os || New collection:C1472
	This:C1470.current.os.push("Windows")
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function Linux() : cs:C1710.ut
	
	This:C1470.current.os:=This:C1470.current.os || New collection:C1472
	This:C1470.current.os.push("Linux")
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function equal($test)
	
	This:C1470.current.success:=This:C1470._equal($test; This:C1470.current)
	This:C1470._assert(This:C1470.current.success)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function notEqual($test)
	
	This:C1470.current.success:=Not:C34(This:C1470._equal($test; This:C1470.current))
	This:C1470._assert(This:C1470.current.success)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get success() : Boolean
	
	If (This:C1470.tests.length>0)
		
		return This:C1470.tests.query("success = false").length=0
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastError() : Variant
	
	return (This:C1470.tests.length>0) ? This:C1470.tests.copy().query("success = false").pop() : Null:C1517
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastErrorText() : Text
	
	return (This:C1470.tests.length>0) ? This:C1470.tests.copy().query("success = false").pop().error : ""
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _equal($test; $current : Object) : Boolean
	
	var $mask : Picture
	var $type : Integer
	var $value
	
	If (Value type:C1509($test)=Is object:K8:27)\
		 && (OB Instance of:C1731($test; 4D:C1709.Function))
		
		$value:=$test.call()
		
	Else 
		
		$value:=$test
		
	End if 
	
	$current.result:=$value
	
	Case of 
			
			//______________________________________________________
		: ($current.os=Null:C1517)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: (Is macOS:C1572 && ($current.os.indexOf("macOS")=-1))
			
			$current.bypassed:="Skipped on macOS"
			return True:C214
			
			//______________________________________________________
		: (Is Windows:C1573 && ($current.os.indexOf("Windows")=-1))
			
			$current.bypassed:="Skipped on Windows"
			return True:C214
			
			//______________________________________________________
		: (Not:C34(Is Windows:C1573) & Not:C34(Is macOS:C1572) & ($current.os.indexOf("Linux")=-1))
			
			$current.bypassed:="Skipped on Linux"
			return True:C214
			
			//______________________________________________________
	End case 
	
	$type:=Value type:C1509($value)
	
	Case of 
			
			//______________________________________________________
		: ($current.type#Null:C1517)\
			 && ($current.type=Is time:K8:8)
			
			$current.success:=Time:C179($current.expected)=Time:C179($value)
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			If ($current.strict)
				
				var $expected : Text
				var $i : Integer
				
				$expected:=$current.expected
				$current.success:=(Length:C16($value)=Length:C16($expected))
				
				If ($current.success)
					
					//%W-533.1
					//%R-
					For ($i; 1; Length:C16($value); 1)
						
						$current.success:=$current.success & (Character code:C91($value[[$i]])=Character code:C91($expected[[$i]]))
						
						If (Not:C34($current.success))
							
							break
							
						End if 
					End for 
					//%R+
					//%W+533.1
					
				End if 
				
			Else 
				
				$current.success:=$value=$current.expected
				
			End if 
			
			//______________________________________________________
		: ($type=Is object:K8:27)
			
			If (Value type:C1509($current.expected)=Is object:K8:27)
				
				$current.success:=New collection:C1472($current.expected).equal(New collection:C1472($value); $current.strict ? ck diacritical:K85:3 : 0)
				
			End if 
			
			//______________________________________________________
		: ($type=Is collection:K8:32)
			
			If (Value type:C1509($current.expected)=Is collection:K8:32)
				
				$current.success:=$current.expected.equal($value; $current.strict ? ck diacritical:K85:3 : 0)
				
			End if 
			
			//______________________________________________________
		: ($type=Is picture:K8:10)
			
			$current.success:=Equal pictures:C1196($current.expected; $value; $mask)
			
			//______________________________________________________
		: ($type=Is pointer:K8:14)
			
			If (Is nil pointer:C315($value))
				
				$current.success:=Is nil pointer:C315($current.expected)
				
			Else 
				
				$current.success:=$current.expected=$value
				
			End if 
			
			//______________________________________________________
		Else 
			
			$current.success:=$current.expected=$value
			
			//______________________________________________________
	End case 
	
	return $current.success
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _assert($assertion : Boolean) : Boolean
	
	var $expected; $result : Text
	var $current : Object
	
	$current:=This:C1470.current
	$assertion:=Count parameters:C259>=1 ? $assertion : $current.success
	
	If (Not:C34($assertion))
		
		$result:=This:C1470._format($current.result; $current.type)
		$expected:=This:C1470._format($current.expected; $current.type)
		
		$current.error:=This:C1470.desc+": '"+$current.desc+"' gives '"+$result+"' when '"+$expected+"' was expected"
		
		If (Bool:C1537($current.noAssert))
			
			$current.noAssert:=False:C215
			
		Else 
			
			ASSERT:C1129($assertion; $current.error)
			
		End if 
		
	Else 
		
		If (Bool:C1537($current.noAssert))
			
			$current.noAssert:=False:C215
			
		Else 
			
			ASSERT:C1129($assertion)
			
		End if 
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _format($value; $valueType) : Text
	
	var $type : Integer
	$type:=Value type:C1509($value)
	
	Case of 
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is time:K8:8)
			
			return $value=Null:C1517 ? String:C10($value) : String:C10(Time:C179($value))
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is pointer:K8:14)
			
			If ($type=Is null:K8:31)
				
				return "NIL pointer"
				
			End if 
			
			var $var : Text
			var $table; $field : Integer
			RESOLVE POINTER:C394($value; $var; $table; $field)
			
			If (Length:C16($var)=0)
				
				If ($table=0) & ($field=0)
					
					return "NIL pointer"
					
				End if 
				
				If ($field=0)
					
					return "->["+Table name:C256($table)+"]"  // Table
					
				End if 
				
				return "->["+Table name:C256($table)+"]"+Field name:C257($table; $field)  // Field
				
			End if 
			
			If ($table=-1) & ($field=-1)
				
				return "->"+$var  // Variable or array
				
			End if 
			
			If ($field=-1)
				
				return "->"+$var+"{"+String:C10($table)+"}"  // Element of an array
				
			End if 
			
			return "->"+$var+"{"+String:C10($table)+"}{"+String:C10($field)+"}"  // Element of 2D array
			
			//______________________________________________________
		: ($type=Is null:K8:31)
			
			return String:C10($value)
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			return $value=Null:C1517 ? String:C10($value) : $value
			
			//______________________________________________________
		: ($type=Is integer:K8:5)\
			 | ($type=Is real:K8:4)
			
			return $value=Null:C1517 ? String:C10($value) : String:C10($value)
			
			//______________________________________________________
		: ($type=Is boolean:K8:9)
			
			return $value=Null:C1517 ? String:C10($value) : String:C10($value)
			
			//______________________________________________________
		: ($type=Is object:K8:27) || ($type=Is collection:K8:32)
			
			return $value=Null:C1517 ? String:C10($value) : JSON Stringify:C1217($value)
			
			//______________________________________________________
		: ($type=Is picture:K8:10)
			
			If ($value=Null:C1517)
				
				return "picture: empty"
				
			Else 
				
				var $height; $width : Integer
				PICTURE PROPERTIES:C457($value; $width; $height)
				return "picture: "+JSON Stringify:C1217(New object:C1471("size"; Picture size:C356($value); "width"; $width; "height"; $height))
				
			End if 
			
			//______________________________________________________
		: ($type=Is date:K8:7)
			
			return $value=Null:C1517 ? String:C10($value) : String:C10($value)
			
			//______________________________________________________
		: ($type=Is time:K8:8)
			
			return $value=Null:C1517 ? String:C10($value) : String:C10(Time:C179($value))
			
			//______________________________________________________
	End case 