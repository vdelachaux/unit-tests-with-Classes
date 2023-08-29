//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

//MARK:-constructor
$ut:=cs:C1710.ut.new()

$ut.suite("messages")

$test:=$ut.test("Text").expect(getText).noReport().isEqualTo("Hello").latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Text: gives 'Hello World' when 'Hello' was expected")

$test:=$ut.test("Text (2)").expect(getText).noReport().isEqualTo(Null:C1517).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Text (2): TYPE MISMATCH - actual is 'Text' instead of 'Null'")

$test:=$ut.test("Strict Text").expect(getText).noReport().strict().isEqualTo(getText(1)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Strict Text: gives 'Hello World' when 'HELLO WORLD' was strictly expected")

$test:=$ut.test("Null").expect(Null:C1517).noReport().isEqualTo(getText).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isNull; "Wrong type")
ASSERT:C1129($test.error="[messages] Null: TYPE MISMATCH - actual is 'Null' instead of 'Text'")

$test:=$ut.test("Numeric").expect(2).noReport().isEqualTo(1).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isInteger; "Wrong type")
ASSERT:C1129($test.error="[messages] Numeric: gives '2' when '1' was expected")

$test:=$ut.test("Null").expect(Null:C1517).noReport().isEqualTo(New object:C1471).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isNull; "Wrong type")
ASSERT:C1129($test.error="[messages] Null 1: TYPE MISMATCH - actual is 'Null' instead of 'Object'")

$test:=$ut.test("Text").expect(getText).noReport().isEqualTo("hello").latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Text 1: gives 'Hello World' when 'hello' was expected")

$test:=$ut.test("Boolean").expect(True:C214).noReport().isEqualTo(False:C215).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] Boolean: gives 'True' when 'False' was expected")

$test:=$ut.test("Picture").expect(getPicture).noReport().isEqualTo(getPicture(1)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isPicture; "Wrong type")
ASSERT:C1129($test.error="[messages] Picture: gives 'picture: {\"size\":166,\"width\":12,\"height\":12}' when 'picture: empty' was expected")

$test:=$ut.test("Date").expect(!1958-08-08!).noReport().isEqualTo(!00-00-00!).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isDate; "Wrong type")
ASSERT:C1129($test.error=("[messages] Date: gives '"+String:C10(!1958-08-08!)+"' when '"+String:C10(!00-00-00!)+"' was expected"))

$test:=$ut.test("Time").expect(?00:00:00?).noReport().isEqualTo(?01:01:01?).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isTime; "Wrong type")
ASSERT:C1129($test.error=("[messages] Time: gives '"+String:C10(?00:00:00?)+"' when '"+String:C10(?01:01:01?)+"' was expected"))

$test:=$ut.test("Object").expect(New object:C1471).noReport().isEqualTo(Null:C1517).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object: TYPE MISMATCH - actual is 'Object' instead of 'Null'")

$test:=$ut.test("Object").expect(getObject).noReport().isEqualTo(getObject(3)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object 1: Property '.foo' type is \"Text\" when \"Object\" was expected")

$test:=$ut.test("Object (2)").expect(getObject).noReport().isEqualTo(New object:C1471).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object (2): Property number is 0 when 1 was expected")

$test:=$ut.test("Object (3)").expect(getObject).noReport().strict().isEqualTo(getObject(1)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object (3): Property '.foo' gives \"bar\" when \"BAR\" was strictly expected")

$test:=$ut.test("Collection").expect(New collection:C1472).noReport().isEqualTo(getCollection).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Collection: the number of properties is not the expected one, currently 0 whereas 2 was expected")

$test:=$ut.test("Collection (2)").expect(New collection:C1472).noReport().isEqualTo(Null:C1517).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Collection (2): TYPE MISMATCH - actual is 'Collection' instead of 'Null'")

$test:=$ut.test("Collection (3)").expect(getCollection).noReport().strict().isEqualTo(getCollection(1)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Collection (3): Property [1] is 'bar' when 'BAR' was strictly expected")

$test:=$ut.test("Collection (4)").expect(getCollection(2)).noReport().strict().isEqualTo(getCollection(3)).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Collection (4): '[1]' the number of properties is not the expected one, currently 3 whereas 2 was expected")

$test:=$ut.test("Pointer").expect(getPointer).noReport().isEqualTo(Get pointer:C304("foo")).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isPointer; "Wrong type")
ASSERT:C1129($test.error="[messages] Pointer: gives '->number' when '->foo' was expected")

$test:=$ut.test("Pointer (2)").expect(->number).noReport().isEqualTo(Get pointer:C304("")).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isPointer; "Wrong type")
ASSERT:C1129($test.error="[messages] Pointer (2): gives '->number' when 'NIL pointer' was expected")

$test:=$ut.test("Pointer (3)").expect(getPointer).noReport().isEqualTo(New object:C1471).latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isPointer; "Wrong type")
ASSERT:C1129($test.error="[messages] Pointer (3): TYPE MISMATCH - actual is 'Pointer' instead of 'Object'")

