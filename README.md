[![language](https://img.shields.io/static/v1?label=language&message=4d&color=blue)](https://developer.4d.com/)
[![language](https://img.shields.io/github/languages/top/vdelachaux/unit-tests-with-Classes.svg)](https://developer.4d.com/)
![code-size](https://img.shields.io/github/languages/code-size/vdelachaux/unit-tests-with-Classes.svg)
[![license](https://img.shields.io/github/license/vdelachaux/unit-tests-with-Classes)](LICENSE)

# unit-tests-with-Classes

The purpose of this class is to allow implementing unit tests in 4D with a minimum of code. 
<br/>This class will be augmented according to my needs but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/unit-tests-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com)

See the [documentation](Documentation/Classes/ut.md) (also available via the Explorer's documentation panel) or the method <a href="Project/Sources/Methods/test_ut_class.4dm">***test\_ut\_class***</a> to learn how to use it.

`Enjoy the 4th dimension`

## Code sample

```4d
var $ut : cs.ut
$ut:=cs.ut.new()

$ut.suite("First Suite")
$ut.test("Integer formula").expect(1+1).isEqualTo(Formula(1*2))
If ($ut.success)	
   $ut.test("Text strict").expect("Hello World").strict().isEqualTo("Hello World")
   $ut.test("Not strictly equal object").expect(New object("foo"; "bar")).strict().isNotEqual(New object("foo"; "BAR"))
   $ut.test("Boolean").expect(True).noAssert().isEqualTo(False)
   ASSERT(Not($ut.successfull))
   ASSERT($ut.lastErrorText="First Suite: 'Boolean' gives 'False' when 'True' was expected")
End if 
```

More sample code into the [class documentation](Documentation/Classes/ut.md) & the <a href="Project/Sources/Methods/test_ut_class.4dm">***test\_ut\_class***</a> method
