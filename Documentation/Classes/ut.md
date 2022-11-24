# [u]NIT [t]EST

The `ut` class is designed to manage unit testing.

## Summary

### Properties
|Properties|Type|Description|
|---------|:----:|------|
|**.desc**|Text|The description of the test suite
|**.tests**|Collection|The collection of the executed tests
|**.success**|Boolean|The status of the current test suite
|**.lastError**|[Test object](#testObject)|The last failed test
|**.lastErrorText**|Text|The last failed test error description

### Functions
|Function\*|Action|
|--------|------|  
|.**suite** (description : `Text`)  → `cs.ut` | Initialize a new test suite.
|.**test** ( description : `Text` {; type : `Integer`})  → `cs.ut` | Initializes a new test.<br>• The optional `type` parameter is only mandatory for _Time_ & _Pointer_ values in order to handle the formatted assert message correctly.
|.**expect** ( value)  → `cs.ut` : `Object` | Sets the expected test result.
|.**equal** ( value \| **4D**.Function )| Performs the comparison with the expected result and generates an ASSERT with a [formatted message](#formattedMessages) if the values are not identical.
|.**notEqual** ( value \| **4D**.Function )| Performs the comparison with the expected result and generates an ASSERT with a [formatted message](#formattedMessages) if the values are identical.
|.**strict** ()  → `cs.ut`| Called before a `.equal()` or `.notEqual()` function defines that the comparison will be diacritical if relevant.
|.**noAssert** ()  → `cs.ut`| Called before a `.equal()` or `.notEqual()` function, it prevents the ASSERT from being generated even if the [Test object](#testObject) is filled.
|.**macOS** ()  → `cs.ut`<br>.**Windows** ()  → `cs.ut`<br>.**Linux** ()  → `cs.ut`| Called before a `.equal()` or `.notEqual()` function reserves the execution to a platform.<br>• If a test is ignored on a platform, the [Test object](#testObject) object mentions it.<br>• You can specify more than one platform by writing for example `.macOS().Linux()`

\* All functions that return `cs.ut` may include one call after another. See [How to](#howTo)

## <a name="testObject">Test object</a>

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**| Text | The description of the test
|**.success**| Boolean | The status of the test after execution
|**.expected**| Variant | The expected test result
|**.result**| Variant | The result of the text after execution
|**.error**| Text | The formatted error description if the test failed
|**.bypassed**| Text | Only filled in if a test has been bypassed on the current platform. For example: `"Skipped on Windows"`

## <a name="formattedMessages">Formatted messages</a>

The assert error message is automatically formatted according to this scheme:

`{suite.desc}: '{test.desc}' gives '{test.result}' when '{test.expected}' was expected`

Some examples:

>* "Calculations: 'Integer' gives '1' when '2' was expected"
>* "DateTime: 'Date' gives '00/00/00' when '08/08/1958' was expected"
>* "Format: 'Capitalize the first letter of words' gives 'hello world' when 'Hello World' was expected"
>* "fooBar: 'Get' gives '{\"foo\":\"BAR\"}' when '{\"foo\":\"bar\"}' was expected")
>* "Catalog: 'Get pointer' gives 'NIL pointer' when '->[Table1]Field1' was expected"
>* "Assets: 'Application icon' gives 'picture: empty' when 'picture: {\"size\":166,\"width\":12,\"height\":12}' was expected"

## <a name="howTo">How to</a>

```4d
var $ut : cs.ut
$ut:=cs.ut.new()

// Start a suite
$ut.suite("First Suite")

// Run a test with value
$ut.test("Integer value").expect(1+1).equal(2)

// Run a test with a formula
$ut.test("Integer formula").expect(1+1).equal(Formula(myMethod))

// The default comparison is non-diacritical
$ut.test("Text").expect("HELLO WORLD").equal("hello world")

// Test the status of the suite
If ($ut.success)
	
	// Use .strict()
	$ut.test("Strictly equal texts").expect("Hello World")\
	  .strict().equal("Hello World")
	
	// Use .notEqual()
	$ut.test("Not strictly equal objects")\
	  .expect(New object("foo"; "bar"))\
	  .strict().notEqual(New object("foo"; "BAR"))
	
End if 

// Test collections
$ut.test("Collection")\
  .expect(New collection(1; "foo"; New collection(1; "foo"; "bar")))\
  .equal(JSON Parse("[1,\"foo\",[1,\"foo\",\"bar\"]]"))

// Test pointers
var number : Integer
$ut.test("Pointer").expect(->number).equal(Get pointer("number"))
$ut.test("Pointer").expect(->number).notEqual(Get pointer("foo"))

// Use platform restriction
$ut.test("Only on macOS").macOS().expect(True).equal(Is macOS) // This test will be skipped on Windows

// Use .noAssert()
$ut.test("Boolean").expect(True).noAssert().equal(False)
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