$test:=$ut.test("Only on macOS").macOS().expect(Is macOS:C1572).isTrue().latest
ASSERT:C1129($test.isBoolean; "Wrong type")

If (Asserted:C1132($test.successful; "Should succeed anyway"))
	
	If (Is macOS:C1572)
		
		ASSERT:C1129($test.onMac; "Should be True")
		ASSERT:C1129(Not:C34($test.onWindows); "Should be False")
		ASSERT:C1129(Not:C34($test.onLinux); "Should be False")
		
	Else 
		
		ASSERT:C1129($test.bypassed; "Should be True")
		ASSERT:C1129($test.error=("Skipped on "+(Is Windows:C1573 ? "Windows" : "Linux")); "Wrong message")
		
	End if 
End if 

$test:=$ut.test("Only on Windows").Windows().expect(Is Windows:C1573).isTrue().latest
ASSERT:C1129($test.isBoolean; "Wrong type")

If (Asserted:C1132($test.successful; "Should succeed anyway"))
	
	If (Is Windows:C1573)
		
		ASSERT:C1129(Not:C34($test.onMac); "Should be False")
		ASSERT:C1129($test.onWindows; "Should be True")
		ASSERT:C1129(Not:C34($test.onLinux); "Should be False")
		
	Else 
		
		ASSERT:C1129($test.bypassed; "Should be True")
		ASSERT:C1129($test.error=("Skipped on "+(Is macOS:C1572 ? "macOS" : "Linux")); "Wrong message")
		
	End if 
End if 

$test:=$ut.test("Only on Linux").Linux().expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue().latest
ASSERT:C1129($test.isBoolean; "Wrong type")

If (Asserted:C1132($test.successful; "Should succeed anyway"))
	
	If (Is macOS:C1572 | Is Windows:C1573)
		
		ASSERT:C1129($test.bypassed; "Should be True")
		ASSERT:C1129($test.error=("Skipped on "+(Is macOS:C1572 ? "macOS" : "Windows")); "Wrong message")
		
	Else 
		
		ASSERT:C1129(Not:C34($test.onMac); "Should be False")
		ASSERT:C1129(Not:C34($test.onWindows); "Should be False")
		ASSERT:C1129($test.onLinux; "Should be True")
		
	End if 
End if 

$test:=$ut.test("Not on Linux").macOS().Windows().expect(Is macOS:C1572 | Is Windows:C1573).isTrue().latest
ASSERT:C1129($test.isBoolean; "Wrong type")

If (Asserted:C1132($test.successful; "Should succeed anyway"))
	
	If (Is macOS:C1572 | Is Windows:C1573)
		
		ASSERT:C1129($test.onMac=(Is macOS:C1572 | Is Windows:C1573); "Should be True on macOS")
		ASSERT:C1129($test.onWindows=(Is macOS:C1572 | Is Windows:C1573); "Should be True on Windows")
		ASSERT:C1129(Not:C34($test.onLinux); "Should be False")
		
	Else 
		
		ASSERT:C1129($test.bypassed; "Should be True")
		ASSERT:C1129($test.error="Skipped on Linux"; "Wrong message")
		
	End if 
End if 

$test:=$ut.test("Not True").expect(False:C215).noReport().isTrue().latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] Not True: gives 'False' when 'True' was expected")

$test:=$ut.test("Object").expect(New object:C1471).noReport().isTrue().latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object 2: ut.isTrue() cannot be applied to the type Object")

$test:=$ut.test("Not False").expect(True:C214).noReport().isFalse().latest
ASSERT:C1129($test.failed; "Should failed")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] Not False: gives 'True' when 'False' was expected")

$test:=$ut.test("Object (2)").expect(New object:C1471).noReport().isFalse().latest
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Object (2) 1: ut.isFalse() cannot be applied to the type Object")

$test:=$ut.test("Not Null").expect("").noReport().isNull().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Not Null: returned a non-null value")

$test:=$ut.test("Not Null (2)").expect(getText).noReport().isNull().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Not Null (2): returned a non-null value")

$test:=$ut.test("Not Null (3)").expect(getObject).noReport().isNull().latest
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Not Null (3): returned a non-null value")

$test:=$ut.test("Null").expect(Null:C1517).noReport().isNotNull().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isNull; "Wrong type")
ASSERT:C1129($test.error="[messages] Null 2: returned a null value")

$test:=$ut.test("Not falsy Boolean").expect(True:C214).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Boolean: as returned a not falsy value: 'True'")

$test:=$ut.test("Not falsy Text").expect(getText).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Text: as returned a not falsy value: 'Hello World'")

$test:=$ut.test("Not falsy Date").expect(!1958-08-08!).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isDate; "Wrong type")
ASSERT:C1129($test.error=("[messages] Not falsy Date: as returned a not falsy value: '"+String:C10(!1958-08-08!)+"'"))

