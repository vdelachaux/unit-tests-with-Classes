//%attributes = {}
var $test : cs:C1710.test
var $ut : cs:C1710.ut

//MARK:-constructor
$ut:=cs:C1710.ut.new()

ASSERT:C1129($ut.successful=False:C215)
ASSERT:C1129($ut.desc="No name")
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")
ASSERT:C1129($ut.tests.length=0)
ASSERT:C1129($ut.failedTests.length=0)

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
$ut.test("Integer formula").expect(Formula:C1597(1+1)).isEqualTo(2)
$ut.test("Real").expect(25.5).isEqualTo(25.5)
$ut.test("Real formula").expect(Formula:C1597(Pi:K30:1)).isEqualTo(Pi:K30:1)
$ut.test("Null").expect(Null:C1517).isEqualTo(Null:C1517)
$ut.test("Null formula").expect(Formula:C1597(Null:C1517)).isEqualTo(Null:C1517)
$ut.test("Text").expect(getText).isEqualTo(myText)
$ut.test("Text formula").expect(Formula:C1597(getText)).isEqualTo(myText)
$ut.test("Boolean").expect(True:C214).isEqualTo(True:C214)
$ut.test("Boolean formula").expect(Formula:C1597(Bool:C1537(1))).isEqualTo(True:C214)
$ut.test("Picture").expect(getPicture).isEqualTo(myPicture)
$ut.test("Picture formula").expect(Formula:C1597(getPicture)).isEqualTo(myPicture)
$ut.test("Date").expect(getDate).isEqualTo(myDate)
$ut.test("Date formula").expect(Formula:C1597(getDate)).isEqualTo(myDate)
$ut.test("Time").expect(getTime).isEqualTo(myTime)
$ut.test("Time formula").expect(Formula:C1597(getTime)).isEqualTo(myTime)
$ut.test("Object").expect(getObject).isEqualTo(myObject)
$ut.test("Object formula").expect(Formula:C1597(getObject)).isEqualTo(myObject)
$ut.test("Collection").expect(getCollection).isEqualTo(myCollection)
$ut.test("Collection formula").expect(Formula:C1597(getCollection)).isEqualTo(myCollection)
$ut.test("Pointer").expect(getPointer).isEqualTo(Get pointer:C304("number"))
$ut.test("Pointer formula").expect(Formula:C1597(getPointer)).isEqualTo(myPointer)

ASSERT:C1129($ut.successful)
ASSERT:C1129($ut.testNumber=22)
ASSERT:C1129($ut.errorNumber=0)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

// MARK:-isNotEqualTo()
$ut.suite("isNotEqualTo")
$ut.test("Integer").expect(0).isNotEqualTo(2)
$ut.test("Integer formula").expect(Formula:C1597(1+1)).isNotEqualTo(0)
$ut.test("Real").expect(Pi:K30:1).isNotEqualTo(0)
$ut.test("Real formula").expect(Formula:C1597(Pi:K30:1)).isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).isNotEqualTo(New object:C1471)
$ut.test("Null formula").expect(Formula:C1597(Null:C1517)).isNotEqualTo(New object:C1471)
$ut.test("Text").expect(getText).isNotEqualTo("foo")
$ut.test("Text formula").expect(Formula:C1597(getText)).isNotEqualTo("foo")
$ut.test("Boolean").expect(True:C214).isNotEqualTo(Null:C1517)
$ut.test("Boolean formula").expect(Formula:C1597(Bool:C1537(1))).isNotEqualTo(False:C215)
$ut.test("Picture").expect(myPicture).isNotEqualTo(getPicture(1))
$ut.test("Picture formula").expect(Formula:C1597(getPicture(1))).isNotEqualTo(getPicture)
$ut.test("Date").expect(getDate).isNotEqualTo(!1958-08-08!)
$ut.test("Date formula").expect(Formula:C1597(getDate)).isNotEqualTo(!1958-08-08!)
$ut.test("Time").expect(getTime).isNotEqualTo(?00:00:00?)
$ut.test("Time formula").expect(Formula:C1597(getTime)).isNotEqualTo(?00:00:00?)
$ut.test("Object").expect(getObject).isNotEqualTo(New object:C1471)
$ut.test("Object formula").expect(Formula:C1597(getObject)).isNotEqualTo(Null:C1517)
$ut.test("Collection").expect(getCollection).isNotEqualTo(New collection:C1472)
$ut.test("Collection formula").expect(Formula:C1597(getCollection)).isNotEqualTo(New object:C1471)
$ut.test("Pointer").expect(getPointer).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Pointer formula").expect(Formula:C1597(getPointer)).isNotEqualTo(Get pointer:C304("foo"))

ASSERT:C1129($ut.successful)
ASSERT:C1129($ut.testNumber=22)
ASSERT:C1129($ut.errorNumber=0)
ASSERT:C1129($ut.lastError=Null:C1517)
ASSERT:C1129($ut.lastErrorText="")

