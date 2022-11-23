# [u]NIT [t]EST

The `ut` class is designed to manage unit testing.

## Summary

### Properties
|Properties|Type|Description|
|---------|:----:|------|
|**.desc**|Text|The description of the test suite
|**.tests**|Collection|The collection of the executed tests
|**.success**|Boolean|The status of the current test suite
|**.lastError**|`Test object`|The last failed test
|**.lastErrorText**|Text|The last failed test error description

### Functions
|Function\*|Action|
|--------|------|  
|.**suite** (description : `Text`)  → `cs.ut` | Initialize a new test suite
|.**test** ( description : `Text` {; type : `Integer`})  → `cs.ut` | Initializes a new test.<br>• The `type` option of the value is mandatory for time values in order to handle the formatted assert message correctly.<br>• If passed, it also allows to perform checks.
|.**expect** ( value : `Variant`)  → `cs.ut` : `Object` | Sets the expected test result
|.**equal** ( value : `Variant` \| **4D**.Function )| Performs the comparison with the expected result and generates an ASSERT with a formatted message if the values are identical.<br>The assert error message is automatically formulated according to this scheme:<br> `{suite}: '{test}' gives {result} when '{expected}' was expected`\**
|.**notEqual** ( value : `Variant` \| **4D**.Function )| Performs the comparison with the expected result and generates an ASSERT with a formatted message if the values are not identical.
|.**strict** ()  → `cs.ut`| Called before a `.equal()` or `.notEqual()` function defines that the comparison will be diacritical if relevant.
|.**skipError** ()  → `cs.ut`| Called before a `.equal()` or `.notEqual()` function, it prevents the ASSERT from being generated even if the `test` object is filled.

\* All functions that return `cs.ut` may include one call after another.

\** Examples of formatted messages:

* "Numeric: 'Integer' gives '1' when '2' was expected"
* "DateTime: 'Date' gives '00/00/00' when '08/08/1958' was expected"
* "Diacritical: 'Not strictly equal text' gives 'hello world' when 'Hello World' was expected"
* "Diacritical: 'Not strictly equal object' gives '{\"foo\":\"BAR\"}' when '{\"foo\":\"bar\"}' was expected")

## Test object

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**| Text | The description of the test
|**.success**| Boolean | The status of the test after execution
|**.expected**| Variant | The expected test result
|**.result**| Variant | The result of the text after execution
|**.error**| Text | The formatted error description if the test failed

## How to

```4d
var $ut : cs.ut
$ut:=cs.ut.new()

// Start a suite
$ut.suite("First Suite")

// Run a test with a formula
$ut.test("Integer formula").expect(1+1).equal(Formula(1*2))

// Run a test with value
$ut.test("Integer value").expect(1+1).equal(2)

$ut.test("Text").expect("HELLO WORLD").equal("hello world")

// Test the suite status
If ($ut.success)
	
	// Use .strict()
	$ut.test("Text strict").expect("Hello World").strict().equal("Hello World")
	
	// Use .notEqual()
	$ut.test("Not strictly equal object").expect(New object("foo"; "bar")).strict().notEqual(New object("foo"; "BAR"))
	
End if 

// Test collections
$ut.test("Collection").expect(New collection(1; "foo"; New collection(1; "foo"; "bar"))).equal(JSON Parse("[1,\"foo\",[1,\"foo\",\"bar\"]]"))

// Test pointers
var number : Integer
$ut.test("Pointer").expect(->number).equal(Get pointer("number"))
$ut.test("Pointer").expect(->number).notEqual(Get pointer("foo"))

// Use .skipError()
$ut.test("Boolean").expect(True).skipError().equal(False)
ASSERT(Not($ut.success))
ASSERT($ut.lastErrorText="First Suite: 'Boolean' gives 'False' when 'True' was expected")

// Start a new suite
$ut.suite("Second Suite")
ASSERT($ut.success=False)
ASSERT($ut.desc="Second Suite")
ASSERT($ut.lastError=Null)
ASSERT($ut.lastErrorText="")
ASSERT($ut.tests.length=0)

//...
```


