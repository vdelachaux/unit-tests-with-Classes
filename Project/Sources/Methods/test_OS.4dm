//%attributes = {}
var $ut : cs:C1710.ut

$ut:=cs:C1710.ut.new()
$ut.suite("OS")

$ut.test("Only on macOS").macOS.expect(Is macOS:C1572).isTrue()
$ut.test("Only on Windows").Windows.expect(Is Windows:C1573).isTrue()
$ut.test("Only on Linux").Linux.expect(Not:C34(Is macOS:C1572 | Is Windows:C1573)).isTrue()
$ut.test("Not on Linux").macOS.Windows.expect(Is macOS:C1572 | Is Windows:C1573).isTrue()

end