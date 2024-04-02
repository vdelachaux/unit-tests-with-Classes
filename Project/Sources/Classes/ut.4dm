property _ : Object
property reporter : 4D:C1709.Function
property suiteNumber : Integer
property desc : Text
property tests; failedTests : Collection
property latest : cs:C1710.test

Class constructor($reporter : 4D:C1709.Function)
	
	var $c : Collection
	
	$c:=[]
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
	
	This:C1470._:={\
		types: $c; \
		succeededWhenItWasExpectedToFail: "Succeeded when it was expected to fail, "; \
		itShouldNotHaveReturned: "it should not have returned "\
		}
	
	This:C1470.reporter:=$reporter || Formula:C1597(ASSERT:C1129($1; $2))
	
	This:C1470.suiteNumber:=0
	This:C1470.desc:=""
	This:C1470.tests:=Null:C1517
	This:C1470.failedTests:=Null:C1517
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get successful() : Boolean
	
	If (This:C1470.tests#Null:C1517) && (This:C1470.tests.length>0) && (This:C1470.failedTests#Null:C1517)
		
		return This:C1470.failedTests.length=0
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get failed() : Boolean
	
	If (This:C1470.tests#Null:C1517) && (This:C1470.tests.length>0) && (This:C1470.failedTests#Null:C1517)
		
		return This:C1470.failedTests.length>0
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get testNumber() : Integer
	
	If (This:C1470.tests#Null:C1517)
		
		return This:C1470.tests.length
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get errorNumber() : Integer
	
	If (This:C1470.failedTests#Null:C1517)
		
		return This:C1470.failedTests.length
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get lastError() : Variant
	
	return (This:C1470.failedTests#Null:C1517) && (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop() : Null:C1517
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get lastErrorText() : Text
	
	return (This:C1470.failedTests#Null:C1517) && (This:C1470.failedTests.length>0) ? This:C1470.failedTests.copy().pop().error : ""
	
	//MARK:-Keywords
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get not() : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.noReport:=True:C214
	$test.not:=True:C214
	
	return This:C1470
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get strictly() : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.strict:=True:C214
	
	return This:C1470
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get try() : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.try:=True:C214
	
	return This:C1470
	
	//MARK:-Definition
	// === === === === === === === === === === === === === === === === ===
Function suite($desc : Text) : cs:C1710.ut
	
	This:C1470.suiteNumber+=1
	
	$desc:=Length:C16($desc)=0 ? "Suite "+String:C10(This:C1470.suiteNumber) : $desc
	
	This:C1470.desc:=$desc
	This:C1470.tests:=[]
	This:C1470.failedTests:=[]
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function feature($desc : Text) : cs:C1710.ut
	
	return This:C1470.suite($desc)
	
	// === === === === === === === === === === === === === === === === ===
Function test($desc : Text; $type : Integer) : cs:C1710.ut
	
	This:C1470.tests:=This:C1470.tests || []
	
	If (This:C1470.suiteNumber=0)
		
		This:C1470.suite()
		
	End if 
	
	If (Length:C16($desc)=0)
		
		$desc:="Test "+String:C10(This:C1470.tests.length+1)
		
	Else 
		
		var $counter : Integer
		var $t : Text
		$t:=$desc
		
		While (This:C1470.tests.query("desc = :1"; $desc).length>0)
			
			$counter+=1
			$desc:=$t+" "+String:C10(($counter))
			
		End while 
	End if 
	
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
	
	This:C1470.latest.setExpected($value; $type)
	
	return This:C1470
	
	//MARK:-
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
	
	This:C1470.latest.os:=This:C1470.latest.os || []
	This:C1470.latest.os.push("macOS")
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function Windows() : cs:C1710.ut
	
	This:C1470.latest.os:=This:C1470.latest.os || []
	This:C1470.latest.os.push("Windows")
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function Linux() : cs:C1710.ut
	
	This:C1470.latest.os:=This:C1470.latest.os || []
	This:C1470.latest.os.push("Linux")
	return This:C1470
	
	//MARK:-
	// === === === === === === === === === === === === === === === === ===
Function isEqualTo($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	$value:=$test.setResult($value; $type)
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	Case of 
			
			//______________________________________________________
		: ((Abs:C99($test.type)=Is object:K8:27) | (Abs:C99($test.typeResult)=Is object:K8:27))\
			 && ($value#Null:C1517) && ($test.expected#Null:C1517)\
			 && (((Abs:C99($test.typeResult)=Is object:K8:27) && (OB Instance of:C1731($value; 4D:C1709.File))) | ((Abs:C99($test.type)=Is object:K8:27) && OB Instance of:C1731($test.expected; 4D:C1709.File)))
			
			// Compare the 2 files contents
			$test.typeResult:=-Is object:K8:27
			$test.type:=-Is object:K8:27
			
			$test.success:=This:C1470._equal($value; $test)
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)\
			 && ($test.typeResult=Is object:K8:27)
			
			$test.success:=This:C1470._equalObject($test.expected; $test.result; $test)
			
			If ($test.failed)
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)\
			 && ($test.typeResult=Is collection:K8:32)
			
			$test.success:=This:C1470._equalCollection($test.expected; $test.result; $test)
			
			If ($test.failed)
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		Else 
			
			$test.success:=This:C1470._equal($value; $test)
			
			//______________________________________________________
	End case 
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+This:C1470._getResult($test)
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	This:C1470._reporter($test.success)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNotEqualTo($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	$value:=$test.setResult($value; $type)
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	$test.not:=True:C214
	
	Case of 
			
			//______________________________________________________
		: ($test.type=Is object:K8:27)\
			 && ($test.typeResult=Is object:K8:27)
			
			$test.success:=Not:C34(This:C1470._equalObject($test.expected; $test.result; $test))
			
			If ($test.failed)
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		: ($test.type=Is collection:K8:32)\
			 && ($test.typeResult=Is collection:K8:32)
			
			$test.success:=Not:C34(This:C1470._equalCollection($test.expected; $test.result; $test))
			
			If ($test.failed)
				
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		Else 
			
			$test.success:=Not:C34(This:C1470._equal($value; $test))
			
			//______________________________________________________
	End case 
	
	This:C1470._reporter($test.success)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isTrue($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value)
		
	End if 
	
	$test.typeResult:=Is boolean:K8:9
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	If (Count parameters:C259>=1)\
		 && (Value type:C1509($value)=Is object:K8:27)\
		 && ((OB Instance of:C1731($value; 4D:C1709.File)) | (OB Instance of:C1731($value; 4D:C1709.Folder)))
		
		$test.success:=$value.exists
		
		If ($test.not)
			
			$test.noReport:=False:C215
			$test.success:=Not:C34($test.success)
			
			If ($test.failed)
				
				$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+"an existing target: "+This:C1470._stringify($value)
				This:C1470._resume($test)
				
				If ($test.deferredError#Null:C1517)
					
					throw:C1805($test.deferredError)
					
				End if 
				
				return This:C1470
				
			End if 
		End if 
		
		If ($test.success)
			
			return This:C1470
			
		End if 
		
		If ($test.error=Null:C1517)
			
			$test.error:=This:C1470._header()+This:C1470._stringify($value)+" doesn't exists"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.type=Is boolean:K8:9)
		
		$test.success:=$test.expected
		
		If ($test.not)
			
			$test.noReport:=False:C215
			$test.success:=Not:C34($test.success)
			
			If ($test.failed)
				
				$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+"value is "+This:C1470._getExpected($test)
				This:C1470._resume($test)
				
				If ($test.deferredError#Null:C1517)
					
					throw:C1805($test.deferredError)
					
				End if 
				
				return This:C1470
				
			End if 
		End if 
		
		If (Not:C34($test.success))
			
			$test.error:=This:C1470._header()+"Failed, value is "+This:C1470._getExpected($test)
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
		End if 
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+Current method name:C684+"() cannot be applied to the type "+This:C1470._.types[$test.type] : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isFalse($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value)
		
	End if 
	
	$test.typeResult:=Is boolean:K8:9
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	If (Count parameters:C259>=1)\
		 && (Value type:C1509($value)=Is object:K8:27)\
		 && ((OB Instance of:C1731($value; 4D:C1709.File)) | (OB Instance of:C1731($value; 4D:C1709.Folder)))
		
		$test.success:=Not:C34($value.exists)
		
		If ($test.not)
			
			$test.noReport:=False:C215
			$test.success:=Not:C34($test.success)
			
			If ($test.failed)
				
				$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+"a non existing target "+This:C1470._stringify($value; True:C214)
				This:C1470._resume($test)
				
				If ($test.deferredError#Null:C1517)
					
					throw:C1805($test.deferredError)
					
				End if 
				
				return This:C1470
				
			End if 
		End if 
		
		If ($test.success)
			
			return This:C1470
			
		End if 
		
		If ($test.error=Null:C1517)
			
			$test.error:=This:C1470._header()+This:C1470._stringify($value)+" exists"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	$test.typeResult:=Is boolean:K8:9
	
	If ($test.type=Is boolean:K8:9)
		
		$test.success:=Not:C34($test.expected)
		
		If ($test.not)
			
			$test.noReport:=False:C215
			$test.success:=Not:C34($test.success)
			
			If ($test.failed)
				
				$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+"value is "+This:C1470._getExpected($test)
				This:C1470._resume($test)
				
				If ($test.deferredError#Null:C1517)
					
					throw:C1805($test.deferredError)
					
				End if 
				
				return This:C1470
				
			End if 
		End if 
		
		If ($test.success)
			
			return This:C1470
			
		End if 
		
		If (Not:C34($test.success))
			
			$test.error:=This:C1470._header()+"Failed, value is "+This:C1470._getExpected($test)
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
		End if 
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+Current method name:C684+"() cannot be applied to the type "+This:C1470._.types[$test.type] : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNull($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value)
		
	End if 
	
	$test.typeResult:=Is null:K8:31
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=This:C1470._equal(Null:C1517; $test)
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+"a null value"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"returned a non-null value" : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNotNull($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value)
		
	End if 
	
	$test.typeResult:=Is null:K8:31
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=Not:C34(This:C1470._equal(Null:C1517; $test))
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+"returned "+This:C1470._getExpected($test)+" instead of a null value"
			
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"returned a null value" : $test.error
	
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isFalsy($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; $type)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=This:C1470._falsy($test)
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getExpected($test)+" is a falsy value"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"as returned a not falsy value: "+This:C1470._getExpected($test) : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isTruthy($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; $type)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=Not:C34(This:C1470._falsy($test))
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getExpected($test)+" is a truthy value"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"as returned a not truthy value: "+This:C1470._getExpected($test) : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _falsy($test : cs:C1710.test) : Boolean
	
	Case of 
			
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
		: ($test.isNumeric)
			
			return $test.expected=0
			
			//______________________________________________________
		: ($test.type=Is pointer:K8:14)
			
			return Is nil pointer:C315($test.expected)
			
			//______________________________________________________
		Else 
			
			$test.keepError+=1
			$test.type:=Value type:C1509($test.expected)
			$test.error:=This:C1470._header()+"ut.isFalsy() or ut.isTruthy() is not managed for the type "+This:C1470._.types[$test.type]
			This:C1470._resume($test)
			
			return 
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === ===
Function isEmpty($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; $type)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=This:C1470._empty($test)
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+"an empty "+This:C1470._.types[$test.type]
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"as returned an non empty "+This:C1470._.types[$test.type] : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isNotEmpty($value; $type : Integer) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; $type)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=Not:C34(This:C1470._empty($test)) & ($test.error=Null:C1517)
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getExpected($test)+" is not an empty value"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"as returned an empty "+This:C1470._.types[$test.type] : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
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
		: ($test.type=Is date:K8:7)
			
			return $test.expected=!00-00-00!
			
			//______________________________________________________
		: ($test.type=Is time:K8:8)
			
			return $test.expected=?00:00:00?
			
			//______________________________________________________
		Else 
			
			$test.keepError+=1
			$test.type:=Value type:C1509($test.expected)
			$test.error:=This:C1470._header()+"ut.isEmpty() or ut.isNotEmpty() can't be applied to the type "+This:C1470._.types[$test.type]
			This:C1470._resume($test)
			
			return 
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === ===
Function toLength($value; $length : Integer) : cs:C1710.ut
	
	var $type : Integer:=Value type:C1509($value)
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setResult($value; $type)
		
		If (Count parameters:C259>=2)
			
			$test.setExpected($length)
			
		End if 
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	Case of 
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			$test.success:=Length:C16($test.result)=$test.expected
			
			If ($test.not)
				
				$test.noReport:=False:C215
				$test.success:=Not:C34($test.success)
				
				If ($test.failed)
					
					$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getResult($test)+" should not return a length of "+String:C10(Length:C16($test.result))
					This:C1470._resume($test)
					
					If ($test.deferredError#Null:C1517)
						
						throw:C1805($test.deferredError)
						
					End if 
					
					return This:C1470
					
				End if 
			End if 
			
			If ($test.success)
				
				return This:C1470
				
			End if 
			
			$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"Text length is "+String:C10(Length:C16($test.result))+" when "+String:C10($test.expected)+" was expected" : $test.error
			
			//______________________________________________________
		: ($type=Is collection:K8:32)
			
			$test.success:=$test.result.length=$test.expected
			
			If ($test.not)
				
				$test.noReport:=False:C215
				$test.success:=Not:C34($test.success)
				
				If ($test.failed)
					
					$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getResult($test)+" should not return a length of "+String:C10($test.result.length)
					This:C1470._resume($test)
					
					If ($test.deferredError#Null:C1517)
						
						throw:C1805($test.deferredError)
						
					End if 
					
					return This:C1470
					
				End if 
			End if 
			
			If ($test.successful)
				
				return This:C1470
				
			End if 
			
			$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"Collection length is "+String:C10($test.result.length)+" when "+String:C10($test.expected)+" was expected" : $test.error
			
			//______________________________________________________
		Else 
			
			$test.error:=$test.error=Null:C1517 ? This:C1470._header()+Current method name:C684+"() can't be applied to the type "+This:C1470._.types[$type] : $test.error
			
			//______________________________________________________
	End case 
	
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function in($list : Collection) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=$list.includes($test.expected)
	
	var $this : cs:C1710.ut:=This:C1470
	$list:=$list.map(Formula:C1597($this._stringify($1.value)))
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+"Succeeded when it was expected to fail: "+This:C1470._getExpected($test)+" should not in ['"+$list.join("'; '")+"']"
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
			End if 
			
			return This:C1470
			
		End if 
	End if 
	
	If ($test.success)
		
		return This:C1470
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+"gives "+This:C1470._getExpected($test)+" when "+This:C1470._quotted($list.join("' or '"))+" was expected" : $test.error
	This:C1470._resume($test)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isLessThan($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setResult($value)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	This:C1470._compareNum($value; "<")
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isLessOrEqualTo($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setResult($value)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	This:C1470._compareNum($value; "<=")
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isGreaterThan($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setResult($value)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	This:C1470._compareNum($value; ">")
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isGreaterOrEqualTo($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setResult($value)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	This:C1470._compareNum($value; ">=")
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _compareNum($value; $operator : Text)
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	$test.keepError+=1
	
	Case of 
			
			//______________________________________________________
		: ($test.type#Is real:K8:4)
			
			$test.success:=False:C215
			$test.error:=This:C1470._header()+"Unable to cast "+This:C1470._getExpected($test)+" to num"
			This:C1470._resume($test)
			
			return 
			
			//______________________________________________________
		: ($test.typeResult#Is real:K8:4)
			
			$test.success:=False:C215
			$test.error:=This:C1470._header()+"Unable to cast "+This:C1470._getResult($test)+" to num"
			This:C1470._resume($test)
			
			return 
			
			//______________________________________________________
	End case 
	
	$test.success:=Formula from string:C1601(String:C10($test.expected)+$operator+String:C10($test.result)).call()
	
	var $name : Text
	
	Case of 
			
			//______________________________________________________
		: ($operator="<")
			
			$name:="less"
			
			//______________________________________________________
		: ($operator="<=")
			
			$name:="less or equal"
			
			//______________________________________________________
		: ($operator=">")
			
			$name:="greater"
			
			//______________________________________________________
		: ($operator=">=")
			
			$name:="greater or equal"
			
			//______________________________________________________
	End case 
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._getExpected($test)
			$test.error+=" is  "+$name+" than "+This:C1470._getResult($test)
			This:C1470._resume($test)
			
		End if 
	End if 
	
	If ($test.success)
		
		return 
		
	End if 
	
	$test.error:=$test.error=Null:C1517 ? This:C1470._header()+This:C1470._getExpected($test)+" is not "+$name+" than "+This:C1470._getResult($test) : $test.error
	This:C1470._resume($test)
	
	// === === === === === === === === === === === === === === === === ===
Function isObject($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is object:K8:27)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isCollection($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is collection:K8:32)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isText($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is text:K8:3)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isPicture($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is picture:K8:10)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isBoolean($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is boolean:K8:9)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isUndefined($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is null:K8:31)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isBlob($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is BLOB:K8:12)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isPointer($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is pointer:K8:14)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isDate($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is date:K8:7)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isTime($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	$test.keepError+=1
	
	This:C1470._isType($value; Is time:K8:8)
	
	If ($test.deferredError#Null:C1517)
		
		throw:C1805($test.deferredError)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isFile($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; -Is object:K8:27)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=($test.type=-Is object:K8:27) && (OB Instance of:C1731($test.expected; 4D:C1709.File))
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+" "+This:C1470._getExpected($test)
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
				return This:C1470
				
			End if 
		End if 
	End if 
	
	If ($test.successful)
		
		return This:C1470
		
	End if 
	
	If ($test.error=Null:C1517)
		
		$test.error:=This:C1470._header()+This:C1470._getExpected($test)+" is not a file"
		This:C1470._resume($test)
		
		If ($test.deferredError#Null:C1517)
			
			throw:C1805($test.deferredError)
			
		End if 
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === ===
Function isFolder($value) : cs:C1710.ut
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$value:=$test.setExpected($value; -Is object:K8:27)
		
	End if 
	
	If (This:C1470._bypass($test))
		
		return This:C1470
		
	End if 
	
	$test.keepError+=1
	
	$test.success:=($test.type=-Is object:K8:27) && (OB Instance of:C1731($test.expected; 4D:C1709.Folder))
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+" "+This:C1470._getExpected($test)
			This:C1470._resume($test)
			
			If ($test.deferredError#Null:C1517)
				
				throw:C1805($test.deferredError)
				
				return This:C1470
				
			End if 
		End if 
	End if 
	
	If ($test.successful)
		
		return This:C1470
		
	End if 
	
	If ($test.error=Null:C1517)
		
		$test.error:=This:C1470._header()+This:C1470._getExpected($test)+" is not a folder"
		This:C1470._resume($test)
		
		If ($test.deferredError#Null:C1517)
			
			throw:C1805($test.deferredError)
			
		End if 
	End if 
	
	return This:C1470
	
	//MARK:-
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _isType($value; $whatType : Integer)
	
	var $test : cs:C1710.test
	$test:=This:C1470.latest
	
	$test.keepError+=1
	
	If (Count parameters:C259>=1)
		
		$test.setExpected($value)
		
	End if 
	
	$test.typeResult:=$whatType
	$test.success:=$test.type=$whatType
	
	If ($test.not)
		
		$test.noReport:=False:C215
		$test.success:=Not:C34($test.success)
		
		If ($test.failed)
			
			$test.error:=This:C1470._header()+This:C1470._.succeededWhenItWasExpectedToFail+This:C1470._.itShouldNotHaveReturned+": "+This:C1470._getExpected($test)
			This:C1470._resume($test)
			
		End if 
	End if 
	
	This:C1470._reporter($test.success)
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _getExpected($test : cs:C1710.test) : Text
	
	$test:=$test || This:C1470.latest
	
	If ($test.srcExpected#Null:C1517)
		
		return This:C1470._quotted($test.srcExpected)+" -> "+This:C1470._stringify($test.expected; $test.type; True:C214)
		
	Else 
		
		return This:C1470._stringify($test.expected; $test.type; True:C214)
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _getResult($test : cs:C1710.test) : Text
	
	$test:=$test || This:C1470.latest
	
	If ($test.srcResult#Null:C1517)
		
		return This:C1470._quotted($test.srcResult)+" -> "+This:C1470._stringify($test.result; $test.type; True:C214)
		
	Else 
		
		return This:C1470._stringify($test.result; $test.type; True:C214)
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _equal($value; $test : cs:C1710.test) : Boolean
	
	$test.keepError+=1
	
	Case of 
			
			//______________________________________________________
		: ($test.type#Null:C1517)\
			 && ($test.type=Is time:K8:8)
			
			$test.success:=$test.expected=$value
			
			//______________________________________________________
		: ($test.typeResult=Is null:K8:31)
			
			$test.success:=$test.expected=Null:C1517
			
			//______________________________________________________
		: ($test.type#Null:C1517)\
			 && ($test.type#$test.typeResult)
			
			$test.success:=False:C215
			
			If (Not:C34($test.not))
				
				$test.error:=This:C1470._header()
				$test.error+="TYPE MISMATCH - actual is "+This:C1470._quotted(This:C1470._.types[$test.type])+" instead of "+This:C1470._quotted(This:C1470._.types[Abs:C99($test.typeResult)])
				This:C1470.failedTests.push($test)
				
			End if 
			
			//______________________________________________________
		: ($test.typeResult=-Is object:K8:27)\
			 && ($test.type=-Is object:K8:27)
			
			// TODO: Manage binary files (images…)
			var $content : Text
			If (Value type:C1509($value)=Is object:K8:27)\
				 && (OB Instance of:C1731($value; 4D:C1709.File))
				
				$content:=$value.getText()
				
			Else 
				
				$content:=$value
				
			End if 
			
			If (Value type:C1509($test.expected)=Is object:K8:27)\
				 && (OB Instance of:C1731($test.expected; 4D:C1709.File))
				
				var $expected : Text:=$test.expected.getText()
				
			Else 
				
				$expected:=String:C10($test.expected)
				
			End if 
			
			$test.success:=$expected=$content
			
			If (Not:C34($test.success))
				
				var $maxLines : Integer:=50
				
				If (Value type:C1509($value)=Is object:K8:27)\
					 && (OB Instance of:C1731($value; 4D:C1709.File))\
					 && (Value type:C1509($test.expected)=Is object:K8:27)\
					 && (OB Instance of:C1731($test.expected; 4D:C1709.File))
					
					var $c : Collection:=[]
					$c.push(Is macOS:C1572 ? "diff" : "fc.exe /w")
					$c.push(This:C1470._quotted(File:C1566($value.platformPath; fk platform path:K87:2).path))
					$c.push(This:C1470._quotted(File:C1566($test.expected.platformPath; fk platform path:K87:2).path))
					
					SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
					
					var $inputStream; $outpoutStream : Text
					Try(LAUNCH EXTERNAL PROCESS:C811($c.join(" "); $inputStream; $outpoutStream))
					
					$c:=Split string:C1554($outpoutStream; "\n"; sk ignore empty strings:K86:1)
					
					If (Is Windows:C1573)
						
						var $file1; $file2; $target : Collection
						var $line : Text
						
						For each ($line; $c)
							
							If ($line="*****@")
								
								Case of 
										
										//_______________________
									: ($file1=Null:C1517)
										
										$file1:=[]
										$target:=$file1
										
										//_______________________
									: ($file2=Null:C1517)
										
										$file1.push("---")
										$file2:=[]
										$target:=$file2
										
										//_______________________
									Else 
										
										break
										
										//_______________________
								End case 
								
								continue
								
							End if 
							
							$target.push($line)
							
							If ($target.length>($maxLines/2))
								
								break
								
							End if 
							
						End for each 
						
						$c:=$file1.combine($file2)
						
					End if 
					
					$test.error:=This:C1470._header()
					$test.error+="DIFF:\n"
					$c:=$c.length>$maxLines ? $c.resize($maxLines) : $c
					$test.error+=$c.join("\n")
					This:C1470.failedTests.push($test)
					
				End if 
			End if 
			
			//______________________________________________________
		: ($test.typeResult=Is text:K8:3)
			
			$test.success:=$test.strict ? This:C1470._strictTextEqual($value; $test.expected) : $test.expected=$value
			
			//______________________________________________________
		: ($test.typeResult=Is picture:K8:10)
			
			var $mask : Picture
			$test.success:=Equal pictures:C1196($test.expected; $value; $mask)
			
			//______________________________________________________
		: ($test.typeResult=Is pointer:K8:14)
			
			$test.success:=Is nil pointer:C315($value) ? Is nil pointer:C315($test.expected) : $test.expected=$value
			
			//______________________________________________________
		: ($test.typeResult=Is BLOB:K8:12)
			
			var $blob; $result : Blob
			var $i; $size : Integer
			
			$blob:=$test.expected
			$result:=$value
			$size:=BLOB size:C605($blob)
			
			If ($size=BLOB size:C605($result))
				
				For ($i; 0; $size-1; 1)
					
					If ($blob{$i}#$result{$i})
						
						$test.success:=False:C215
						return 
						
					End if 
				End for 
				
				$test.success:=True:C214
				return 
				
			Else 
				
				$test.success:=False:C215
				return 
				
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
	var $actualType; $expectedType; $indx : Integer
	var $actualProperties; $expectedProperties : Collection
	
	$expectedProperties:=OB Keys:C1719($expected).orderBy()
	$actualProperties:=OB Keys:C1719($actual).orderBy()
	
	If ($expectedProperties.length#$actualProperties.length)
		
		$test.error:=This:C1470._header()+"Property number "+($base="" ? "" : " of "+This:C1470._quotted($base)+" ")+"is "+String:C10($actualProperties.length)+" when "+String:C10($expectedProperties.length)+" was expected"
		return 
		
	End if 
	
	For each ($property; $expectedProperties)
		
		$uri:=$base+"."+$property
		
		If ($actualProperties.indexOf($property)=$indx)
			
			$expectedType:=Value type:C1509($expected[$property])
			$actualType:=Value type:C1509($actual[$property])
			
			If ($expectedType=$actualType)
				
				Case of 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					: ($expectedType=Is collection:K8:32)
						
						$test.success:=This:C1470._equalCollection($expected[$property]; $actual[$property]; $test; $uri)
						
						If ($test.failed)
							
							return 
							
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					: ($expectedType=Is object:K8:27)
						
						$test.success:=This:C1470._equalObject($expected[$property]; $actual[$property]; $test; $uri)
						
						If ($test.failed)
							
							return 
							
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
					Else 
						
						If ($expectedType=Is text:K8:3) && ($test.strict)
							
							If (Not:C34(This:C1470._strictTextEqual($actual[$property]; $expected[$property])))
								
								$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" gives "+This:C1470._stringify($expected[$property]; True:C214)+" when "+This:C1470._stringify($actual[$property]; True:C214)+" was strictly expected"
								return 
								
							End if 
							
						Else 
							
							If ($actual[$property]#$expected[$property])
								
								$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" gives "+This:C1470._stringify($expected[$property]; True:C214)+" when "+This:C1470._stringify($actual[$property]; True:C214)+" was expected"
								return 
								
							End if 
						End if 
						
						//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				End case 
				
			Else 
				
				$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" type is "+This:C1470._quotted(This:C1470._.types[$expectedType])+" when "+This:C1470._quotted(This:C1470._.types[$actualType])+" was expected"
				return 
				
			End if 
			
		Else 
			
			$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" is missing."
			return 
			
		End if 
		
		$indx+=1
		
	End for each 
	
	return True:C214
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _equalCollection($expected : Collection; $actual : Collection; $test : cs:C1710.test; $base : Text) : Boolean
	
	var $uri : Text
	var $actualType; $expectedType; $i : Integer
	
	If ($expected.length#$actual.length)
		
		$test.error:=This:C1470._header()+($base="" ? "" : This:C1470._quotted($base)+" ")+"the number of properties is not the expected one, currently "+String:C10($expected.length)+" whereas "+String:C10($actual.length)+" was expected"
		
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
							
							$test.error:=This:C1470._header()+"Property "+$uri+" is "+This:C1470._stringify($expected[$i]; True:C214)+" when "+This:C1470._stringify($actual[$i]; True:C214)+" was strictly expected"
							
							return 
							
						End if 
						
					Else 
						
						If ($actual[$i]#$expected[$i])
							
							$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" mismatch EXPECTED ("+This:C1470._stringify($actual[$i])+") ACTUAL ("+This:C1470._stringify($expected[$i])+")"
							return 
							
						End if 
					End if 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			End case 
			
		Else 
			
			$test.error:=This:C1470._header()+"Property "+This:C1470._quotted($uri)+" type mismatch. EXPECTED ("+This:C1470._.types[$actualType]+") ACTUAL ("+This:C1470._.types[$expectedType]+")"
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
Function _bypass($test : cs:C1710.test) : Boolean
	
	Case of 
			
			//______________________________________________________
		: ($test.os=Null:C1517)
			
			return 
			
			//______________________________________________________
		: (Is macOS:C1572 && Not:C34($test.os.includes("macOS")))
			
			$test.bypassed:=True:C214
			$test.success:=True:C214
			$test.error:="Skipped on macOS"
			
			return True:C214
			
			//______________________________________________________
		: (Is Windows:C1573 && Not:C34($test.os.includes("Windows")))
			
			$test.bypassed:=True:C214
			$test.success:=True:C214
			$test.error:="Skipped on Windows"
			
			return True:C214
			
			//______________________________________________________
		: (Not:C34(Is Windows:C1573) & Not:C34(Is macOS:C1572) & Not:C34($test.os.includes("Linux")))
			
			$test.bypassed:=True:C214
			$test.success:=True:C214
			$test.error:="Skipped on Linux"
			
			return True:C214
			
			//______________________________________________________
	End case 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _resume($test : cs:C1710.test)
	
	If (Not:C34(Bool:C1537($test.success)))
		
		This:C1470.failedTests.push($test)
		
	End if 
	
	If ($test.noReport)\
		 || ($test.try)
		
		return 
		
	End if 
	
	var $error : Object
	
	If (This:C1470.reporter.source="ASSERT($1; $2)")
		
		$error:={\
			componentSignature: "4DRT"; \
			errCode: -10518; \
			deferred: True:C214; \
			message: String:C10($test.error)\
			}
		
		$test.keepError-=1
		
		If ($test.keepError<0)
			
			throw:C1805($error)
			
		Else 
			
			$test.deferredError:=$error
			
		End if 
		
	Else 
		
		This:C1470.reporter.call(Null:C1517; $test.success; String:C10($test.error))
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _reporter($assertion : Boolean)
	
	var $test : cs:C1710.test:=This:C1470.latest
	
	$assertion:=Count parameters:C259>=1 ? $assertion : $test.success
	
	If (Not:C34($assertion))
		
		If ($test.error=Null:C1517) || ($test.error="")
			
			This:C1470.failedTests.push($test)
			
			If ($test.type=Is time:K8:8)\
				 && (($test.typeResult=Is longint:K8:6) | ($test.typeResult=Is real:K8:4))
				
				$test.typeResult:=Is time:K8:8
				
			Else 
				
				$test.typeResult:=$test.typeResult || Value type:C1509($test.result)
				
			End if 
			
			$test.error:=This:C1470._header()
			
			If ($test.type#$test.typeResult)
				
				If ($test.type=Is pointer:K8:14)\
					 && ($test.typeResult=Is pointer:K8:14)
					
					var $varName : Text
					var $tableNum; $fieldNum : Integer
					RESOLVE POINTER:C394($test.expected; $varName; $tableNum; $fieldNum)
					
					$test.error+="gives "+This:C1470._quotted("->"+$varName)+" when 'Nil pointer' was expected"
					
				Else 
					
					$test.error+="TYPE MISMATCH - actual is "+This:C1470._quotted(This:C1470._.types[$test.type])+" instead of "+This:C1470._quotted(This:C1470._.types[$test.typeResult])
					
				End if 
				
			Else 
				
				var $t : Text:=This:C1470._getResult($test)
				
				If ($t="Formula@")
					
					$test.error+=$t
					
				Else 
					
					$test.error+="gives "+$t
					
				End if 
				
				If ($test.type=Is null:K8:31)
					
					$test.error+=$test.not ? " when not " : " when "
					
				Else 
					
					$test.error+=" when "
					
				End if 
				
				$test.error+=This:C1470._getExpected($test)
				$test.error+=$test.strict ? " was strictly" : " was"
				$test.error+=" expected"
				
			End if 
		End if 
		
	End if 
	
	If ($assertion)
		
		return 
		
	End if 
	
	If ($test.noReport)\
		 || ($test.try)
		
		return 
		
	End if 
	
	var $error : Object
	
	If (This:C1470.reporter.source="ASSERT($1; $2)")
		
		$error:={\
			componentSignature: "4DRT"; \
			errCode: -10518; \
			deferred: True:C214; \
			message: String:C10($test.error)\
			}
		
		$test.keepError-=1
		
		If ($test.keepError<0)
			
			throw:C1805($error)
			
		Else 
			
			$test.deferredError:=$error
			
		End if 
		
	Else 
		
		This:C1470.reporter.call(Null:C1517; Bool:C1537($assertion); String:C10($test.error))
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _stringify($value; $valueType; $quotted : Boolean) : Text
	
	var $type : Integer
	$type:=Value type:C1509($value)
	
	If (Count parameters:C259=2)\
		 && (Value type:C1509($valueType)=Is boolean:K8:9)
		
		$quotted:=$valueType
		$valueType:=Null:C1517
		
	End if 
	
	var $text : Text
	
	Case of 
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is time:K8:8)
			
			$text:=$value=Null:C1517 ? "Null" : String:C10(Time:C179($value))
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is null:K8:31)
			
			$text:=$value=Null:C1517 ? "Null" : "not Null"
			
			//______________________________________________________
		: ($valueType#Null:C1517)\
			 && ($valueType=Is pointer:K8:14)
			
			If ($type=Is null:K8:31)
				
				$text:="NIL pointer"
				
			Else 
				
				var $var : Text
				var $table; $field : Integer
				
				Try(RESOLVE POINTER:C394($value; $var; $table; $field))
				
				If ($table=0)\
					 & ($field=0)  // None (NIL pointer)
					
					$text:="NIL pointer"
					
				Else 
					
					If ($table=-1)\
						 & ($field=-1)  // Variable
						
						$text:="->"+(Length:C16($var)=0 ? "Unknown variable" : $var)
						
					Else 
						
						If ($field=-1)  // Element of an array
							
							$text:="->"+$var+"{"+String:C10($table)+"}"
							
						Else 
							
							If (Length:C16($var)=0)
								
								If ($table>0)\
									 && ($field=0)  // Table
									
									$text:="->["+Table name:C256($table)+"]"
									
								Else 
									
									$text:="->["+Table name:C256($table)+"]"+Field name:C257($table; $field)  // Field
									
								End if 
								
							Else 
								
								$text:="->"+$var+"{"+String:C10($table)+"}{"+String:C10($field)+"}"  // Element of 2D array
								
							End if 
						End if 
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($type=Is undefined:K8:13)
			
			$text:="undefined value"
			
			//______________________________________________________
		: ($type=Is null:K8:31)
			
			$text:=String:C10($value)
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			$text:=$value=Null:C1517 ? "Null" : $value
			
			//______________________________________________________
		: ($type=Is longint:K8:6)\
			 | ($type=Is real:K8:4)
			
			$text:=$value=Null:C1517 ? "Null" : String:C10($value)
			
			//______________________________________________________
		: ($type=Is boolean:K8:9)
			
			$text:=$value=Null:C1517 ? "Null" : $value ? "True" : "False"
			
			//______________________________________________________
		: ($type=Is object:K8:27)
			
			Case of 
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				: (OB Instance of:C1731($value; 4D:C1709.Function))
					
					$text:="Function "+This:C1470._quotted(String:C10($value.source))
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				: (OB Instance of:C1731($value; 4D:C1709.Folder))
					
					$text:="Folder "+This:C1470._quotted(String:C10($value.path))
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				: (OB Instance of:C1731($value; 4D:C1709.File))
					
					$text:="File "+This:C1470._quotted(String:C10($value.path))
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
				Else 
					
					$text:=$value=Null:C1517 ? "Null" : JSON Stringify:C1217($value)
					
					//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
			End case 
			
			//______________________________________________________
		: ($type=Is collection:K8:32)
			
			$text:=$value=Null:C1517 ? "Null" : JSON Stringify:C1217($value)
			
			//______________________________________________________
		: ($type=Is picture:K8:10)
			
			If ($value=Null:C1517)
				
				$text:="picture: empty"
				
			Else 
				
				var $height; $width : Integer
				PICTURE PROPERTIES:C457($value; $width; $height)
				$text:="picture: "+JSON Stringify:C1217({size: Picture size:C356($value); width: $width; height: $height})
				
			End if 
			
			//______________________________________________________
		: ($type=Is date:K8:7)
			
			$text:=$value=Null:C1517 ? "Null" : String:C10($value)
			
			//______________________________________________________
		: ($type=Is time:K8:8)
			
			$text:=$value=Null:C1517 ? "Null" : String:C10(Time:C179($value))
			
			//______________________________________________________
	End case 
	
	return $quotted ? This:C1470._quotted($text) : $text
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _header() : Text
	
	return "["+This:C1470.desc+"] "+This:C1470.latest.desc+": "
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _quotted($in : Text) : Text
	
	return "'"+$in+"'"