# [u]NIT [t]EST

The `ut` class is designed to manage unit testing.

## Constructor

||
|---------||**cs**.ut.*new* ()<br>**cs**.ut.*new* ( `reporter`: **4D**.Function )

By default, the class uses the [**ASSERT**](https://doc.4d.com/4Dv19/4D/19.4/ASSERT.301-6024174.en.html) command to check the test execution. 

You can pass the constructor a [**formula**] (https://developer.4d.com/docs/API/FunctionClass) that will be called to report the execution of the test. 

The `reporter` must accept to parameters: 

* A `Boolean` that represents the pass/fail status of the test performed.
* A `Text` which is the [formatted message](#formattedMessages) if any, an empty string otherwise.

## Properties

|Properties|Type||
|---------|:----:|------|
|**.desc**|Text|The description of the test suite
|**.tests**|Collection|The collection of the executed tests
|**.testNumber**|Integer|The number of tests performed
|**.successful**|Boolean|True if all tests of the suite are successful
|**.failed**|Boolean|True if at least one test of the suite is failed
|**.latest**|[Test object](#testObject)|The current (before run) or the last test performed (after run)
|**.testNumber**|Integer|The number of tests in the suite
|**.errorNumber**|Integer|The number of failed tests performed
|**.lastError**|[Test object](#testObject)|The last failed test
|**.lastErrorText**|Text|The last failed test error description

## Functions

>All functions return a reference to the original `cs.ut`. This allows you to chain function calls. See [How to](#howTo)

### <a name="definition">• Definition</a>

|Function||
|--------|------|  
|.**suite**(description:`Text`)<br>.**feature**(description:`Text`) | Initialize a new test suite.
|.**test**(description:`Text`)<br>.**it**(description:`Text`) | Initializes a new test.
|.**expect** (`value`) | Sets the expected test result.<br>• `value` parameter can be a [**value of any data type**](https://developer.4d.com/docs/Concepts/data-types) or a [**formula**](https://developer.4d.com/docs/API/FunctionClass) returning a value, in which case it will be evaluated during execution.
|.**strict** ()| Called before the [execution](#execution) function, defines that the comparison will be diacritical if relevant.
|.**noReportt** ()| Called before the [execution](#execution) function, it prevents the `reporter` from being invoked even if the [Test object](#testObject) is filled.
|.**macOS** ()<br>.**Windows** ()<br>.**Linux** ()| Called before the [execution](#execution) function, reserves the execution to a platform.<br>• If a test is ignored on a platform, the [Test object](#testObject) object mentions it.<br>• To specify more than one platform, you can write `.macOS().Windows()`.


### <a name="execution">• Execution</a>

>All test execution functions call the `reporter` even if the test passes. In this case, the message is an empty string, unless the test is bypassed on this platform, where the message is something like "Bypassed on...".

|Function|Action|
|--------|------|  
|.**isEqual**(`value`)<br>.**isNotEqual**(`value`)| Performs the comparison between `value` and the expected value.<br>• `value` parameter can be a [**value of any data type**](https://developer.4d.com/docs/Concepts/data-types) or a [**formula**](https://developer.4d.com/docs/API/FunctionClass) returning a value, in which case it will be evaluated during execution.
|.**isTrue** ()<br>.**isFalse** ()| Tests the **True**/**False** value of the expected value.
|.**isTruthy** ()<br>.**isFalsy** ()| Tests the if the expected value is [truthy or falsy](https://developer.4d.com/docs/Concepts/operators#truthy-and-falsy).<br>• Note that, unlike in 4D, for a numeric, **0** is considered a **falsy** value.
|.**isNull** ()<br>.**isNotNull** ()| Tests if the expected value is **Null** or not.
|.**isEmpty** ()<br>.**isNotEmpty** ()| Tests the if the expected value is empty or not. **\***
|.**toLength** (`value`)| Tests if the parameter length is equal to the expected value. **\****

>**\*** Applies only to : Text, Object, Collection, Picture or Blob. For other types, an error is generated.   
>**\**** Applies only to : Text & Collection. For other types, an error is generated.

### <a name="shortcuts">• Shortcuts</a>

>With the exception of the `isEqual()` and `isNotEqual()` functions, the shortcuts avoid calling `.expect()` before running the test if you pass a value to the function. See [How to](#howTo)

|Function|Action|
|--------|------|  
|.**isTrue** (`value`)<br>.**isFalse** (`value`)| Tests the **True**/**False** status of the `value` parameter.
|.**isTruthy** (`value`)<br>.**isFalsy** (`value`)| Tests the **truthy**/**falsy** status of the `value` parameter.
|.**isNull** (`value`)<br>.**isNotNull** (`value`)| Tests the **null** or not status of the `value` parameter.
|.**isEmpty** (`value`)<br>.**isNotEmpty** (`value`)| Tests the **empty** or not status of the `value` parameter.
|.**toLength** (`value`; length:`Integer`)| Tests if the `value` length is equal to the `length` parameter. 

## <a name="testObject">Test object</a>

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**| Text | The description of the test
|**.successfull**| Boolean | **True** if the test was successful
|**.failed**| Boolean | **True** if the test has failed
|**.expected**| Variant | The expected test result
|**.result**| Variant | The result of the test after execution
|**.error**| Text | The [formatted error description](#formattedMessages) if the test failed
|**.bypassed**| Boolean | **True** if the test was bypassed. In this case, the `successfull` property is set to **True** and the `error` property contains the reason for the bypass. For example: *"Skipped on Windows"* if `macOS()` was called before execution and the test was run on a Windows machine.|
|**.isText**<br>**.isNumeric**<br>**.isReal**<br>**.isInteger**<br>**.isNull**<br>**.isBoolean**<br>**.isPicture**<br>**.isBlob**<br>**.isCollection**<br>**.isPointer**<br>**.isDate**<br>**.isTime**| Boolean | **True** if the expected value is of the corresponding type.
|**.onMac**<br>**.onWindows**<br>**.onLinux**| Boolean | **True** if the test was not bypassed on the corresponding operating system.

## <a name="formattedMessages">Formatted messages</a>

The assert error message is automatically formatted according to this scheme:

`{suite.desc}: '{test.desc}' gives '{test.result}' when '{test.expected}' was expected`

or

`{suite.desc}: '{test.desc}': {error message}`

Some examples:

>* *\<suite>: '\<test>' gives 'Hello World' when 'hello world' was expected*
>* *\<suite>: '\<test>' TYPE MISMATCH - Text instead of Null*
>* *\<suite>: '\<test>' gives '2' when '1' was expected*
>* *\<suite>: '\<test>' gives 'True' when 'False' was expected*
>* *\<suite>: '\<test>' gives 'picture: {\"size\":166,\"width\":12,\"height\":12}' when 'picture: empty' was expected*
>* *\<suite>: '\<test>' gives '00/00/00' when '1958/08/08' was expected*
>* *\<suite>: '\<test>' Property '.foo' type mismatch. ACTUAL (Object) EXPECTED (Text)*
>* *\<suite>: '\<test>' Property number mismatch ACTUAL (10) EXPECTED (12)*
>* *\<suite>: '\<test>' Property '[1]' mismatch ACTUAL (\"bar\") EXPECTED (\"BAR\")*
>* *\<suite>: '\<test>' gives '->number' when '->foo' was expected*
>* *\<suite>: '\<test>' TYPE MISMATCH - Pointer instead of Nil pointer*
>* *\<suite>: '\<test>' isFalse() cannot be applied to the type Object*
>* *\<suite>: '\<test>' Skipped on Windows*

More examples in the <a href="../../Project/Sources/Methods/test_internal.4dm">***test\_internal***</a> method.

## <a name="howTo">How to</a>

```4d
var $ut : cs.ut
$ut:=cs.ut.new()

// Start a suite
$ut.suite("First Suite")

// Run a test with value
$ut.test("Integer value").expect(1+1).isEqualTo(2)

// Run a test with a formula
$ut.test("Integer formula").expect(20).isEqualTo(Formula(myMultiplyingMethod(2; 10))

// Run a test with a shortcut
$ut.test("Boolean").isTrue(Formula(myMethodThatReturnsBoolean))

// The default comparison is non-diacritical
$ut.test("Text").expect("HELLO WORLD").equal("hello world")

// Test the status of the suite
If ($ut.success)
	
	// Use .strict()
	$ut.test("Strictly equal texts").expect("Hello World")\
	  .strict().equal("Hello World")
	
	// Use .isNotEqual()
	$ut.test("Not strictly equal objects")\
	  .expect(New object("foo"; "bar"))\
	  .strict().isNotEqualTo(New object("foo"; "BAR"))
	
End if 

// Test collections
$ut.test("Collection")\
  .expect(New collection(1; "foo"; New collection(1; "foo"; "bar")))\
  .isEqualTo(JSON Parse("[1,\"foo\",[1,\"foo\",\"bar\"]]"))

// Test pointers
var number : Integer
$ut.test("Pointer").expect(->number).isEqualTo(Get pointer("number"))
$ut.test("Pointer").expect(->number).isNotEqualTo(Get pointer("foo"))

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
$ut.test("Text length").toLength("HELLO WORLD";11)

// Set platform restriction
$ut.test("Only on macOS").macOS().expect(True).isTrue() // This test will be skipped on Windows

// Prevent the display of the failed assertion
var $test : cs.test
$test:=$ut.test("Boolean").expect(True).noAssert().isEqualTrue(False).latest
ASSERT($test.failed)
ASSERT($test.error="First Suite: 'Boolean' gives 'False' when 'True' was expected")

// Start a new suite
$ut.suite("Second Suite")
ASSERT($ut.success=False)
ASSERT($ut.desc="Second Suite")
ASSERT($ut.lastError=Null)
ASSERT($ut.lastErrorText="")
ASSERT($ut.tests.length=0)

//...
```
More examples in the <a href="../../Project/Sources/Methods/test_ut_class.4dm">***test\_ut\_class***</a> method.

