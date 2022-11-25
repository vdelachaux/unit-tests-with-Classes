//%attributes = {}
var $expected
var $ut : cs:C1710.ut

//MARK:-constructor
$ut:=cs:C1710.ut.new()

ASSERT:C1129($ut.success=False:C215)
ASSERT:C1129($ut.desc="No name")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)

//MARK:-suite()
$ut.suite("Test")
ASSERT:C1129($ut.success=False:C215)
ASSERT:C1129($ut.desc="Test")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)

//MARK:-equal()
$ut.suite("equal()")

$expected:=1+1
$ut.test("Integer formula").expect($expected).equal(Formula:C1597(1+1))
$ut.test("Integer value").expect($expected).equal(2)

$expected:=Pi:K30:1
$ut.test("Real formula").expect($expected).equal(Formula:C1597(Pi:K30:1))
$ut.test("Real value").expect($expected).equal(Pi:K30:1)

$expected:=Null:C1517
var $null
$null:=Null:C1517
$ut.test("Null formula").expect($expected).equal(Formula:C1597(Null:C1517))
$ut.test("Null value").expect($expected).equal($null)

$expected:="HELLO WORLD"
$ut.test("Text formula").expect($expected).equal(Formula:C1597("HELLO WORLD"))
$ut.test("Text value").expect($expected).equal("hello world")

$expected:=True:C214
$ut.test("Boolean formula").expect($expected).equal(Formula:C1597(Bool:C1537(1)))
$ut.test("Boolean value").expect($expected).equal(True:C214)

var $thumbnail : Picture
CREATE THUMBNAIL:C679($thumbnail; $thumbnail; 12; 12)
$expected:=$thumbnail
$ut.test("Picture formula").expect($expected).equal(Formula:C1597($thumbnail))
$ut.test("Picture value").expect($expected).equal($thumbnail)

$expected:=Current date:C33
$ut.test("Date formula").expect($expected).equal(Formula:C1597(Current date:C33))
$ut.test("Date value").expect($expected).equal(Current date:C33)

var $time : Time
$time:=Current time:C178
$expected:=$time
$ut.test("Time formula"; Is time:K8:8).expect($expected).equal(Formula:C1597($time))
$ut.test("Time value"; Is time:K8:8).expect($expected).equal($time)

$expected:=New object:C1471(\
"hello"; "hello"; \
"world"; "world")
var $o : Object
$o:=JSON Parse:C1218(JSON Stringify:C1217($expected; *))
$ut.test("Object formula").expect($expected).equal(Formula:C1597(JSON Parse:C1218(JSON Stringify:C1217($expected))))
$ut.test("Object value").expect($expected).equal($o)

$expected:=New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "bar"))
var $c : Collection
$c:=JSON Parse:C1218(JSON Stringify:C1217($expected; *))
$ut.test("Collection formula").expect($expected).equal(Formula:C1597(JSON Parse:C1218(JSON Stringify:C1217($expected))))
$ut.test("Collection value").expect($expected).equal($c)

var number : Integer
$expected:=->number
$ut.test("Pointer formula"; Is pointer:K8:14).expect($expected).equal(Formula:C1597(Get pointer:C304("number")))
$ut.test("Pointer value"; Is pointer:K8:14).expect($expected).equal(Get pointer:C304("number"))

ASSERT:C1129($ut.success)
ASSERT:C1129($ut.tests.length=22)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

//MARK:-strict()
$ut.suite("strict()")

$ut.test("Text").expect("Hello World").strict().equal("Hello World")

$expected:=New object:C1471("foo"; "foo")
$ut.test("Object").expect($expected).strict().equal(New object:C1471("foo"; "foo"))

$expected:=New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "bar"))
$ut.test("Collection").expect($expected)\
.strict().equal(New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "bar")))

$expected:=1+1
$ut.test("Integer").expect($expected).strict().equal(Formula:C1597(1+1))
$ut.test("Integer").expect($expected).strict().equal(2)

//MARK:-notEqual()
$ut.suite("notEqual()")

$ut.test("Numeric").expect(1+1).notEqual(0)
$ut.test("Real").expect(Pi:K30:1).notEqual(0)
$ut.test("Null").expect(Null:C1517).notEqual(New object:C1471)
$ut.test("Boolean").expect(True:C214).notEqual(False:C215)
var $emptyPicture : Picture
$ut.test("Picture").expect($thumbnail).notEqual($emptyPicture)
$ut.test("Date").expect(Current date:C33).notEqual(Current date:C33+1)
$ut.test("Object").expect(New object:C1471).notEqual(Null:C1517)
$ut.test("Collection").expect(New collection:C1472).notEqual(Null:C1517)
$ut.test("Pointer"; Is pointer:K8:14).expect(->number).notEqual(Get pointer:C304("foo"))

//mark:Time
$ut.test("Time"; Is time:K8:8).expect(Current time:C178).notEqual(Current time:C178+1)

$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "bar")).strict().notEqual(New object:C1471("foo"; "BAR"))

//MARK:-noAssert()
$ut.suite("noAssert")

$ut.test("Numeric").expect(2).noAssert().equal(1)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Numeric' gives '1' when '2' was expected")

$ut.test("Null").expect(Null:C1517).noAssert().equal(New object:C1471)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Null' gives '{}' when 'null' was expected")

$ut.test("Text").expect("hello world").noAssert().equal("hello")
ASSERT:C1129($ut.lastErrorText="noAssert: 'Text' gives 'hello' when 'hello world' was expected")

