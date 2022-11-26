Class constructor()
	
	var $c : Collection
	
	$c:=New collection:C1472
	$c[Is BLOB:K8:12]:="BLOB"
	$c[Is boolean:K8:9]:="Boolean"
	$c[Is collection:K8:32]:="Collection"
	$c[Is date:K8:7]:="Date"
	$c[Is longint:K8:6]:="Longint"
	$c[Is null:K8:31]:="Null"
	$c[Is object:K8:27]:="Object"
	$c[Is picture:K8:10]:="Picture"
	$c[Is pointer:K8:14]:="Pointer"
	$c[Is real:K8:4]:="Real"
	$c[Is text:K8:3]:="Text"
	$c[Is time:K8:8]:="Time"
	$c[Is undefined:K8:13]:="Undefined"
	$c[Is variant:K8:33]:="Variant"
	$c[Object array:K8:28]:="Object array"
	
	This:C1470[""]:=New object:C1471("types"; $c)
	
	This:C1470.suite()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function suite($desc : Text) : cs:C1710.ut
	
	This:C1470.desc:=(Length:C16($desc)=0) ? "No name" : $desc
	This:C1470.tests:=New collection:C1472
	This:C1470.failedTests:=New collection:C1472
	
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
		
		return This:C1470.failedTests.length=0
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastError() : Variant
	
	return (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop() : Null:C1517
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastTest() : Object
	
	return (This:C1470.tests.length>0) ? This:C1470.tests.copy().pop() : Null:C1517
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get testNumber() : Integer
	
	return This:C1470.tests.length
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get errorNumber() : Integer
	
	return This:C1470.failedTests.length
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastErrorText() : Text
	
	return (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop().error : ""
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isTrue($test)
	
	This:C1470.current.type:=Is boolean:K8:9
	This:C1470.current.expected:=True:C214
	This:C1470.equal(This:C1470._value($test))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isFalse($test)
	
	This:C1470.current.type:=Is boolean:K8:9
	This:C1470.current.expected:=False:C215
	This:C1470.equal(This:C1470._value($test))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isNull($test)
	
	This:C1470.current.type:=Is null:K8:31
	This:C1470.current.expected:=Null:C1517
	This:C1470.equal(This:C1470._value($test))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isNotNull($test)
	
	This:C1470.current.type:=Is null:K8:31
	This:C1470.current.expected:=New object:C1471  // An arbitray non null value
	This:C1470.equal(This:C1470._value($test))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isEmpty($test)
	
	var $value
	var $current : Object
	
	$current:=This:C1470.current
	$value:=This:C1470._value($test)
	$current.result:=$value
	$current.type:=Value type:C1509($value)
	$current.success:=This:C1470._empty($current)
	
	If ($current.error=Null:C1517) && \
		Not:C34($current.success)
		
		$current.error:=This:C1470.desc+": '"+$current.desc+": as returned an non empty "+This:C1470[""].types[$current.type]
		This:C1470._resume($current)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isNotEmpty($test)
	
	var $value
	var $current : Object
	
	$current:=This:C1470.current
	$value:=This:C1470._value($test)
	$current.result:=$value
	$current.type:=Value type:C1509($value)
	$current.success:=Not:C34(This:C1470._empty($current))
	
	If ($current.error=Null:C1517) && \
		Not:C34($current.success)
		
		$current.error:=This:C1470.desc+": '"+$current.desc+": as returned an empty "+This:C1470[""].types[$current.type]
		This:C1470._resume($current)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isFalsy($test)
	
	var $value
	var $current : Object
	
	$current:=This:C1470.current
	$value:=This:C1470._value($test)
	$current.result:=$value
	$current.type:=Value type:C1509($value)
	$current.success:=This:C1470._falsy($current)
	
	If ($current.error=Null:C1517) && \
		Not:C34($current.success)
		
		$current.error:=This:C1470.desc+": '"+$current.desc+": as returned a not falsy value: "+This:C1470._format($value)
		This:C1470._resume($current)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function isTruthy($test)
	
	var $value
	var $current : Object
	
	$current:=This:C1470.current
	$value:=This:C1470._value($test)
	$current.result:=$value
	$current.type:=Value type:C1509($value)
	$current.success:=Not:C34(This:C1470._falsy($current))
	
	If ($current.error=Null:C1517) && \
		Not:C34($current.success)
		
		$current.error:=This:C1470.desc+": '"+$current.desc+": as returned a not truthy value: "+This:C1470._format($value)
		This:C1470._resume($current)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function toLength($test; $length : Integer)
	
	var $type : Integer
	var $current : Object
	
	$current:=This:C1470.current
	$current.result:=This:C1470._value($test)
	
	$type:=Value type:C1509($current.result)
	
	Case of 
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			This:C1470.equal(Length:C16($current.result))
			
			//______________________________________________________
		: ($type=Is collection:K8:32)
			
			$current.success:=$current.result.length=$current.expected
			This:C1470.equal(This:C1470._value($test).length)
			
			//______________________________________________________
		Else 
			
			$current.error:=This:C1470.desc+": '"+$current.desc+"': toLength() can't be applied to the type "+This:C1470[""].types[$type]
			This:C1470._resume($current)
			
			return 
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _equal($test; $current : Object) : Boolean
	
	var $mask : Picture
	var $type : Integer
	var $value
	
	$value:=This:C1470._value($test)
	$current.result:=$value
	
	If (This:C1470._bypass($current))
		
		return True:C214  // Set the test.success to True
		
	End if 
	
	// Perform the comparison according to type
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
			
			// TURN AROUND ACI0103530: Equal pictures returns False if the 2 pictures are empty
			If (Picture size:C356($current.expected)=0)\
				 && (Picture size:C356($value)=0)
				
				$current.success:=True:C214
				
			Else 
				
				$current.success:=Equal pictures:C1196($current.expected; $value; $mask)
				
			End if 
			
			//______________________________________________________
		: ($type=Is pointer:K8:14)
			
			If (Is nil pointer:C315($value))
				
				$current.success:=Is nil pointer:C315($current.expected)
				
			Else 
				
				$current.success:=$current.expected=$value
				
			End if 
			
			//______________________________________________________
		: ($type=Is BLOB:K8:12)
			
			var $blob; $result : Blob
			var $size : Integer
			
			$blob:=$current.expected
			$result:=$value
			$size:=BLOB size:C605($blob)
			
			If ($size=BLOB size:C605($result))
				
				For ($i; 0; $size-1; 1)
					
					If ($blob{$i}#$result{$i})
						
						$current.success:=False:C215
						return $current.success
						
					End if 
				End for 
				
				$current.success:=True:C214
				return $current.success
				
			Else 
				
				$current.success:=False:C215
				return $current.success
				
			End if 
			
			//______________________________________________________
		Else 
			
			$current.success:=$current.expected=$value
			
			//______________________________________________________
	End case 
	
	return $current.success
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _value($test) : Variant
	
	If (Value type:C1509($test)=Is object:K8:27)\
		 && (OB Instance of:C1731($test; 4D:C1709.Function))
		
		return $test.call()
		
	Else 
		
		return $test
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _bypass($current : Object) : Boolean
	
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
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _resume($test : Object)
	
	This:C1470.failedTests.push($test)
	
	If (Not:C34(Bool:C1537($test.noAssert)))
		
		ASSERT:C1129(False:C215; $test.error)
		
	End if 
	
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
		This:C1470.failedTests.push($current)
		
		If (Not:C34(Bool:C1537($current.noAssert)))
			
			ASSERT:C1129($assertion; $current.error)
			
		End if 
		
	Else 
		
		If (Not:C34(Bool:C1537($current.noAssert)))
			
			ASSERT:C1129(True:C214)  // !! To be counted
			
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
			 && ($valueType=Is null:K8:31)
			
			return $value=Null:C1517 ? "null" : "not null"
			
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
				
				If ($field=0)  // Table
					
					return "->["+Table name:C256($table)+"]"
					
				End if 
				
				return "->["+Table name:C256($table)+"]"+Field name:C257($table; $field)  // Field
				
			End if 
			
			If ($table=-1) & ($field=-1)  // Variable or array
				
				return "->"+$var
				
			End if 
			
			If ($field=-1)  // Element of an array
				
				return "->"+$var+"{"+String:C10($table)+"}"
				
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
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _falsy($current : Object) : Boolean
	
	Case of 
			
			//______________________________________________________
		: ($current.result=Null:C1517)\
			 || (Undefined:C82($current.result))
			
			return True:C214
			
			//______________________________________________________
		: ($current.type=Is boolean:K8:9)
			
			return $current.result=False:C215
			
			//______________________________________________________
		: ($current.type=Is text:K8:3)
			
			return Length:C16($current.result)=0
			
			//______________________________________________________
		: ($current.type=Is date:K8:7)
			
			return $current.result=!00-00-00!
			
			//______________________________________________________
		: ($current.type=Is time:K8:8)
			
			return $current.result=?00:00:00?
			
			//______________________________________________________
		: ($current.type=Is picture:K8:10)
			
			return Picture size:C356($current.result)=0
			
			//______________________________________________________
		: ($current.type=Is BLOB:K8:12)
			
			return BLOB size:C605($current.result)=0
			
			//______________________________________________________
		: ($current.type=Is object:K8:27)
			
			return OB Is empty:C1297($current.result)
			
			//______________________________________________________
		: ($current.type=Is collection:K8:32)
			
			return $current.result.length=0
			
			//______________________________________________________
		: ($current.type=Is integer:K8:5)\
			 || ($current.type=Is real:K8:4)
			
			return $current.result=0
			
			//______________________________________________________
		: ($current.type=Is pointer:K8:14)
			
			return Is nil pointer:C315($current.result)
			
			//______________________________________________________
		Else 
			
			$current.error:=This:C1470.desc+": '"+$current.desc+": isFalsy/Truthy is not managed for the type "+This:C1470[""].types[$current.type]
			This:C1470._resume($current)
			
			return 
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _empty($current : Object) : Boolean
	
	Case of 
			
			//______________________________________________________
		: ($current.type=Is text:K8:3)
			
			return Length:C16($current.result)=0
			
			//______________________________________________________
		: ($current.type=Is object:K8:27)
			
			return OB Is empty:C1297($current.result)
			
			//______________________________________________________
		: ($current.type=Is collection:K8:32)
			
			return $current.result.length=0
			
			//______________________________________________________
		: ($current.type=Is picture:K8:10)
			
			return Picture size:C356($current.result)=0
			
			//______________________________________________________
		: ($current.type=Is BLOB:K8:12)
			
			return BLOB size:C605($current.result)=0
			
			//______________________________________________________
		Else 
			
			$current.error:=This:C1470.desc+": '"+$current.desc+": isEmpty/NotEmpty can't be applied to the type "+This:C1470[""].types[$current.type]
			This:C1470._resume($current)
			
			return 
			
			//______________________________________________________
	End case 