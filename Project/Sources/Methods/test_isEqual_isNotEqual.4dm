//%attributes = {}
var $emptyPicture; $thumbnail : Picture
var $time : Time
var $c : Collection
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

// MARK:-isEqual
$ut.suite("Equal")

$ut.test("Integer").expect(2).isEqual(2)
$ut.test("Integer formula").expect(Formula:C1597(1+1)).isEqual(2)

$ut.test("Real").expect(25.5).isEqual(25.5)
$ut.test("Real formula").expect(Formula:C1597(Pi:K30:1)).isEqual(Pi:K30:1)

$ut.test("Null value").expect(Null:C1517).isEqual(Null:C1517)
$ut.test("Null formula").expect(Formula:C1597(Null:C1517)).isEqual(Null:C1517)

$ut.test("Text value").expect("Hello World").isEqual("hello world")
$ut.test("Text formula").expect(Formula:C1597(helloWorld)).isEqual("Hello World")

$ut.test("Boolean value").expect(True:C214).isEqual(True:C214)
$ut.test("Boolean formula").expect(Formula:C1597(Bool:C1537(1))).isEqual(True:C214)

CREATE THUMBNAIL:C679($thumbnail; $thumbnail; 12; 12)
$ut.test("Picture value").expect($thumbnail).isEqual($thumbnail)
$ut.test("Picture formula").expect($thumbnail).isEqual(Formula:C1597($thumbnail))

$ut.test("Date value").expect(Current date:C33).isEqual(Current date:C33)
$ut.test("Date formula").expect(Formula:C1597(Current date:C33)).isEqual(Current date:C33)

$time:=Current time:C178
$ut.test("Time value"; Is time:K8:8).expect($time).isEqual($time)
$ut.test("Time formula"; Is time:K8:8).expect(Formula:C1597($time)).isEqual($time)

$c:=fooBarCollection
$ut.test("Collection value").expect(fooBarCollection).isEqual(JSON Parse:C1218(JSON Stringify:C1217($c; *)))
$ut.test("Collection formula").expect(Formula:C1597(fooBarCollection)).isEqual($c)

$ut.test("Pointer value"; Is pointer:K8:14).expect(->number).isEqual(Get pointer:C304("number"))
$ut.test("Pointer formula"; Is pointer:K8:14).expect(Formula:C1597(Get pointer:C304("number"))).isEqual(->number)

// MARK:-isNotEqual
$ut.suite("isNotEqual")

$ut.test("Numeric").expect(0).isNotEqual(2)
$ut.test("Real").expect(Pi:K30:1).isNotEqual(0)
$ut.test("Null").expect(Null:C1517).isNotEqual(New object:C1471)
$ut.test("Boolean").expect(True:C214).isNotEqual(Null:C1517)
$ut.test("Picture").expect($thumbnail).isNotEqual($emptyPicture)
$ut.test("Date").expect(Current date:C33).isNotEqual(Current date:C33+1)
$ut.test("Object").expect(fooBarObject).isNotEqual(New object:C1471)
$ut.test("Collection").expect(New collection:C1472(1; 2; 3)).isNotEqual(New collection:C1472(2; 1; 3))
$ut.test("Pointer"; Is pointer:K8:14).expect(->number).isNotEqual(Get pointer:C304("foo"))
$ut.test("Time"; Is time:K8:8).expect(Current time:C178).isNotEqual(Current time:C178+1)

// MARK:-strict
$ut.suite("strict.isEqual")

// With relevant type
$ut.test("Text").expect(helloWorld).strict.isEqual("Hello World")
$ut.test("Object").expect(fooBarObject).strict.isEqual(fooBarObject)
$ut.test("Collection").expect(fooBarCollection).strict.isEqual(fooBarCollection)

//$ut.test("Object").expect(fooBarObject).strict.isEqual(fooBarObject(1))
//$ut.test("Text").expect(helloWorld).strict.isEqual(helloWorld(1))

$ut.test("Not strictly equal Text").expect(helloWorld).strict.isNotEqual(helloWorld(1))
$ut.test("Not strictly equal Object").expect(fooBarObject).strict.isNotEqual(fooBarObject(1))
$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "BAR")).strict.isNotEqual(New object:C1471("foo"; "bar"))

// Must not modify the test if the type is not relevant
$ut.test("Integer").expect(1+1).strict.isEqual(2)
$ut.test("Real").expect(Pi:K30:1).strict.isEqual(Pi:K30:1)
$ut.test("Null").expect(Null:C1517).strict.isEqual(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict.isEqual($thumbnail)

$ut.test("Numeric").expect(0).strict.isNotEqual(2)
$ut.test("Real").expect(Pi:K30:1).strict.isNotEqual(0)
$ut.test("Null").expect(Null:C1517).strict.isNotEqual(New object:C1471)
$ut.test("Boolean").expect(True:C214).strict.isNotEqual(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict.isNotEqual($emptyPicture)
$ut.test("Date").expect(Current date:C33).strict.isNotEqual(Current date:C33+1)
$ut.test("Pointer"; Is pointer:K8:14).strict.expect(->number).isNotEqual(Get pointer:C304("foo"))
$ut.test("Time"; Is time:K8:8).strict.expect(Current time:C178).isNotEqual(Current time:C178+1)

end