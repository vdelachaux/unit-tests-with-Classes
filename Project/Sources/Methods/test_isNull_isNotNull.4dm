//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

$ut.suite("isNull")

$ut.test("Null").expect(Null:C1517).isNull()

$test:=$ut.test("Text").expect("").noReport().isNull().lastTest
ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.error="isNull: 'Text' as returned an non null value")

$test:=$ut.test("Object").expect(fooBarObject).noReport().isNull().lastTest
ASSERT:C1129($test.error="isNull: 'Object' as returned an non null value")

$ut.suite("isNotNull")

$ut.test("Object").expect(New object:C1471).isNotNull()

var $null
$test:=$ut.test("Text").expect($null).noReport().isNotNull().lastTest
ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.error="isNotNull: 'Text' as returned an non null value")

end