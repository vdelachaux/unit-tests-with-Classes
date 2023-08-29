//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

var $picture; $emptyPicture : Picture
CREATE THUMBNAIL:C679($picture; $picture; 12; 12)

var $date; $emptyDate
$date:=!1958-08-08!

var $emptyTime : Time
vTime:=Current time:C178

var $object; $emptyObject : Object
$object:=New object:C1471("foo"; "bar")

var $collection; $emptyCollection : Collection
$collection:=New collection:C1472(1; 2; "foo")

var $pointer : Pointer
$pointer:=->vTime

var $blob; $emptyBlob : Blob
PICTURE TO BLOB:C692($picture; $blob; ".png")


//MARK:-constructor
$ut:=cs:C1710.ut.new()

ASSERT:C1129($ut.successful=False:C215)
ASSERT:C1129($ut.desc="")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests=Null:C1517)
ASSERT:C1129($ut.failedTests=Null:C1517)

//MARK:-suite()
$ut.suite("Test")
ASSERT:C1129($ut.successful=False:C215)
ASSERT:C1129($ut.desc="Test")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)
ASSERT:C1129($ut.failedTests.length=0)

//MARK:-isEqualTo()
$ut.suite("isEqualTo")
$ut.test("Integer").expect(2).isEqualTo(2)
$ut.test("Integer").expect(Formula:C1597(1+1)).isEqualTo(2)
$ut.test("Real").expect(25.5).isEqualTo(25.5)
$ut.test("Real").expect(Formula:C1597(Pi:K30:1)).isEqualTo(Pi:K30:1)
$ut.test("Null").expect(Null:C1517).isEqualTo(Null:C1517)
$ut.test("Null").expect(Formula:C1597(Null:C1517)).isEqualTo(Null:C1517)
$ut.test("Text").expect("hello world").isEqualTo("hello world")
$ut.test("Text").expect(Formula:C1597("hello world")).isEqualTo("hello world")
$ut.test("Boolean").expect(True:C214).isEqualTo(True:C214)
$ut.test("Boolean").expect(Formula:C1597(Bool:C1537(1))).isEqualTo(True:C214)
$ut.test("Picture").expect($picture).isEqualTo($picture)
$ut.test("Picture").expect(Formula:C1597($picture)).isEqualTo($picture)
$ut.test("Date").expect($date).isEqualTo($date)
$ut.test("Date").expect(Formula:C1597($date)).isEqualTo($date)
$ut.test("Time").expect(vTime).isEqualTo(vTime)
$ut.test("Time").expect(Formula:C1597(vTime)).isEqualTo(vTime)
$ut.test("Object").expect($object).isEqualTo($object)
$ut.test("Object").expect(Formula:C1597($object)).isEqualTo($object)
$ut.test("Collection").expect($collection).isEqualTo($collection)
$ut.test("Collection").expect(Formula:C1597($collection)).isEqualTo($collection)
$ut.test("Pointer").expect($pointer).isEqualTo(Get pointer:C304("vTime"))
$ut.test("Pointer").expect(Formula:C1597($pointer)).isEqualTo($pointer)

ASSERT:C1129($ut.successful)
ASSERT:C1129($ut.testNumber=22)
ASSERT:C1129($ut.errorNumber=0)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

// MARK:-isNotEqualTo()
$ut.suite("isNotEqualTo")
$ut.test("Integer").expect(0).isNotEqualTo(2)
$ut.test("Integer").expect(Formula:C1597(1+1)).isNotEqualTo(0)
$ut.test("Real").expect(Pi:K30:1).isNotEqualTo(0)
$ut.test("Real").expect(Formula:C1597(Pi:K30:1)).isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).isNotEqualTo(New object:C1471)
$ut.test("Null").expect(Formula:C1597(Null:C1517)).isNotEqualTo(New object:C1471)
$ut.test("Text").expect("hello world").isNotEqualTo("foo")
$ut.test("Text").expect(Formula:C1597("hello world")).isNotEqualTo("foo")
$ut.test("Boolean").expect(True:C214).isNotEqualTo(Null:C1517)
$ut.test("Boolean").expect(Formula:C1597(Bool:C1537(1))).isNotEqualTo(False:C215)
$ut.test("Picture").expect($picture).isNotEqualTo($emptyPicture)
$ut.test("Picture").expect(Formula:C1597($emptyPicture)).isNotEqualTo($picture)
$ut.test("Date").expect($emptyDate).isNotEqualTo(!1958-08-08!)
$ut.test("Date").expect(Formula:C1597($emptyDate)).isNotEqualTo(!1958-08-08!)
$ut.test("Time").expect(vTime).isNotEqualTo(?00:00:00?)
$ut.test("Time").expect(Formula:C1597(vTime)).isNotEqualTo(?00:00:00?)
$ut.test("Object").expect($object).isNotEqualTo(New object:C1471)
$ut.test("Object").expect(Formula:C1597($object)).isNotEqualTo(Null:C1517)
$ut.test("Collection").expect($collection).isNotEqualTo(New collection:C1472)
$ut.test("Collection").expect(Formula:C1597($collection)).isNotEqualTo(New object:C1471)
$ut.test("Pointer").expect($pointer).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Pointer").expect(Formula:C1597($pointer)).isNotEqualTo(Get pointer:C304("foo"))

