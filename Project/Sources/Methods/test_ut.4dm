//%attributes = {}
var $emptyPicture; $thumbnail : Picture
var $time : Time
var $c : Collection
var $ut : cs:C1710.ut

//MARK:-constructor
$ut:=cs:C1710.ut.new()

ASSERT:C1129($ut.success=False:C215)
ASSERT:C1129($ut.desc="No name")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)
ASSERT:C1129($ut.failedTests.length=0)

//MARK:-suite()
$ut.suite("Test")
ASSERT:C1129($ut.success=False:C215)
ASSERT:C1129($ut.desc="Test")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)
ASSERT:C1129($ut.failedTests.length=0)

//MARK:-equal()
$ut.suite("Equal")

$ut.test("Integer").expect(2).isEqualTo(2)
$ut.test("Integer formula").expect(Formula:C1597(1+1)).isEqualTo(2)

$ut.test("Real").expect(25.5).isEqualTo(25.5)
$ut.test("Real formula").expect(Formula:C1597(Pi:K30:1)).isEqualTo(Pi:K30:1)

$ut.test("Null value").expect(Null:C1517).isEqualTo(Null:C1517)
$ut.test("Null formula").expect(Formula:C1597(Null:C1517)).isEqualTo(Null:C1517)

$ut.test("Text value").expect("Hello World").isEqualTo("hello world")
$ut.test("Text formula").expect(Formula:C1597(helloWorld)).isEqualTo("Hello World")

$ut.test("Boolean value").expect(True:C214).isEqualTo(True:C214)
$ut.test("Boolean formula").expect(Formula:C1597(Bool:C1537(1))).isEqualTo(True:C214)

CREATE THUMBNAIL:C679($thumbnail; $thumbnail; 12; 12)
$ut.test("Picture value").expect($thumbnail).isEqualTo($thumbnail)
$ut.test("Picture formula").expect($thumbnail).isEqualTo(Formula:C1597($thumbnail))

$ut.test("Date value").expect(Current date:C33).isEqualTo(Current date:C33)
$ut.test("Date formula").expect(Formula:C1597(Current date:C33)).isEqualTo(Current date:C33)

$time:=Current time:C178
$ut.test("Time value"; Is time:K8:8).expect($time).isEqualTo($time)
$ut.test("Time formula"; Is time:K8:8).expect(Formula:C1597($time)).isEqualTo($time)

$c:=fooBarCollection
$ut.test("Collection value").expect(fooBarCollection).isEqualTo(JSON Parse:C1218(JSON Stringify:C1217($c; *)))
$ut.test("Collection formula").expect(Formula:C1597(fooBarCollection)).isEqualTo($c)

$ut.test("Pointer value"; Is pointer:K8:14).expect(->number).isEqualTo(Get pointer:C304("number"))
$ut.test("Pointer formula"; Is pointer:K8:14).expect(Formula:C1597(Get pointer:C304("number"))).isEqualTo(->number)

ASSERT:C1129($ut.success)
ASSERT:C1129($ut.testNumber=20)
ASSERT:C1129($ut.errorNumber=0)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

// MARK:-isNotEqualTo
$ut.suite("notEqual")

$ut.test("Numeric").expect(0).isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).isNotEqualTo(New object:C1471)
$ut.test("Boolean").expect(True:C214).isNotEqualTo(Null:C1517)
$ut.test("Picture").expect($thumbnail).isNotEqualTo($emptyPicture)
$ut.test("Date").expect(Current date:C33).isNotEqualTo(Current date:C33+1)
$ut.test("Object").expect(fooBarObject).isNotEqualTo(New object:C1471)
$ut.test("Collection").expect(New collection:C1472(1; 2; 3)).isNotEqualTo(New collection:C1472(2; 1; 3))
$ut.test("Pointer"; Is pointer:K8:14).expect(->number).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Time"; Is time:K8:8).expect(Current time:C178).isNotEqualTo(Current time:C178+1)

// MARK:-strict
$ut.suite("strict.isEqualTo")

// With relevant type
$ut.test("Text").expect(helloWorld).strict().isEqualTo("Hello World")
$ut.test("Object").expect(fooBarObject).strict().isEqualTo(fooBarObject)
$ut.test("Collection").expect(fooBarCollection).strict().isEqualTo(fooBarCollection)

//$ut.test("Object").expect(fooBarObject).strict().isEqualTo(fooBarObject(1))
//$ut.test("Text").expect(helloWorld).strict().isEqualTo(helloWorld(1))

$ut.test("Not strictly equal Text").expect(helloWorld).strict().isNotEqualTo(helloWorld(1))
$ut.test("Not strictly equal Object").expect(fooBarObject).strict().isNotEqualTo(fooBarObject(1))
$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "BAR")).strict().isNotEqualTo(New object:C1471("foo"; "bar"))