$test:=$ut.test("Not falsy Time").expect(getTime).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isTime; "Wrong type")
ASSERT:C1129($test.error=("[messages] Not falsy Time: as returned a not falsy value: '"+String:C10(myTime)+"'"))

$test:=$ut.test("Not falsy Picture").expect(getPicture).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isPicture; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Picture: as returned a not falsy value: 'picture: {\"size\":166,\"width\":12,\"height\":12}'")

$test:=$ut.test("Not falsy Blob").expect(getBlob(1)).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBlob; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Blob: as returned a not falsy value: '{\"size\":4}'")

$test:=$ut.test("Not falsy Null").expect(getBlob(1)).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBlob; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Null: as returned a not falsy value: '{\"size\":4}'")

$test:=$ut.test("Not falsy Object").expect(getObject).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Object: as returned a not falsy value: '{\"foo\":\"bar\"}'")

$test:=$ut.test("Not falsy Collection").expect(getCollection).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Collection: as returned a not falsy value: '[\"foo\",\"bar\"]'")

$test:=$ut.test("Not falsy Number").expect(Pi:K30:1).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isReal; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Number: as returned a not falsy value: '3,14159265359'")

$test:=$ut.test("Not falsy Pointer").expect(getPointer).noReport().isFalsy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isPointer; "Wrong type")
ASSERT:C1129($test.error="[messages] Not falsy Pointer: as returned a not falsy value: '->number'")

$test:=$ut.test("Not truthy Boolean").expect(False:C215).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Boolean: as returned a not truthy value: 'False'")

$test:=$ut.test("Not truthy Text").expect("").noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isText; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Text: as returned a not truthy value: ''")

$test:=$ut.test("Not truthy Date").expect(!00-00-00!).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isDate; "Wrong type")
ASSERT:C1129($test.error=("[messages] Not truthy Date: as returned a not truthy value: '"+String:C10(!00-00-00!)+"'"))

$test:=$ut.test("Not truthy Time").expect(?00:00:00?).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isTime; "Wrong type")
ASSERT:C1129($test.error=("[messages] Not truthy Time: as returned a not truthy value: '"+String:C10(?00:00:00?)+"'"))

$test:=$ut.test("Not truthy Picture").expect(getPicture(1)).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isPicture; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Picture: as returned a not truthy value: 'picture: empty'")

$test:=$ut.test("Not truthy Blob").expect(getBlob).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBlob; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Blob: as returned a not truthy value: '{\"size\":0}'")

$test:=$ut.test("Not truthy Null").expect(Null:C1517).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isNull; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Null: as returned a not truthy value: 'Null'")

$test:=$ut.test("Not truthy Object").expect(getObject(2)).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Object: as returned a not truthy value: '{}'")

$test:=$ut.test("Not truthy Collection").expect(New collection:C1472).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isCollection; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Collection: as returned a not truthy value: '[]'")

$test:=$ut.test("Not truthy Number").expect(0).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isInteger; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Number: as returned a not truthy value: '0'")

$test:=$ut.test("Not truthy Pointer").expect(Get pointer:C304("")).noReport().isTruthy().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isPointer; "Wrong type")
ASSERT:C1129($test.error="[messages] Not truthy Pointer: as returned a not truthy value: 'NIL pointer'")

$test:=$ut.test("is empty Numeric").expect(1).noReport().isEmpty().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isNumeric; "Wrong type")
ASSERT:C1129($test.isInteger; "Wrong type")
ASSERT:C1129($test.error="[messages] is empty Numeric: ut.isEmpty() or ut.isNotEmpty() can't be applied to the type Real")

$test:=$ut.test("is empty Boolean").expect(False:C215).noReport().isEmpty().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBoolean; "Wrong type")
ASSERT:C1129($test.error="[messages] is empty Boolean: ut.isEmpty() or ut.isNotEmpty() can't be applied to the type Boolean")

$test:=$ut.test("is not a non-empty blob").expect(getBlob).noReport().isNotEmpty().latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isBlob; "Wrong type")
ASSERT:C1129($test.error="[messages] is not a non-empty blob: as returned an empty BLOB")

$test:=$ut.test("invalid target for toLength").expect(5).noReport().toLength(New object:C1471).latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isNumeric; "Wrong type")
ASSERT:C1129($test.error="[messages] invalid target for toLength: ut.toLength() can't be applied to the type Object")

$test:=$ut.test("Wrong text length").noReport().toLength("HELLO WORLD"; 12).latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isNumeric; "Wrong type")
ASSERT:C1129($test.error="[messages] Wrong text length: Text length is 11 when 12 was expected")

$test:=$ut.test("File").noReport().isTrue(File:C1566("toto")).latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] File: File '/toto/' doesn't exists")

$test:=$ut.test("Folder").noReport().isTrue(Folder:C1567("toto")).latest
ASSERT:C1129($test.failed; "Should fail")
ASSERT:C1129($test.isObject; "Wrong type")
ASSERT:C1129($test.error="[messages] Folder: Folder '/toto/' doesn't exists")

end