ASSERT:C1129($ut.successful)
ASSERT:C1129($ut.testNumber=22)
ASSERT:C1129($ut.errorNumber=0)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

// MARK:-strict.isEqualTo()
$ut.suite("strict.isEqualTo")
$ut.test("Text").expect("hello world").strict().isEqualTo("hello world")
$ut.test("Object").expect($object).strict().isEqualTo($object)
$ut.test("Collection").expect($collection).strict().isEqualTo($collection)

// Must not modify the test if the type is not relevant
$ut.test("Numeric").expect(0).strict().isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(New object:C1471("foo"; "BAR"))
$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(Null:C1517)
$ut.test("Picture").expect($picture).strict().isNotEqualTo($emptyPicture)
$ut.test("Date").expect($date).strict().isNotEqualTo($date+1)
$ut.test("Pointer").strict().expect($pointer).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Time").strict().expect(vTime).isNotEqualTo(vTime+1)

// MARK:-strict.isNotEqualTo()
$ut.suite("strict.isNotEqualTo")
$ut.test("Text").expect("hello world").strict().isNotEqualTo("Hello World")
$ut.test("Object").expect($object).strict().isNotEqualTo(New object:C1471("foo"; "BAR"))
$ut.test("Collection").expect($collection).strict().isNotEqualTo(New collection:C1472(1; 2; "FOO"))

// Must not modify the test if the type is not relevant
$ut.test("Integer").expect(0).strict().isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(New object:C1471)
$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(False:C215)
$ut.test("Date").expect($date).strict().isNotEqualTo($date+1)
$ut.test("Time").strict().expect(vTime).isNotEqualTo(vTime+1)
$ut.test("Pointer").strict().expect($pointer).isNotEqualTo(Get pointer:C304("foo"))

//MARK:-OS
$ut.suite("OS")
$ut.test("Only on macOS").macOS().expect(Is macOS:C1572).isTrue()
$ut.test("Only on Windows").Windows().expect(Is Windows:C1573).isTrue()
$ut.test("Only on Linux").Linux().expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue()
$ut.test("Not on Linux").macOS().Windows().expect(Is macOS:C1572 | Is Windows:C1573).isTrue()

//MARK:-noReport()
$ut.suite("noReport")
ASSERT:C1129($ut.test("Text").expect("hello world").noReport().isEqualTo("hello").latest.failed; "Should failed")
ASSERT:C1129($ut.test("Null").expect("hello world").noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Numeric").expect(2).noReport().isEqualTo(1).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Null").expect(Null:C1517).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Boolean").expect(True:C214).noReport().isEqualTo(False:C215).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Picture").expect($picture).noReport().isEqualTo($picture*0).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Date").expect(!1958-08-08!).noReport().isEqualTo(!00-00-00!).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Time").expect(?00:00:00?).noReport().isEqualTo(?01:01:01?).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object").expect(New object:C1471).noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object").expect($object).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object").expect(New object:C1471).noReport().strict().isEqualTo(New object:C1471("foo"; "BAR")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection").expect(New collection:C1472).noReport().isEqualTo($collection).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection").expect(New collection:C1472).noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection").expect($collection).noReport().strict().isEqualTo(New collection:C1472(1; 2; "FOO")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer").expect($pointer).noReport().isEqualTo(Get pointer:C304("foo")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer").expect($pointer).noReport().isEqualTo(Get pointer:C304("")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer").expect($pointer).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")

