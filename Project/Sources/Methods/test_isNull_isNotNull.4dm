//%attributes = {}
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()
$ut.suite("Null")

$ut.test("is Null").expect(Null:C1517).isNull()
$ut.test("is not Null").expect(New object:C1471).isNotNull()

end