// MARK:-strict.isEqualTo()
$ut.suite("strict.isEqualTo")
$ut.test("Text").expect(getText).strict().isEqualTo(myText)
$ut.test("Object").expect(getObject).strict().isEqualTo(myObject)
$ut.test("Collection").expect(getCollection).strict().isEqualTo(myCollection)

// Must not modify the test if the type is not relevant
$ut.test("Numeric").expect(0).strict().isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(myObject)
$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(Null:C1517)
$ut.test("Picture").expect(getPicture).strict().isNotEqualTo(getPicture(1))
$ut.test("Date").expect(getDate).strict().isNotEqualTo(myDate+1)
$ut.test("Pointer").strict().expect(myPointer).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Time").strict().expect(myTime).isNotEqualTo(myTime+1)

// MARK:-strict.isNotEqualTo()
$ut.suite("strict.isNotEqualTo")
$ut.test("Text").expect(getText).strict().isNotEqualTo(getText(1))
$ut.test("Object").expect(getObject).strict().isNotEqualTo(getObject(1))
$ut.test("Collection").expect(getCollection).strict().isNotEqualTo(getCollection(1))

// Must not modify the test if the type is not relevant
$ut.test("Integer").expect(0).strict().isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict().isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict().isNotEqualTo(New object:C1471)
$ut.test("Boolean").expect(True:C214).strict().isNotEqualTo(False:C215)
$ut.test("Date").expect(myDate).strict().isNotEqualTo(myDate+1)
$ut.test("Time").strict().expect(myTime).isNotEqualTo(myTime+1)
$ut.test("Pointer").strict().expect(myPointer).isNotEqualTo(Get pointer:C304("foo"))

//MARK:-OS
$ut.suite("OS")
$ut.test("Only on macOS").macOS().expect(Is macOS:C1572).isTrue()
$ut.test("Only on Windows").Windows().expect(Is Windows:C1573).isTrue()
$ut.test("Only on Linux").Linux().expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue()
$ut.test("Not on Linux").macOS().Windows().expect(Is macOS:C1572 | Is Windows:C1573).isTrue()

