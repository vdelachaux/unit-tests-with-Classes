//%attributes = {}
var $thumbnail; $emptyPicture : Picture
var $currentTime : Time
var $test : cs:C1710.test
var $ut : cs:C1710.ut

var number : Integer

CREATE THUMBNAIL:C679($thumbnail; $thumbnail; 12; 12)
$currentTime:=Current time:C178

$ut:=cs:C1710.ut.new()

$ut.suite("strict")

//MARK:-
$ut.suite("isEqualTo")

// With relevant type
$test:=$ut.test("Text").expect(helloWorld).strict().isEqualTo("Hello World").lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is text:K8:3; "Should be Is text")

$test:=$ut.test("Object").expect(fooBarObject).strict().isEqualTo(fooBarObject).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is object:K8:27; "Should be Is object")

$test:=$ut.test("Collection").expect(fooBarCollection).strict().isEqualTo(fooBarCollection).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is collection:K8:32; "Should be Is collection")

// Must not modify the test if the type is not relevant
$test:=$ut.test("Integer").expect(1+1).strict().isEqualTo(2).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129(($test.type=Is integer:K8:5) | ($test.type=Is real:K8:4); "Should be Is integer or Is real")

$test:=$ut.test("Real").expect(Pi:K30:1).strict().isEqualTo(Pi:K30:1).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129(($test.type=Is integer:K8:5) | ($test.type=Is real:K8:4); "Should be Is integer or Is real")

$test:=$ut.test("Null").expect(Null:C1517).strict().isEqualTo(Null:C1517).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is null:K8:31; "Should be Is null")

$test:=$ut.test("Boolean").expect(True:C214).strict().isTrue().lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is boolean:K8:9; "Should be Is boolean")

$test:=$ut.test("Picture").expect($thumbnail).strict().isEqualTo($thumbnail).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is picture:K8:10; "Should be Is picture")

$test:=$ut.test("Date").expect(Current date:C33).strict().isEqualTo(Current date:C33).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is date:K8:7; "Should be Is date")

$test:=$ut.test("Time"; Is time:K8:8).strict().expect($currentTime).isEqualTo($currentTime).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is time:K8:8; "Should be Is time")

$test:=$ut.test("Pointer"; Is pointer:K8:14).strict().expect(->number).isEqualTo(Get pointer:C304("number")).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is pointer:K8:14; "Should be Is pointer")

//MARK:-
$ut.suite("isNotEqualTo")

$test:=$ut.test("Text").expect(helloWorld).strict().isNotEqualTo(helloWorld(1)).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is text:K8:3; "Should be Is text")

$test:=$ut.test("Object").expect(fooBarObject).strict().isNotEqualTo(fooBarObject(1)).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is object:K8:27; "Should be Is object")

$test:=$ut.test("Collection").expect(fooBarCollection).strict().isNotEqualTo(fooBarCollection(1)).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is collection:K8:32; "Should be Is collection")

$test:=$ut.test("Integer").expect(0).strict().isNotEqualTo(2).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129(($test.type=Is integer:K8:5) | ($test.type=Is real:K8:4); "Should be Is integer or Is real")

$test:=$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129(($test.type=Is integer:K8:5) | ($test.type=Is real:K8:4); "Should be Is integer or Is real")

$test:=$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(New object:C1471).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is null:K8:31; "Should be Is null")

$test:=$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(False:C215).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is boolean:K8:9; "Should be Is boolean")

$test:=$ut.test("Picture").expect($thumbnail).strict().isNotEqualTo($emptyPicture).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is picture:K8:10; "Should be Is picture")

$test:=$ut.test("Date").expect(Current date:C33).strict().isNotEqualTo(Current date:C33+1).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is date:K8:7; "Should be Is date")

$test:=$ut.test("Time"; Is time:K8:8).strict().expect($currentTime).isNotEqualTo($currentTime+1).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is time:K8:8; "Should be Is time")

$test:=$ut.test("Pointer"; Is pointer:K8:14).strict().expect(->number).isNotEqualTo(Get pointer:C304("foo")).lastTest
ASSERT:C1129($test.strict=True:C214; "Should be True")
ASSERT:C1129($test.type=Is pointer:K8:14; "Should be Is pointer")

//$test:=$ut.test("Object").expect(fooBarObject).strict().isEqualTo(fooBarObject(1)).lastTest
//$test:=$ut.test("Text").expect(helloWorld).strict().isEqualTo(helloWorld(1)).lastTest

end