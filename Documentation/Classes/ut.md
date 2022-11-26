# [u]NIT [t]EST

The `ut` class is designed to manage unit testing.

## Properties

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**|Text|The description of the test suite
|**.tests**|Collection|The collection of the executed tests
|**.testNumber**|Integer|The number of tests performed
|**.success**|Boolean|The status of the current test suite
|**.lastTest**|[Test object](#testObject)|The last test performed
|**.errorNumber**|Integer|The number of failed tests performed
|**.lastError**|[Test object](#testObject)|The last failed test
|**.lastErrorText**|Text|The last failed test error description

## Functions

### <a name="definition">• Definition</a>

>All defining functions return a reference to the original `cs.ut`. This allows you to chain function calls. See [How to](#howTo)

|Function|Action|
|--------|------|  
|.**suite**(description:`Text`)  → `cs.ut` | Initialize a new test suite.
|.**test**(description:`Text`{;type:`Integer`})→`cs.ut` | Initializes a new test.<br>• The optional `type` parameter is only mandatory for _Time_ & _Pointer_ values in order to handle the formatted assert message correctly.
|.**expect**(value)→`cs.ut`:`Object` | Sets the expected test result.
|.**strict**()→`cs.ut`| Called before the [execution](#execution) function, defines that the comparison will be diacritical if relevant.
|.**noAssert**()→`cs.ut`| Called before the [execution](#execution) function, it prevents the ASSERT from being generated even if the [Test object](#testObject) is filled.
|.**macOS**()→`cs.ut`<br>.**Windows** ()  → `cs.ut`<br>.**Linux** ()  → `cs.ut`| Called before the [execution](#execution) function, reserves the execution to a platform.<br>• If a test is ignored on a platform, the [Test object](#testObject) object mentions it.<br>• You can specify more than one platform by writing for example `.macOS().Windows()`


### <a name="execution">• Execution</a>

>All test execution functions perform the comparison between `toTest` and an expected value.
>
>The `toTest` can be a [**value of any data type**](https://developer.4d.com/docs/19/Concepts/data-types) or a [**formula**](https://developer.4d.com/docs/19/API/FunctionClass) returning a value, in which case it will be evaluated during execution.

|Function|Action|
|--------|------|  
|.**equal**(`toTest`)<br>.**notEqual**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the values are identical/not identical.<br>• These 2 functions require that .**expect**() has been called beforehand.
|.**isTrue**(`toTest`)<br>.**isFalse**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the result is not **True**/**False**.
|.**isNull**(`toTest`)<br>.**isNotNull**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the result is **Null** or not.
|.**isEmpty**(`toTest`)<br>.**isNotEmpty**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the result is empty or not. **\***
|.**isTruthy**(`toTest`)<br>.**isFalsy**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the result is not [truthy /falsy](https://developer.4d.com/docs/Concepts/operators#truthy-and-falsy).<br>• Note that, for a numeric, 0 is considered as a _falsy_ value.
|.**toLength**(`toTest`)| Generates an **ASSERT** with a [formatted message](#formattedMessages) if the result length is not the expected one. **\****

>**\*** Applies only to : Text, Object, Collection, Picture or Blob. For other types, an error is generated.   
>**\**** Applies only to : Text & Collection. For other types, an error is generated.

## <a name="testObject">Test object</a>

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**| Text | The description of the test
|**.success**| Boolean | The status of the test after execution
|**.expected**| Variant | The expected test result
|**.result**| Variant | The result of the test after execution
|**.error**| Text | The [formatted error description](#formattedMessages) if the test failed
|**.bypassed**| Text | For example: `"Skipped on Windows"` if `macOS()` was called before execution and the test was run on a Windows machine. If a test is bypassed, the `success` property is set to **True**<br>

## <a name="formattedMessages">Formatted messages</a>

The assert error message is automatically formatted according to this scheme:

`{suite.desc}: '{test.desc}' gives '{test.result}' when '{test.expected}' was expected`

or

`{suite.desc}: '{test.desc}' {error message}`

Some examples:

>* "Calculations: 'Integer' gives '1' when '2' was expected"
>* "DateTime: 'Get date' gives '00/00/00' when '08/08/1958' was expected"
>* "Format: 'Capitalize the first letter of words' gives 'hello world' when 'Hello World' was expected"
>* "fooBar: 'Get object' gives '{\"foo\":\"BAR\"}' when '{\"foo\":\"bar\"}' was expected"
>* "Catalog: 'Get pointer' gives 'NIL pointer' when '->[Table1]Field1' was expected"
>* "Assets: 'Application icon' gives 'picture: empty' when 'picture: {\"size\":166,\"width\":12,\"height\":12}' was expected"
>* "test 1: 'is not non Null' gives 'null' when 'not null' was expected"
>* "test 1: 'is not empty blob: as returned an empty BLOB"
>* "Length: 'Text length' gives '11' when '12' was expected"
>* "Length: 'invalid target': toLength() can't be applied to the type Object"
>* "Boolean: 'is empty Boolean: isEmpty/NotEmpty can't be applied to the type Boolean"

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

$ut.test("is True").isTrue(True)

$ut.test("is Null").isNull(Null)

$ut.test("is empty string").isEmpty("")

$ut.test("is empty object").isEmpty(New object)
$ut.test("is empty collection").isEmpty(New collection)
$ut.test("is empty picture").isEmpty($emptyPicture)
var $blob : Blob
$ut.test("is empty blob").isEmpty($blob)

LONGINT TO BLOB(8858; $blob)
$ut.test("is not empty blob").isNotEmpty($blob)

$ut.test("Text length").expect(11).toLength("HELLO WORLD")

// Set platform restriction
$ut.test("Only on macOS").macOS().expect(True).equal(Is macOS) // This test will be skipped on Windows

// Prevent the display of the failed assertion
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