$ut.test("Boolean").expect(True:C214).noAssert().equal(False:C215)
ASSERT:C1129(Not:C34($ut.success))
ASSERT:C1129($ut.lastErrorText="noAssert: 'Boolean' gives 'False' when 'True' was expected")

var $emptyPicture : Picture
$ut.test("Picture").expect($thumbnail).noAssert().equal($emptyPicture)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Picture' gives 'picture: empty' when 'picture: {\"size\":166,\"width\":12,\"height\":12}' was expected")

//FIXME:Manage system's settings
$ut.test("Date").expect(!1958-08-08!).noAssert().equal(!00-00-00!)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Date' gives '00/00/00' when '08/08/1958' was expected")

$ut.test("Time"; Is time:K8:8).expect(?00:00:00?).noAssert().equal(?01:01:01?)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Time' gives '01:01:01' when '00:00:00' was expected")

$ut.test("Object").expect(New object:C1471).noAssert().equal(Null:C1517)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Object' gives 'null' when '{}' was expected")

$ut.test("Collection").expect(New collection:C1472).noAssert().equal(Null:C1517)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Collection' gives 'null' when '[]' was expected")

$ut.test("Pointer"; Is pointer:K8:14).expect(->number).noAssert().equal(Get pointer:C304("foo"))
ASSERT:C1129($ut.lastErrorText="noAssert: 'Pointer' gives '->foo' when '->number' was expected")

var $ptr : Pointer
$ut.test("Pointer"; Is pointer:K8:14).expect(->number).noAssert().equal($ptr)
ASSERT:C1129($ut.lastErrorText="noAssert: 'Pointer' gives 'NIL pointer' when '->number' was expected")

$ut.test("Not strictly equal text").expect("Hello World")\
.noAssert().strict().equal("hello world")
ASSERT:C1129($ut.lastErrorText="noAssert: 'Not strictly equal text' gives 'hello world' when 'Hello World' was expected")

$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "bar"))\
.noAssert().strict().equal(New object:C1471("foo"; "BAR"))
ASSERT:C1129($ut.lastErrorText="noAssert: 'Not strictly equal object' gives '{\"foo\":\"BAR\"}' when '{\"foo\":\"bar\"}' was expected")

$ut.test("Not strictly equal collection")\
.expect(New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "bar")))\
.noAssert().strict().equal(New collection:C1472(1; "foo"; New collection:C1472(1; "foo"; "BAR")))
ASSERT:C1129($ut.lastErrorText="noAssert: 'Not strictly equal collection' gives '[1,\"foo\",[1,\"foo\",\"BAR\"]]' when '[1,\"foo\",[1,\"foo\",\"bar\"]]' was expected")

//MARK:-OS
$ut.suite("OS")

$ut.test("Only on macOS").macOS().expect(True:C214).equal(Is macOS:C1572)
$ut.test("Only on Windows").Windows().expect(True:C214).equal(Is Windows:C1573)
$ut.test("Only on Linux").Linux().expect(True:C214).equal(Not:C34(Is Windows:C1573) & Not:C34(Is macOS:C1572))
$ut.test("macOS & Windows").macOS().Windows().expect(True:C214).equal(True:C214)

//MARK:-isTrue
$ut.suite("Shortcuts")

$ut.test("is True").isTrue(True:C214)
$ut.test("is not True").noAssert().isTrue(False:C215)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not True' gives 'False' when 'True' was expected")

$ut.test("is False").isFalse(False:C215)
$ut.test("is not False").noAssert().isFalse(True:C214)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not False' gives 'True' when 'False' was expected")

//MARK:-isNull
$ut.test("is Null").isNull(Null:C1517)
$ut.test("is not Null").noAssert().isNull(New object:C1471)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not Null' gives 'not null' when 'null' was expected")

$ut.test("is Not Null").isNotNull(New object:C1471)
$ut.test("is not non Null").noAssert().isNotNull(Null:C1517)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not non Null' gives 'null' when 'not null' was expected")

//MARK:-isEmpty
$ut.test("is empty string").isEmpty("")
$ut.test("is empty object").isEmpty(New object:C1471)
$ut.test("is empty collection").isEmpty(New collection:C1472)
$ut.test("is empty picture").isEmpty($emptyPicture)
var $blob : Blob
$ut.test("is empty blob").isEmpty($blob)

LONGINT TO BLOB:C550(8858; $blob)
$ut.test("is not empty blob").isNotEmpty($blob)

$ut.test("is empty real").noAssert().isEmpty(1)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is empty real: isEmpty() can't be applied to the type Real")
$ut.test("is empty Boolean").noAssert().isEmpty(False:C215)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is empty Boolean: isEmpty() can't be applied to the type Boolean")

SET BLOB SIZE:C606($blob; 0)
$ut.test("is not a non-empty blob").noAssert().isNotEmpty($blob)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'is not a non-empty blob: as returned an empty BLOB")

//MARK:-toLength
$ut.test("Text length").expect(11).toLength("HELLO WORLD")
$ut.test("Collection length").expect(5).toLength(New collection:C1472(1; 2; 3; 4; 5))

$ut.test("invalid target").expect(5).noAssert().toLength(New object:C1471)
ASSERT:C1129($ut.lastErrorText="Shortcuts: 'invalid target: toLength() can't be applied to the type Object")


//MARK:-
var $ƒ : 4D:C1709.Function
$ƒ:=Structure file:C489=Structure file:C489(*) ? Formula:C1597(BEEP:C151) : Formula:C1597(IDLE:C311)
$ƒ.call()