ASSERT:C1129($ut.failed)
ASSERT:C1129($ut.testNumber=17)
ASSERT:C1129($ut.errorNumber=17)
ASSERT:C1129($ut.lastError#Null:C1517)
ASSERT:C1129($ut.lastErrorText#"")

//MARK:-isTrue()
$ut.suite("isTrue")
$ut.test("True").expect(True:C214).isTrue()
$ut.test("True").isTrue(1=1)

$ut.test("File").isTrue(File:C1566(Structure file:C489; fk platform path:K87:2))


//MARK:-isFalse()
$ut.suite("isFalse")
$ut.test("False").expect(False:C215).isFalse()
$ut.test("False").isFalse(1=2)

//MARK:-isNull()
$ut.suite("isNull")
$ut.test("Null").expect(Null:C1517).isNull()
$ut.test("Null").isNull(Null:C1517)

//MARK:-isNotNull()
$ut.suite("isNotNull")
$ut.test("Not Null").expect(New object:C1471).isNotNull()
$ut.test("Not Null").isNotNull(New object:C1471)

//MARK:-isFalsy()
$ut.suite("isFalsy")
$ut.test("Boolean").expect(False:C215).isFalsy()
$ut.test("Text").expect("").isFalsy()
$ut.test("Date").expect(Date:C102("00-00-00")).isFalsy()
$ut.test("Time").expect(Time:C179(0)).isFalsy()
$ut.test("Picture").expect($emptyPicture).isFalsy()
$ut.test("Blob").expect($emptyBlob).isFalsy()
$ut.test("Null").expect(Null:C1517).isFalsy()
$ut.test("Object").expect(New object:C1471).isFalsy()
$ut.test("Collection").expect(New collection:C1472).isFalsy()
$ut.test("Number").expect(0).isFalsy()  // 0 is falsy !
$ut.test("Pointer").expect(Get pointer:C304("")).isFalsy()

$ut.test("Boolean").isFalsy(False:C215)
$ut.test("Text").isFalsy("")
$ut.test("Date").isFalsy(Date:C102("00-00-00"))
$ut.test("Time").isFalsy(Time:C179(0))
$ut.test("Picture").isFalsy($emptyPicture)
$ut.test("Blob").isFalsy($emptyBlob)
$ut.test("Null").isFalsy(Null:C1517)
$ut.test("Object").isFalsy(New object:C1471)
$ut.test("Collection").isFalsy(New collection:C1472)
$ut.test("Number").isFalsy(0)  // 0 is falsy !
$ut.test("Pointer").isFalsy(Get pointer:C304(""))

//MARK:-isTruthy()
$ut.suite("isTruthy")
$ut.test("Boolean").expect(True:C214).isTruthy()
$ut.test("Text").expect("foo").isTruthy()
$ut.test("Date").expect($date).isTruthy()
$ut.test("Time").expect(vTime).isTruthy()
$ut.test("Picture").expect($picture).isTruthy()
$ut.test("Blob").expect($blob).isTruthy()
$ut.test("Object").expect($object).isTruthy()
$ut.test("Collection").expect($collection).isTruthy()
$ut.test("Number").expect(Pi:K30:1).isTruthy()
$ut.test("Pointeur").expect($pointer).isTruthy()

$ut.test("Boolean").isTruthy(Formula:C1597(True:C214))
$ut.test("Text").isTruthy(Formula:C1597("hello world"))
$ut.test("Date").isTruthy(Formula:C1597($date))
$ut.test("Time").isTruthy(Formula:C1597(vTime))
$ut.test("Picture").isTruthy(Formula:C1597($picture))
$ut.test("Blob").isTruthy(Formula:C1597($blob))
$ut.test("Object").isTruthy(Formula:C1597($object))
$ut.test("Collection").isTruthy(Formula:C1597($collection))
$ut.test("Number").isTruthy(Formula:C1597(Pi:K30:1))
$ut.test("Pointeur").isTruthy(Formula:C1597($pointer))

//MARK:-isEmpty()
$ut.suite("isEmpty")
$ut.test("Text").expect("").isEmpty()
$ut.test("Object").expect(New object:C1471).isEmpty()
$ut.test("Collection").expect(New collection:C1472).isEmpty()
$ut.test("Picture").expect($emptyPicture).isEmpty()
$ut.test("Blob").expect($emptyBlob).isEmpty()

$ut.test("Text").isEmpty("")
$ut.test("Object").isEmpty(New object:C1471)
$ut.test("Collection").isEmpty(New collection:C1472)
$ut.test("Picture").isEmpty($emptyPicture)
$ut.test("Blob").isEmpty($emptyBlob)


//MARK:-isNotEmpty()
$ut.suite("isNotEmpty")
$ut.test("Text").expect("hello world").isNotEmpty()
$ut.test("Object").expect($object).isNotEmpty()
$ut.test("Collection").expect($collection).isNotEmpty()
$ut.test("Picture").expect($picture).isNotEmpty()
$ut.test("Blob").expect($blob).isNotEmpty()

$ut.test("Text").isNotEmpty("hello world")
$ut.test("Object").isNotEmpty($object)
$ut.test("Collection").isNotEmpty($collection)
$ut.test("Picture").isNotEmpty($picture)
$ut.test("Blob").isNotEmpty($blob)

//MARK:-toLength()
$ut.suite("toLength")
$ut.test("Text").expect(11).toLength("hello world")
$ut.test("Text").toLength("hello world"; 11)

$ut.test("Collection").expect(5).toLength(New collection:C1472(1; 2; 3; 4; 5))
$ut.test("Collection").toLength(New collection:C1472(1; 2; 3; 4; 5); 5)

//MARK:-BUGS
var $real : Real
$ut.suite("BUGS")
$real:=33
$ut.test("real").expect($real).isEqualTo(33)

$ut.test("mistmatch").noReport().expect($real).isEqualTo("33")
ASSERT:C1129(Not:C34($ut.successful))
ASSERT:C1129($ut.failed)
ASSERT:C1129($ut.lastErrorText="[BUGS] mistmatch: TYPE MISMATCH - actual is 'Real' instead of 'Text'")

BEEP:C151