// Must not modify the test if the type is not relevant
$ut.test("Integer").expect(1+1).strict().isEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isEqualTo(Pi:K30:1)
$ut.test("Null").expect(Null:C1517).strict().isEqualTo(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict().isEqualTo($thumbnail)

$ut.test("Numeric").expect(0).strict().isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(New object:C1471)
$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict().isNotEqualTo($emptyPicture)
$ut.test("Date").expect(Current date:C33).strict().isNotEqualTo(Current date:C33+1)
$ut.test("Pointer"; Is pointer:K8:14).strict().expect(->number).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Time"; Is time:K8:8).strict().expect(Current time:C178).isNotEqualTo(Current time:C178+1)

//MARK:-noReport()
$ut.suite("noReport")

$ut.test("Numeric").expect(2).noReport().isEqualTo(1)
ASSERT:C1129($ut.lastErrorText="noReport: 'Numeric' gives '2' when '1' was expected")

$ut.test("Null"; Is null:K8:31).expect(Null:C1517).noReport().isEqualTo(New object:C1471)
ASSERT:C1129($ut.lastErrorText="noReport: 'Null' gives 'null' when 'not null' was expected")

$ut.test("Text").expect(helloWorld).noReport().isEqualTo("hello")
ASSERT:C1129($ut.lastErrorText="noReport: 'Text' gives 'hello world' when 'hello' was expected")

$ut.test("Boolean").expect(True:C214).noReport().isEqualTo(False:C215)
ASSERT:C1129(Not:C34($ut.success))
ASSERT:C1129($ut.lastErrorText="noReport: 'Boolean' gives 'True' when 'False' was expected")

var $emptyPicture : Picture
$ut.test("Picture").expect($thumbnail).noReport().isEqualTo($emptyPicture)
ASSERT:C1129($ut.lastErrorText="noReport: 'Picture' gives 'picture: {\"size\":166,\"width\":12,\"height\":12}' when 'picture: empty' was expected")

//FIXME:Manage system's settings
$ut.test("Date").expect(!1958-08-08!).noReport().isEqualTo(!00-00-00!)
ASSERT:C1129($ut.lastErrorText="noReport: 'Date' gives '08/08/1958' when '00/00/00' was expected")

$ut.test("Time"; Is time:K8:8).expect(?00:00:00?).noReport().isEqualTo(?01:01:01?)
ASSERT:C1129($ut.lastErrorText="noReport: 'Time' gives '00:00:00' when '01:01:01' was expected")

$ut.test("Object").expect(New object:C1471).noReport().isEqualTo(Null:C1517)
ASSERT:C1129($ut.lastErrorText="noReport: 'Object' gives '{}' when 'null' was expected")

$ut.test("Collection").expect(New collection:C1472).noReport().isEqualTo(Null:C1517)
ASSERT:C1129($ut.lastErrorText="noReport: 'Collection' gives '[]' when 'null' was expected")

$ut.test("Pointer"; Is pointer:K8:14).expect(->number).noReport().isEqualTo(Get pointer:C304("foo"))
ASSERT:C1129($ut.lastErrorText="noReport: 'Pointer' gives '->number' when '->foo' was expected")

var $ptr : Pointer
$ut.test("Pointer"; Is pointer:K8:14).expect(->number).noReport().isEqualTo($ptr)
ASSERT:C1129($ut.lastErrorText="noReport: 'Pointer' gives '->number' when 'NIL pointer' was expected")

$ut.test("Not strictly equal text").expect("Hello World")\
.noReport().strict().isEqualTo("hello world")
ASSERT:C1129($ut.lastErrorText="noReport: 'Not strictly equal text' gives 'hello world' when 'Hello World' was expected")

$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "bar"))\
.noReport().strict().isEqualTo(New object:C1471("foo"; "BAR"))
ASSERT:C1129($ut.lastErrorText="noReport: 'Not strictly equal object' gives '{\"foo\":\"BAR\"}' when '{\"foo\":\"bar\"}' was expected")

$ut.test("Not strictly equal collection")\
.expect(New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "bar")))\
.noReport().strict().isEqualTo(New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "BAR")))
ASSERT:C1129($ut.lastErrorText="noReport: 'Not strictly equal collection' gives '[1,\"foo\",[1,\"foo\",\"BAR\"]]' when '[1,\"foo\",[1,\"foo\",\"bar\"]]' was expected")

//MARK:-OS
$ut.suite("OS")

$ut.test("Only on macOS").macOS().expect(Is macOS:C1572).isTrue()
$ut.test("Only on Windows").Windows().expect(Is Windows:C1573).isTrue()
$ut.test("Only on Linux").Linux().expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue()
$ut.test("Not on Linux").macOS().Windows().expect(Is macOS:C1572 | Is Windows:C1573).isTrue()