//MARK:-noReport()
$ut.suite("noReport")
ASSERT:C1129($ut.test("Text").expect(getText).noReport().isEqualTo("hello").latest.failed; "Should failed")
ASSERT:C1129($ut.test("Null with type").expect(getText).noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Numeric").expect(2).noReport().isEqualTo(1).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Null").expect(Null:C1517).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Boolean").expect(True:C214).noReport().isEqualTo(False:C215).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Picture").expect(getPicture).noReport().isEqualTo(myPicture*0).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Date").expect(!1958-08-08!).noReport().isEqualTo(!00-00-00!).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Time").expect(?00:00:00?).noReport().isEqualTo(?01:01:01?).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object").expect(New object:C1471).noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object").expect(myObject).noReport().isEqualTo(getObject(3)).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object (2)").expect(myObject).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Object (3)").expect(getObject).noReport().strict().isEqualTo(getObject(1)).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection").expect(New collection:C1472).noReport().isEqualTo(myCollection).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection (2)").expect(New collection:C1472).noReport().isEqualTo(Null:C1517).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Collection (3)").expect(myCollection).noReport().strict().isEqualTo(getCollection(2)).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer").expect(myPointer).noReport().isEqualTo(Get pointer:C304("foo")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer (2)").expect(->number).noReport().isEqualTo(Get pointer:C304("")).latest.failed; "Should failed")
ASSERT:C1129($ut.test("Pointer (3)").expect(myPointer).noReport().isEqualTo(New object:C1471).latest.failed; "Should failed")

ASSERT:C1129($ut.failed)
ASSERT:C1129($ut.testNumber=18)
ASSERT:C1129($ut.errorNumber=18)
ASSERT:C1129($ut.lastError#Null:C1517)
ASSERT:C1129($ut.lastErrorText#"")

//MARK:-isTrue()
$ut.suite("isTrue")
$ut.test("True").expect(True:C214).isTrue()
$ut.test("True Shortcut").isTrue(1=1)

//MARK:-isFalse()
$ut.suite("isFalse")
$ut.test("False").expect(False:C215).isFalse()
$ut.test("False Shortcut").isFalse(1=2)

//MARK:-isNull()
$ut.suite("isNull")
$ut.test("Null").expect(Null:C1517).isNull()
$ut.test("Null shortcut").isNull(Null:C1517)

//MARK:-isNotNull()
$ut.suite("isNotNull")
$ut.test("Not Null").expect(New object:C1471).isNotNull()

$ut.test("Not Null shortcut").isNotNull(New object:C1471)

//MARK:-isFalsy()
$ut.suite("isFalsy")
$ut.test("Boolean").expect(False:C215).isFalsy()
$ut.test("Text").expect("").isFalsy()
$ut.test("Date").expect(Date:C102("00-00-00")).isFalsy()
$ut.test("Time").expect(Time:C179(0)).isFalsy()
$ut.test("Picture").expect(getPicture(1)).isFalsy()
$ut.test("Blob").expect(getBlob).isFalsy()
$ut.test("Null").expect(Null:C1517).isFalsy()
$ut.test("Object").expect(New object:C1471).isFalsy()
$ut.test("Collection").expect(New collection:C1472).isFalsy()
$ut.test("Number").expect(0).isFalsy()  // 0 is falsy !
$ut.test("Pointer").expect(Get pointer:C304("")).isFalsy()

$ut.suite("isFalsy Shortcut")
$ut.test("Boolean").isFalsy(False:C215)
$ut.test("Text").isFalsy("")
$ut.test("Date").isFalsy(Date:C102("00-00-00"))
$ut.test("Time").isFalsy(Time:C179(0))
$ut.test("Picture").isFalsy(getPicture(1))
$ut.test("Blob").isFalsy(getBlob)
$ut.test("Null").isFalsy(Null:C1517)
$ut.test("Object").isFalsy(New object:C1471)
$ut.test("Collection").isFalsy(New collection:C1472)
$ut.test("Number").isFalsy(0)  // 0 is falsy !
$ut.test("Pointer").isFalsy(Get pointer:C304(""))

//MARK:-isTruthy()
$ut.suite("isTruthy")
$ut.test("Boolean").expect(True:C214).isTruthy()
$ut.test("Text").expect("foo").isTruthy()
$ut.test("Date").expect(getDate).isTruthy()
$ut.test("Time").expect(getTime).isTruthy()
$ut.test("Picture").expect(getPicture).isTruthy()
$ut.test("Blob").expect(getBlob(1)).isTruthy()
$ut.test("Object").expect(getObject).isTruthy()
$ut.test("Collection").expect(getCollection).isTruthy()
$ut.test("Number").expect(Pi:K30:1).isTruthy()
$ut.test("Pointeur").expect(getPointer).isTruthy()

$ut.suite("isTruthy Shortcut")
$ut.test("Boolean").isTruthy(Formula:C1597(True:C214))
$ut.test("Text").isTruthy(Formula:C1597(getText))
$ut.test("Date").isTruthy(Formula:C1597(getDate))
$ut.test("Time").isTruthy(Formula:C1597(getTime))
$ut.test("Picture").isTruthy(Formula:C1597(getPicture))
$ut.test("Blob").isTruthy(Formula:C1597(getBlob(1)))
$ut.test("Object").isTruthy(Formula:C1597(getObject))
$ut.test("Collection").isTruthy(Formula:C1597(getCollection))
$ut.test("Number").isTruthy(Formula:C1597(Pi:K30:1))
$ut.test("Pointeur").isTruthy(Formula:C1597(getPointer))

//MARK:-isEmpty()
$ut.suite("isEmpty")
$ut.test("Text").expect("").isEmpty()
$ut.test("Object").expect(New object:C1471).isEmpty()
$ut.test("Collection").expect(New collection:C1472).isEmpty()
$ut.test("Picture").expect(getPicture(1)).isEmpty()
$ut.test("Blob").expect(getBlob).isEmpty(getBlob)

$ut.suite("isEmpty Shortcut")
$ut.test("Text").isEmpty("")
$ut.test("Object").isEmpty(New object:C1471)
$ut.test("Collection").isEmpty(New collection:C1472)
$ut.test("Picture").isEmpty(getPicture(1))
$ut.test("Blob").isEmpty(getBlob)


//MARK:-isNotEmpty()
$ut.suite("isNotEmpty")
$ut.test("Text").expect(getText).isNotEmpty()
$ut.test("Object").expect(getObject).isNotEmpty()
$ut.test("Collection").expect(getCollection).isNotEmpty()
$ut.test("Picture").expect(getPicture).isNotEmpty()
$ut.test("Blob").expect(getBlob(1)).isNotEmpty()

$ut.suite("isNotEmpty Shortcut")
$ut.test("Text").isNotEmpty(getText)
$ut.test("Object").isNotEmpty(getObject)
$ut.test("Collection").isNotEmpty(getCollection)
$ut.test("Picture").isNotEmpty(getPicture)
$ut.test("Blob").isNotEmpty(getBlob(1))

//MARK:-toLength()
$ut.suite("toLength")
$ut.test("Text").expect(11).toLength(myText)
$ut.test("Text shortcut").toLength(myText; 11)

$ut.test("Collection").expect(5).toLength(New collection:C1472(1; 2; 3; 4; 5))
$ut.test("Collection shortcut").toLength(New collection:C1472(1; 2; 3; 4; 5); 5)

end