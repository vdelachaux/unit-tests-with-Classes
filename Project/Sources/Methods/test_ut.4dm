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
var $empty : Picture
$ut.test("Picture").expect($thumbnail).notEqual($empty)
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

var $empty : Picture
$ut.test("Picture").expect($thumbnail).noAssert().equal($empty)
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

//MARK:OS
$ut.suite("OS")

$ut.test("Only on macOS").macOS().expect(True:C214).equal(Is macOS:C1572)
$ut.test("Only on Windows").Windows().expect(True:C214).equal(Is Windows:C1573)
$ut.test("Only on Linux").Linux().expect(True:C214).equal(Not:C34(Is Windows:C1573) & Not:C34(Is macOS:C1572))
$ut.test("macOS & Windows").macOS().Windows().expect(True:C214).equal(True:C214)

var $ƒ : 4D:C1709.Function
$ƒ:=Structure file:C489=Structure file:C489(*) ? Formula:C1597(BEEP:C151) : Formula:C1597(IDLE:C311)
$ƒ.call()