//MARK:-isTrue/isFalse
$ut.suite("True-False")

$ut.test("is True").expect(True:C214).isTrue()
$ut.test("is not True").expect(False:C215).noReport().isTrue()
ASSERT:C1129($ut.lastErrorText="True-False: 'is not True' gives 'False' when 'True' was expected")

$ut.test("is False").expect(False:C215).isFalse()
$ut.test("is not False").expect(True:C214).noReport().isFalse()
ASSERT:C1129($ut.lastErrorText="True-False: 'is not False' gives 'True' when 'False' was expected")

//MARK:-isNull/isNotNull
$ut.suite("NULL")
$ut.test("is Null").expect(Null:C1517).isNull()
$ut.test("is not Null").expect(New object:C1471).noReport().isNull()
ASSERT:C1129($ut.lastErrorText="NULL: 'is not Null' gives 'not null' when 'null' was expected")

$ut.test("is Not Null").expect(New object:C1471).noReport().isNotNull()
var $null
$ut.test("is not non Null").expect($null).noReport().isNotNull()
ASSERT:C1129($ut.lastErrorText="NULL: 'is not non Null' gives 'null' when 'not null' was expected")

//MARK:-isFalsy
$ut.test("falsy boolean").expect(False:C215).isFalsy()
$ut.test("falsy text").isFalsy("")
$ut.test("falsy date").isFalsy(Date:C102("00-00-00"))
$ut.test("falsy time").isFalsy(Time:C179(0))
$ut.test("falsy picture").isFalsy($emptyPicture)
$ut.test("falsy blob").isFalsy($blob)
$ut.test("falsy null").isFalsy(Null:C1517)
$ut.test("falsy object").isFalsy(New object:C1471)
$ut.test("falsy collection").isFalsy(New collection:C1472)
$ut.test("falsy number").isFalsy(0)  // 0 is falsy !
$ut.test("falsy pointer").isFalsy($ptr)

//MARK:-isTruthy
$ut.test("truthy boolean").isTruthy(True:C214)
$ut.test("truthy text").isTruthy("foo")
$ut.test("truthy date").isTruthy(Current date:C33)
$ut.test("truthy time").isTruthy(Current time:C178)
$ut.test("truthy picture").isTruthy($thumbnail)
LONGINT TO BLOB:C550(8858; $blob)
$ut.test("truthy blob").isTruthy($blob)
$ut.test("truthy object").isTruthy(New object:C1471("foo"; "bar"))
$ut.test("truthy collection").isTruthy(New collection:C1472("foo"; "bar"))
$ut.test("truthy number").isTruthy(Pi:K30:1)
$ut.test("truthy pointeur").isTruthy(->number)

//MARK:-isEmpty
$ut.suite("Empty")
$ut.test("is empty string").expect("").isEmpty()


$ut.test("is empty object").isEmpty(New object:C1471)
$ut.test("is empty collection").isEmpty(New collection:C1472)
$ut.test("is empty picture").isEmpty($emptyPicture)
var $blob : Blob
$ut.test("is empty blob").isEmpty($blob)

LONGINT TO BLOB:C550(8858; $blob)
$ut.test("is not empty blob").isNotEmpty($blob)

$ut.test("is empty real").noReport().isEmpty(1)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is empty real: isEmpty/NotEmpty can't be applied to the type Real")
$ut.test("is empty Boolean").noReport().isEmpty(False:C215)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is empty Boolean: isEmpty/NotEmpty can't be applied to the type Boolean")

SET BLOB SIZE:C606($blob; 0)
$ut.test("is not a non-empty blob").noReport().isNotEmpty($blob)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not a non-empty blob: as returned an empty BLOB")

//MARK:-toLength
$ut.test("Text length").expect(11).toLength("HELLO WORLD")
$ut.test("Text length").toLength("HELLO WORLD"; 11)

$ut.test("Collection length").expect(5).toLength(New collection:C1472(1; 2; 3; 4; 5))
$ut.test("Collection length").toLength(New collection:C1472(1; 2; 3; 4; 5); 5)

$ut.test("invalid target").expect(5).noReport().toLength(New object:C1471)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'invalid target': toLength() can't be applied to the type Object")

$ut.test("Text length").noReport().toLength("HELLO WORLD"; 12)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'Text length' gives '11' when '12' was expected")

//MARK:-
var $ƒ : 4D:C1709.Function
$ƒ:=Structure file:C489=Structure file:C489(*) ? Formula:C1597(BEEP:C151) : Formula:C1597(IDLE:C311)
$ƒ.call()