//%attributes = {}
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()
$ut.suite("True-False")

$ut.test("is True").expect(True:C214).isTrue()
$ut.test("is False").expect(False:C215).isFalse()

end