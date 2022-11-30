//%attributes = {}
var $emptyPicture; $thumbnail : Picture
var $time : Time
var $c : Collection
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()

// MARK:-isEqualTo
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

// MARK:-isNotEqualTo
$ut.suite("isNotEqualTo")

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
$ut.test("Text").expect(helloWorld).strict.isEqualTo("Hello World")
$ut.test("Object").expect(fooBarObject).strict.isEqualTo(fooBarObject)
$ut.test("Collection").expect(fooBarCollection).strict.isEqualTo(fooBarCollection)

//$ut.test("Object").expect(fooBarObject).strict.isEqualTo(fooBarObject(1))
//$ut.test("Text").expect(helloWorld).strict.isEqualTo(helloWorld(1))

$ut.test("Not strictly equal Text").expect(helloWorld).strict.isNotEqualTo(helloWorld(1))
$ut.test("Not strictly equal Object").expect(fooBarObject).strict.isNotEqualTo(fooBarObject(1))
$ut.test("Not strictly equal object").expect(New object:C1471("foo"; "BAR")).strict.isNotEqualTo(New object:C1471("foo"; "bar"))

// Must not modify the test if the type is not relevant
$ut.test("Integer").expect(1+1).strict.isEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict.isEqualTo(Pi:K30:1)
$ut.test("Null").expect(Null:C1517).strict.isEqualTo(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict.isEqualTo($thumbnail)

$ut.test("Numeric").expect(0).strict.isNotEqualTo(2)
$ut.test("Real").expect(Pi:K30:1).strict.isNotEqualTo(0)
$ut.test("Null").expect(Null:C1517).strict.isNotEqualTo(New object:C1471)
$ut.test("Boolean").expect(True:C214).strict.isNotEqualTo(Null:C1517)
$ut.test("Picture").expect($thumbnail).strict.isNotEqualTo($emptyPicture)
$ut.test("Date").expect(Current date:C33).strict.isNotEqualTo(Current date:C33+1)
$ut.test("Pointer"; Is pointer:K8:14).strict.expect(->number).isNotEqualTo(Get pointer:C304("foo"))
$ut.test("Time"; Is time:K8:8).strict.expect(Current time:C178).isNotEqualTo(Current time:C178+1)

end