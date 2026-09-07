[![language](https://img.shields.io/static/v1?label=language&message=4d&color=blue)](https://developer.4d.com/)
[![language](https://img.shields.io/github/languages/top/vdelachaux/unit-tests-with-Classes.svg)](https://developer.4d.com/)
![code-size](https://img.shields.io/github/languages/code-size/vdelachaux/unit-tests-with-Classes.svg)
[![license](https://img.shields.io/github/license/vdelachaux/unit-tests-with-Classes)](LICENSE)
[![lint](https://github.com/vdelachaux/unit-tests-with-Classes/actions/workflows/lint.yml/badge.svg)](https://github.com/vdelachaux/unit-tests-with-Classes/actions/workflows/lint.yml)

# unit-tests-with-Classes

The purpose of this class is to allow implementing unit tests in 4D with a minimum of code.
<br/>This class will be augmented according to my needs but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/unit-tests-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com)

See the [documentation](Documentation/Classes/ut.md) (also available via the Explorer's documentation panel) or the method <a href="Project/Sources/Methods/test_ut_class.4dm">***test\_ut\_class***</a> to learn how to use it.

`Enjoy the 4th dimension`

## Features

* A fluent, chainable API: `$ut.suite(...).test(...).expect(...).isEqualTo(...)`
* Shortcuts for the most common checks: `.isTrue()`, `.isFalse()`, `.isNull()`, `.isEmpty()`, `.in()`, `.toLength()`, `.isObject()`, `.isFile()`, `.isFolder()`, …
* Keywords to refine a test: `.not`, `.strictly`, `.try`
* Per-platform tests with `.macOS()`, `.Windows()`, `.Linux()`
* `.abort()` to interrupt the remaining tests as soon as an unrecoverable error is detected
* A custom `reporter` [formula](https://developer.4d.com/docs/API/FunctionClass) if you don't want to rely on `ASSERT`
* No dependency: only two classes (`ut` and `test`) to copy into your project

## Installation

Copy the two classes [`ut.4dm`](Project/Sources/Classes/ut.4dm) and [`test.4dm`](Project/Sources/Classes/test.4dm) into your project's `Classes` folder.

## Quick start

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

If you detect an error, or a hardware/network incompatibility, that will make all the following tests fail anyway, call `.abort()` to skip every remaining test:

```4d
If (Not(myHardwareIsAvailable))
	
	$ut.test("Requires the hardware").abort("Hardware not available")
	return // Nothing more to test here
	
End if 
```

More sample code into the [class documentation](Documentation/Classes/ut.md) & the <a href="Project/Sources/Methods/test_ut_class.4dm">***test\_ut\_class***</a> method

## Documentation

* [`ut` class](Documentation/Classes/ut.md): the test suite runner
* [`test` class](Documentation/Classes/test.md): the object returned for each performed test

## Contributing

Feedback, bug reports and pull requests are welcome, see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Distributed under the terms of the [LICENSE](LICENSE) file.
