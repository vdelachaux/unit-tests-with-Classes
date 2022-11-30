Class constructor($reporter : 4D:C1709.Function)
	
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
	
	This:C1470._:=New object:C1471("types"; $c)
	
	This:C1470.reporter:=$reporter || Formula:C1597(ASSERT:C1129($1; $2))
	
	This:C1470.suite()
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get successful() : Boolean
	
	If (This:C1470.tests.length>0)
		
		return This:C1470.failedTests.length=0
		
	End if 
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get failed() : Boolean
	
	If (This:C1470.tests.length>0)
		
		return This:C1470.failedTests.length>0
		
	End if 
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get testNumber() : Integer
	
	return This:C1470.tests.length
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get errorNumber() : Integer
	
	return This:C1470.failedTests.length
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get lastError() : Variant
	
	return (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop() : Null:C1517
	
	// <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> <==> 
Function get lastErrorText() : Text
	
	return (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop().error : ""
	
	// === === === === === === === === === === === === === === === === ===
Function suite($desc : Text) : cs:C1710.ut
	
	This:C1470.desc:=(Length:C16($desc)=0) ? "No name" : $desc
	This:C1470.tests:=New collection:C1472
	This:C1470.failedTests:=New collection:C1472
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function feature($desc : Text) : cs:C1710.ut
	
	return This:C1470.suite($desc)
	
	// === === === === === === === === === === === === === === === === ===
Function test($desc : Text; $type : Integer) : cs:C1710.ut
	
	This:C1470.latest:=cs:C1710.test.new($desc; Count parameters:C259>=2 ? $type : Null:C1517)
	This:C1470.tests.push(This:C1470.latest)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function it($desc : Text; $type : Integer) : cs:C1710.ut
	
	If (Count parameters:C259>=2)
		
		return This:C1470.test($desc; $type)
		
	Else 
		
		return This:C1470.test($desc)
		
	End if 
	
	// === === === === === === === === === === === === === === === === ===
Function expect($value; $type : Integer) : cs:C1710.ut
	
	$value:=This:C1470._value($value)
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=2)
		
		$test.type:=$type
		
	Else 
		
		$type:=Value type:C1509($value)
		$type:=$type=Is undefined:K8:13 ? Is null:K8:31 : $type
		$test.type:=$test.type || $type
		
	End if 
	
	If ($test.type=Is time:K8:8)
		
		$test.expected:=?00:00:00?+$value
		
	Else 
		
		$test.expected:=$value
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function strict() : cs:C1710.ut
	
	This:C1470.latest.strict:=True:C214
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function noReport() : cs:C1710.ut
	
	This:C1470.latest.noReport:=True:C214
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function macOS() : cs:C1710.ut
	
	This:C1470.latest.os:=This:C1470.latest.os || New collection:C1472
	This:C1470.latest.os.push("macOS")
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function Windows() : cs:C1710.ut
	
	This:C1470.latest.os:=This:C1470.latest.os || New collection:C1472
	This:C1470.latest.os.push("Windows")
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function Linux() : cs:C1710.ut
	
	This:C1470.latest.os:=This:C1470.latest.os || New collection:C1472
	This:C1470.latest.os.push("Linux")
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isEqualTo($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=2)
		
		$test.type:=$type
		
	Else 
		
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($test.expected) : $test.type
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)\
			 && (Value type:C1509($value)=Is object:K8:27)
			
			$test.result:=This:C1470._value($value)
			$test.success:=This:C1470._equalObject($test.expected; $test.result; $test)
			
			If (Not:C34(Bool:C1537($test.success)))
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)\
			 && (Value type:C1509($value)=Is collection:K8:32)
			
			$test.result:=This:C1470._value($value)
			$test.success:=This:C1470._equalCollection($test.expected; $test.result; $test)
			
			If (Not:C34(Bool:C1537($test.success)))
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		Else 
			
			$test.success:=This:C1470._equal($value; $test)
			
			//______________________________________________________
	End case 
	
	return This:C1470._reporter($test.success)
	
	// === === === === === === === === === === === === === === === === ===
