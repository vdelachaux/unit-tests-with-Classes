//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

$ut.suite("isTrue-isFalse")

$test:=$ut.test("is True").expect(True:C214).isTrue().lastTest

ASSERT:C1129($test.success; "Should succeed")
ASSERT:C1129($test.type=Is boolean:K8:9; "Wrong type")

$test:=$ut.test("is False").expect(False:C215).isFalse().lastTest

ASSERT:C1129($test.success; "Should succeed")
ASSERT:C1129($test.type=Is boolean:K8:9; "Wrong type")

//Mark:-
$test:=$ut.test("is not True").expect(False:C215).noReport().isTrue().lastTest

ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.type=Is boolean:K8:9; "Wrong type")
ASSERT:C1129($test.error="isTrue-isFalse: 'is not True' gives 'False' when 'True' was expected")

$test:=$ut.test("is not False").expect(True:C214).noReport().isFalse().lastTest

ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.type=Is boolean:K8:9; "Wrong type")
ASSERT:C1129($test.error="isTrue-isFalse: 'is not False' gives 'True' when 'False' was expected")

$test:=$ut.test("Object").expect(New object:C1471).noReport().isTrue().lastTest
ASSERT:C1129($test.type=Is object:K8:27; "Wrong type")
ASSERT:C1129($test.error="isTrue-isFalse: 'Object': isTrue() cannot be applied to the type Object")

$test:=$ut.test("Object").expect(New object:C1471).noReport().isFalse().lastTest
ASSERT:C1129($test.type=Is object:K8:27; "Wrong type")
ASSERT:C1129($test.error="isTrue-isFalse: 'Object': isFalse() cannot be applied to the type Object")

end