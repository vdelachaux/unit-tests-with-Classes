//%attributes = {}
var $emptyPicture; $thumbnail : Picture
var $blob : Blob
var $test : cs:C1710.test
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

//Mark:-
$ut.suite("isEmpty")

$ut.test("Text").expect("").isEmpty()
$ut.test("Object").expect(New object:C1471).isEmpty()
$ut.test("Collection").expect(New collection:C1472).isEmpty()
$ut.test("Blob").expect($blob).isEmpty()
$ut.test("Picture").expect($emptyPicture).isEmpty()

$test:=$ut.test("Real").expect(0).noReport().isEmpty().lastTest
ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.error="isEmpty: 'Real: isEmpty/isNotEmpty can't be applied to the type Real")

$test:=$ut.test("Null").expect(Null:C1517).noReport().isEmpty().lastTest
ASSERT:C1129(Not:C34($test.success); "Should fail")
ASSERT:C1129($test.error="isEmpty: 'Null: isEmpty/isNotEmpty can't be applied to the type Null")

//Mark:-
$ut.suite("isNotEmpty")

$ut.test("Text").expect("Hello world").isNotEmpty()
LONGINT TO BLOB:C550(8858; $blob)
$ut.test("Blob").expect($blob).isNotEmpty()
$ut.test("Object").expect(fooBarObject).isNotEmpty()
$ut.test("Collection").expect(fooBarCollection).isNotEmpty()
CREATE THUMBNAIL:C679($thumbnail; $thumbnail; 12; 12)
$ut.test("Picture").expect($thumbnail).isNotEmpty()

$test:=$ut.test("Boolean").expect(False:C215).noReport().isNotEmpty().lastTest
ASSERT:C1129($test.error="isNotEmpty: 'Boolean: isEmpty/isNotEmpty can't be applied to the type Boolean")

SET BLOB SIZE:C606($blob; 0)
$test:=$ut.test("Blob").expect($blob).noReport().isNotEmpty().lastTest
ASSERT:C1129($test.error="isNotEmpty: 'Blob' as returned an empty BLOB")

end