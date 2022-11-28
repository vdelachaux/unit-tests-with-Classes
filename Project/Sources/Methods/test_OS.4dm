//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

$ut.suite("OS")

$test:=$ut.test("Only on macOS").macOS().expect(Is macOS:C1572).isTrue().lastTest

ASSERT:C1129($test.success; "Should succeed anyway")

If (Not:C34(Is macOS:C1572))
	
	ASSERT:C1129($test.bypassed=("Skipped on "+(Is Windows:C1573 ? "Windows" : "Linux")); "Wrong message")
	
End if 

$test:=$ut.test("Only on Windows").Windows().expect(Is Windows:C1573).isTrue().lastTest

ASSERT:C1129($test.success; "Should succeed anyway")

If (Not:C34(Is Windows:C1573))
	
	ASSERT:C1129($test.bypassed=("Skipped on "+(Is macOS:C1572 ? "macOS" : "Linux")); "Wrong message")
	
End if 

$test:=$ut.test("Only on Linux").Linux().expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue().lastTest

ASSERT:C1129($test.success; "Should succeed anyway")

If (Not:C34(Is Windows:C1573) & Not:C34(Is Windows:C1573))
	
	ASSERT:C1129($test.bypassed=("Skipped on "+(Is macOS:C1572 ? "macOS" : "Windows")); "Wrong message")
	
End if 

$test:=$ut.test("Not on Linux").macOS().Windows().expect(Is macOS:C1572 | Is Windows:C1573).isTrue().lastTest

ASSERT:C1129($test.success; "Should succeed anyway")

If (Not:C34(Is macOS:C1572) & Not:C34(Is Windows:C1573))
	
	ASSERT:C1129($test.bypassed="Skipped on Linux"; "Wrong message")
	
End if 

end