Function isNotEqualTo($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	$test.not:=True:C214
	
	If (Count parameters:C259>=2)
		
		$test.type:=$type
		
	Else 
		
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($test.expected) : $test.type
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)\
			 && (Value type:C1509($value)=Is object:K8:27)
			
			$test.result:=This:C1470._value($value)
			$test.success:=Not:C34(This:C1470._equalObject($test.expected; $test.result; $test))
			
			If (Not:C34(Bool:C1537($test.success)))
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)\
			 && (Value type:C1509($value)=Is collection:K8:32)
			
			$test.result:=This:C1470._value($value)
			$test.success:=Not:C34(This:C1470._equalCollection($test.expected; $test.result; $test))
			
			If (Not:C34(Bool:C1537($test.success)))
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		Else 
			
			$test.success:=Not:C34(This:C1470._equal($value; $test))
			
			//______________________________________________________
	End case 
	
	return This:C1470._reporter($test.success)
	
	// === === === === === === === === === === === === === === === === ===
Function isTrue($value) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
		
	End if 
	
	$test.resultType:=Is boolean:K8:9
	
	If ($test.type=Is boolean:K8:9)
		
		return This:C1470.isEqualTo(True:C214)
		
	End if 
	
	$test.error:=This:C1470.desc+": '"+$test.desc+"': isTrue() cannot be applied to the type "+This:C1470._.types[$test.type]
	return This:C1470._resume($test)
	
	// === === === === === === === === === === === === === === === === ===
Function isFalse($value) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
		
	End if 
	
	$test.resultType:=Is boolean:K8:9
	
	If ($test.type=Is boolean:K8:9)
		
		return This:C1470.isEqualTo(False:C215)
		
	End if 
	
	$test.error:=This:C1470.desc+": '"+$test.desc+"': isFalse() cannot be applied to the type "+This:C1470._.types[$test.type]
	return This:C1470._resume($test)
	
	// === === === === === === === === === === === === === === === === ===
Function isNull($value) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
		
	End if 
	
	$test.resultType:=Is null:K8:31
	$test.success:=This:C1470._null($test)
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	If ($test.error=Null:C1517)
		
		$test.error:=This:C1470.desc+": '"+$test.desc+"' as returned an non null value"
		return This:C1470._resume($test)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNotNull($value) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
		
	End if 
	
	$test.resultType:=Is null:K8:31
	$test.success:=Not:C34(This:C1470._null($test))
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	If ($test.error=Null:C1517)
		
		$test.error:=This:C1470.desc+": '"+$test.desc+"' as returned an non null value"
		return This:C1470._resume($test)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isFalsy($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		
		If (Count parameters:C259>=2)
			
			$test.type:=$type
			
		Else 
			
			$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
			
		End if 
	End if 
	
	$test.success:=This:C1470._falsy($test)
	
	If ($test.success)
		
		return This:C1470
		
	Else 
		
		If ($test.error=Null:C1517)
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"': as returned a not falsy value: '"+This:C1470._format($test.expected; $test.type)+"'"
			return This:C1470._resume($test)
			
		End if 
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isTruthy($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		
		If (Count parameters:C259>=2)
			
			$test.type:=$type
			
		Else 
			
			$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
			
		End if 
	End if 
	
	If (Count parameters:C259>=2)
		
		$test.type:=$type
		
	End if 
	
	$test.success:=Not:C34(This:C1470._falsy($test))
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	If ($test.error=Null:C1517)
		
		$test.error:=This:C1470.desc+": '"+$test.desc+"': as returned a not truthy value: '"+This:C1470._format($test.expected; $test.type)+"'"
		return This:C1470._resume($test)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isEmpty($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		
		If (Count parameters:C259>=2)
			
			$test.type:=$type
			
		Else 
			
			$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
			
		End if 
	End if 
	
	$test.success:=This:C1470._empty($test)
	
	If ($test.successful)
		
		return This:C1470
		
	Else 
		
		If ($test.error=Null:C1517)
			
			$test.error:=This:C1470.desc+": '"+$test.desc+" as returned an non empty "+This:C1470._.types[$test.type]
			return This:C1470._resume($test)
			
		End if 
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNotEmpty($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=This:C1470._value($value)
		$test.expected:=$value
		
		If (Count parameters:C259>=2)
			
			$test.type:=$type
			
		Else 
			
			$test.type:=$test.type=Null:C1517 ? Value type:C1509($value) : $test.type
			
		End if 
	End if 
	
	$test.success:=Not:C34(This:C1470._empty($test))
	
	If ($test.successful)
		
		return This:C1470
		
	Else 
		
		If ($test.error=Null:C1517)
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"' as returned an empty "+This:C1470._.types[$test.type]
			return This:C1470._resume($test)
			
		End if 
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function toLength($value; $length : Integer) : cs:C1710.ut
	
	var $type : Integer
	var $test : cs:C1710.test
	
	$test:=This:C1470.latest
	$test.result:=This:C1470._value($value)
	
	If (Count parameters:C259>=2)
		
		$test.expected:=$length
		$test.type:=$test.type=Null:C1517 ? Value type:C1509($test.expected) : $test.type
		
	End if 
	
	$type:=Value type:C1509($value)
	
	Case of 
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			$test.success:=Length:C16($test.result)=$test.expected
			
			If ($test.failed)
				
				$test.error:=This:C1470.desc+": '"+$test.desc+"': Text length is "+String:C10(Length:C16($test.result))+" when "+String:C10($test.expected)+" was expected"
				
			End if 
			
			return This:C1470._reporter($test.success)
			
			//______________________________________________________
		: ($type=Is collection:K8:32)
			
			$test.success:=$test.result.length=$test.expected
			
			If ($test.failed)
				
				$test.error:=This:C1470.desc+": '"+$test.desc+"': Collection length is "+String:C10(Length:C16($test.result.length))+" when "+String:C10($test.expected)+" was expected"
				
			End if 
			
			return This:C1470._reporter($test.success)
			
			//______________________________________________________
		Else 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"': toLength() can't be applied to the type "+This:C1470._.types[$type]
			return This:C1470._resume($test)
			
			//______________________________________________________
	End case 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _value($test) : Variant
	
	If (Value type:C1509($test)=Is object:K8:27)\
		 && (OB Instance of:C1731($test; 4D:C1709.Function))
		
		return $test.call()
		
	Else 
		
		return $test
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _equal($value; $test : cs:C1710.test) : Boolean
	
	var $mask : Picture
	var $type : Integer
	
	$value:=This:C1470._value($value)
	$test.result:=$value
	
	If (This:C1470._bypass($test))
		
		return True:C214  // Set the test.success to True
		
	End if 
	
	// Perform the comparison according to type
	$type:=Value type:C1509($value)
	
	Case of 
			
			//______________________________________________________
		: ($test.type#Null:C1517)\
			 && ($test.type=Is time:K8:8)
			
			$test.success:=$test.expected=$value
			
			//______________________________________________________
		: ($test.type#Null:C1517)\
			 && ($test.type#$type)
			
			$test.success:=False:C215
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			$test.success:=$test.strict ? This:C1470._strictTextEqual($value; $test.expected) : ($value=$test.expected)
			
			//______________________________________________________
		: ($type=Is picture:K8:10)
			
			// TURN AROUND ACI0103530: Equal pictures returns False if the 2 pictures are empty
			If (Picture size:C356($test.expected)=0)\
				 && (Picture size:C356($value)=0)
				
				$test.success:=True:C214
				
			Else 
				
				$test.success:=Equal pictures:C1196($test.expected; $value; $mask)
				
			End if 
			
			//______________________________________________________
		: ($type=Is pointer:K8:14)
			
			If (Is nil pointer:C315($value))
				
				$test.success:=Is nil pointer:C315($test.expected)
				
			Else 
				
				$test.success:=$test.expected=$value
				
			End if 
			
			//______________________________________________________
		: ($type=Is BLOB:K8:12)
			
			var $blob; $result : Blob
			var $size : Integer
			
			$blob:=$test.expected
			$result:=$value
			$size:=BLOB size:C605($blob)
			
			If ($size=BLOB size:C605($result))
				
				For ($i; 0; $size-1; 1)
					
					If ($blob{$i}#$result{$i})
						
						$test.success:=False:C215
						return $test.success
						
					End if 
				End for 
				
				$test.success:=True:C214
				return $test.success
				
			Else 
				
				$test.success:=False:C215
				return $test.success
				
			End if 
			
			//______________________________________________________
		Else 
			
			$test.success:=$test.expected=$value
			
			//______________________________________________________
	End case 
	
	return $test.success
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _equalObject($expected : Object; $actual : Object; $test : cs:C1710.test; $base : Text) : Boolean
	
	var $property; $uri : Text
	var $actualType; $expectedType : Integer
	var $actualProperties; $expectedProperties : Collection
	
	$expectedProperties:=OB Keys:C1719($expected).orderBy()
	$actualProperties:=OB Keys:C1719($actual).orderBy()
	
	If ($expectedProperties.length#$actualProperties.length)
		
		$test.error:=This:C1470.desc+": '"+$test.desc+"' Property number mismatch "+($base="" ? "" : "'"+$base+"' ")+"ACTUAL ("+String:C10($actualProperties.length)+") EXPECTED ("+String:C10($expectedProperties.length)+")"
		return 
		
	End if 
	
	For each ($property; $expectedProperties)
		
		$uri:=$base+"."+$property
		
		If ($actual[$property]#Null:C1517)
			
			$expectedType:=Value type:C1509($expected[$property])
			$actualType:=Value type:C1509($actual[$property])
			
			If ($expectedType=$actualType)
				
				Case of 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					: ($expectedType=Is collection:K8:32)
						
						This:C1470._equalCollection($expected[$property]; $actual[$property]; $test; $uri)
						
						If ($test.failed)
							
							return 
							
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					: ($expectedType=Is object:K8:27)
						
						This:C1470._equalObject($expected[$property]; $actual[$property]; $test; $uri)
						
						If ($test.failed)
							
							return 
							
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					Else 
						
						If ($expectedType=Is text:K8:3) && ($test.strict)
							
							If (Not:C34(This:C1470._strictTextEqual($actual[$property]; $expected[$property])))
								
								$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' mismatch ACTUAL (\""+This:C1470._format($actual[$property])+"\") EXPECTED (\""+This:C1470._format($expected[$property])+"\")"
								return 
								
							End if 
							
						Else 
							
							If ($actual[$property]#$expected[$property])
								
								$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' mismatch ACTUAL ("+This:C1470._format($actual[$property])+") EXPECTED ("+This:C1470._format($expected[$property])+")"
								return 
								
							End if 
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				End case 
				
			Else 
				
				$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' type mismatch. ACTUAL ("+This:C1470._.types[$actualType]+") EXPECTED ("+This:C1470._.types[$expectedType]+")"
				return 
				
			End if 
			
		Else 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' is missing."
			return 
			
		End if 
	End for each 
	
	return True:C214
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _equalCollection($expected : Collection; $actual : Collection; $test : cs:C1710.test; $base : Text) : Boolean
	
	var $uri : Text
	var $actualType; $expectedType; $i : Integer
	
	If ($expected.length#$actual.length)
		
		$test.error:=This:C1470.desc+": '"+$test.desc+"' Collection properties "+($base="" ? "" : "'"+$base+"' ")+"doesn't have expected length ACTUAL ("+String:C10($actual.length)+") EXPECTED ("+String:C10($expected.length)+")"
		return False:C215
		
	End if 
	
	For ($i; 0; $expected.length-1; 1)
		
		$uri:=$base+"["+String:C10($i)+"]"
		
		$expectedType:=Value type:C1509($expected[$i])
		$actualType:=Value type:C1509($actual[$i])
		
		If ($expectedType=$actualType)
			
			Case of 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				: ($expectedType=Is collection:K8:32)
					
					$test.success:=This:C1470._equalCollection($expected[$i]; $actual[$i]; $test; $uri)
					
					If ($test.failed)
						
						return 
						
					End if 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				: ($expectedType=Is object:K8:27)
					
					$test.success:=This:C1470._equalObject($expected[$i]; $actual[$i]; $test; $uri)
					
					If ($test.failed)
						
						return 
						
					End if 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				Else 
					
					If ($expectedType=Is text:K8:3) && ($test.strict)
						
						If (Not:C34(This:C1470._strictTextEqual($actual[$i]; $expected[$i])))
							
							$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' mismatch ACTUAL (\""+This:C1470._format($actual[$i])+"\") EXPECTED (\""+This:C1470._format($expected[$i])+"\")"
							return 
							
						End if 
						
					Else 
						
						If ($actual[$i]#$expected[$i])
							
							$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' mismatch ACTUAL ("+This:C1470._format($actual[$i])+") EXPECTED ("+This:C1470._format($expected[$i])+")"
							return 
							
						End if 
					End if 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			End case 
			
		Else 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"' Property '"+$uri+"' type mismatch. ACTUAL ("+This:C1470._.types[$actualType]+") EXPECTED ("+This:C1470._.types[$expectedType]+")"
			return 
			
		End if 
	End for 
	
	return True:C214
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _strictTextEqual($value : Text; $expected : Text) : Boolean
	
	var $i : Integer
	
	If (Length:C16($value)#Length:C16($expected))
		
		return 
		
	End if 
	
	//%W-533.1
	//%R-
	For ($i; 1; Length:C16($value); 1)
		
		If (Character code:C91($value[[$i]])#Character code:C91($expected[[$i]]))
			
			return 
			
		End if 
	End for 
	//%R+
	//%W+533.1
	
	return True:C214
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _null($test : cs:C1710.test) : Boolean
	
	return This:C1470._equal(Null:C1517; $test)
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _empty($test : cs:C1710.test) : Boolean
	
	Case of 
			
			//______________________________________________________
		: ($test.type=Is text:K8:3)
			
			return Length:C16($test.expected)=0
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)
			
			return OB Is empty:C1297($test.expected)
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)
			
			return $test.expected.length=0
			
			//______________________________________________________
		: ($test.type=Is picture:K8:10)
			
			return Picture size:C356($test.expected)=0
			
			//______________________________________________________
		: ($test.type=Is BLOB:K8:12)
			
			return BLOB size:C605($test.expected)=0
			
			//______________________________________________________
		Else 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+": isEmpty/isNotEmpty can't be applied to the type "+This:C1470._.types[$test.type]
			return 
			
			//______________________________________________________
	End case 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _falsy($test : cs:C1710.test) : Boolean
	
	Case of 
			
			//______________________________________________________
		: (This:C1470._bypass($test))
			
			return True:C214  // Set the test.success to True
			
			//______________________________________________________
		: ($test.expected=Null:C1517)\
			 || (Undefined:C82($test.expected))
			
			return True:C214
			
			//______________________________________________________
		: ($test.type=Is boolean:K8:9)
			
			return $test.expected=False:C215
			
			//______________________________________________________
		: ($test.type=Is text:K8:3)
			
			return Length:C16($test.expected)=0
			
			//______________________________________________________
		: ($test.type=Is date:K8:7)
			
			return $test.expected=!00-00-00!
			
			//______________________________________________________
		: ($test.type=Is time:K8:8)
			
			return $test.expected=?00:00:00?
			
			//______________________________________________________
		: ($test.type=Is picture:K8:10)
			
			return Picture size:C356($test.expected)=0
			
			//______________________________________________________
		: ($test.type=Is BLOB:K8:12)
			
			return BLOB size:C605($test.expected)=0
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)
			
			return OB Is empty:C1297($test.expected)
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)
			
			return $test.expected.length=0
			
			//______________________________________________________
		: ($test.type=Is integer:K8:5)\
			 || ($test.type=Is real:K8:4)
			
			return $test.expected=0
			
			//______________________________________________________
		: ($test.type=Is pointer:K8:14)
			
			return Is nil pointer:C315($test.expected)
			
			//______________________________________________________
		Else 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"': isFalsy/Truthy is not managed for the type "+This:C1470._.types[$test.type]
			This:C1470._resume($test)
			
			return 
			
			//______________________________________________________
	End case 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _bypass($test : cs:C1710.test) : Boolean
	
	Case of 
			
			//______________________________________________________
		: ($test.os=Null:C1517)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: (Is macOS:C1572 && ($test.os.indexOf("macOS")=-1))
			
			$test.bypassed:=True:C214
			$test.error:="Skipped on macOS"
			return True:C214
			
			//______________________________________________________
		: (Is Windows:C1573 && ($test.os.indexOf("Windows")=-1))
			
			$test.bypassed:=True:C214
			$test.error:="Skipped on Windows"
			return True:C214
			
			//______________________________________________________
		: (Not:C34(Is Windows:C1573) & Not:C34(Is macOS:C1572) & ($test.os.indexOf("Linux")=-1))
			
			$test.bypassed:=True:C214
			$test.error:="Skipped on Linux"
			return True:C214
			
			//______________________________________________________
	End case 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _resume($test : cs:C1710.test) : cs:C1710.ut
	
	If (Not:C34(Bool:C1537($test.success)))
		
		This:C1470.failedTests.push($test)
		
	End if 
	
	If (Not:C34(Bool:C1537($test.noReport)))
		
		This:C1470.reporter(False:C215; String:C10($test.error))
		
	End if 
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _reporter($assertion : Boolean) : cs:C1710.ut
	
	var $test : cs:C1710.test
	
	$test:=This:C1470.latest
	$assertion:=Count parameters:C259>=1 ? $assertion : $test.success
	
	If (Not:C34($assertion))
		
		If ($test.error=Null:C1517) || ($test.error="")
			
			This:C1470.failedTests.push($test)
			
			$test.type:=$test.type || Value type:C1509($test.expected)
			
			If ($test.type=Is time:K8:8)\
				 && ((Value type:C1509($test.result)=Is integer:K8:5) | (Value type:C1509($test.result)=Is real:K8:4))
				
				$test.resultType:=Is time:K8:8
				
			Else 
				
				$test.resultType:=$test.resultType || Value type:C1509($test.result)
				
			End if 
			
			$test.error:=This:C1470.desc+": '"+$test.desc+"' "
			
			If ($test.type#$test.resultType)
				
				$test.error+="TYPE MISMATCH - "+This:C1470._.types[$test.type]+" instead of "
				
				If ($test.type=Is pointer:K8:14) && ($test.resultType=Is null:K8:31)
					
					$test.error+="Nil pointer"
					
				Else 
					
					$test.error+=This:C1470._.types[$test.resultType]
					
				End if 
				
			Else 
				
				$test.error+="gives '"+This:C1470._format($test.expected; $test.type)
				
				If ($test.type=Is null:K8:31)
					
					$test.error+=$test.not ? "' when not '" : "' when '"
					
				Else 
					
					$test.error+="' when '"
					
				End if 
				
				$test.error+=This:C1470._format($test.result; $test.type)+"' was expected"
				
			End if 
			
		Else 
			
			// A "If" statement should never omit "Else" 
			
		End if 
	End if 
	
	If (Not:C34(Bool:C1537($test.noReport)))
		
		This:C1470.reporter($assertion; String:C10($test.error))
		
	End if 
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _format($value; $valueType) : Text
	
	var $type : Integer
	$type:=Value type:C1509($value)
	
	Case of 
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is time:K8:8)
			
			return $value=Null:C1517 ? "null" : String:C10(Time:C179($value))
			
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
			
			$Txt_onErrCallMethod:=Method called on error:C704
			//====================== [
			ON ERR CALL:C155("noError")
			RESOLVE POINTER:C394($value; $var; $table; $field)
			ON ERR CALL:C155($Txt_onErrCallMethod)
			//====================== ]
			
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
	