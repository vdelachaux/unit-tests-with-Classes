# [u]NIT [t]EST

The `ut` class is designed to manage unit testing.

## Constructor

### If the class is in the current project

| |
|---------||**cs**.ut.*new* ()<br>**cs**.ut.*new* ( `reporter`: **4D**.Function )

### If the class is in a component

| |
|---------||**cs**.\<name space>.ut.*new* ()<br>**cs**.\<name space>.ut.*new* ( `reporter`: **4D**.Function )

### *reporter*

By default, the class uses the <a href="https://doc.4d.com/4Dv19/4D/19.4/ASSERT.301-6024174.en.html">***ASSERT***</a> command to check the test execution.

You can pass the constructor a <a href="https://developer.4d.com/docs/API/FunctionClass">***formula***</a> that will be called to report the execution of the test.

The `reporter` must accept to parameters:

* A `Boolean` that represents the pass/fail status of the test performed.
* A `Text` which is the [formatted message](#formattedMessages) if any, an empty string otherwise.

> 💡 If the class is in a component, you can pass as reporter `Formula (ASSERT ($1; $2))` to force execution of the **ASSERT** command in the database context.

## Properties

|Properties|Type||
|---------|:----:|------|
|**.desc**|Text|The description of the test suite
|**.tests**|Collection|The collection of the executed tests
|**.testNumber**|Integer|The number of tests performed
|**.successful**|Boolean|True if all tests of the suite are successful
|**.failed**|Boolean|True if at least one test of the suite is failed
|**.latest**|[Test object](./test.md)|The current (before run) or the last test performed (after run)
|**.testNumber**|Integer|The number of tests in the suite
|**.errorNumber**|Integer|The number of failed tests performed
|**.lastError**|[Test object](./test.md)|The last failed test
|**.lastErrorText**|Text|The last failed test error description

## Functions

💡 The `value` parameter can be a [**value of any data type**] (https://developer.4d.com/docs/Concepts/data-types) or a [**formula**] (https://developer.4d.com/docs/API/FunctionClass) returning a value, in which case it will be evaluated at runtime and the source of the formula will be used for the message if the test fails.

> All functions return a reference to the original `cs.ut`. This allows you to chain function calls. See [How to](#howTo)

----
### <a name="definition">• Definition</a>

|Function||
|--------|------|
|.**suite**(description:`Text`)<br>.**feature**(description:`Text`) | Initialize a new test suite.<br>If the `description` is omitted, it will be "Suite #" where # is the number of suites created since the call to the constructor.
|.**test**({name:`Text`})<br>.**it**({name:`Text`}) | Initializes a new test.<br>If the `name` is omitted, the name will be "Test #" where # is the number of tests in the suite.
|.**expect** (`value`) | Sets the expected test value.
|.**macOS** ()<br>.**Windows** ()<br>.**Linux** ()| Called before the [execution](#execution) function, reserves the execution to a platform.<br>• If a test is ignored on a platform, the [Test object](./test.md) object mentions it.<br>• To specify more than one platform, you can write `.macOS().Windows()`.

----
### <a name="execution">• Execution</a>

>All test execution functions call the `reporter` even if the test passes. In this case, the message is an empty string, unless the test is bypassed on this platform, where the message is something like "Bypassed on \<platform\>".

|Function|Action|
|--------|------|
|.**isEqual**(`value`)<br>.**isNotEqual**(`value`)| Performs the comparison between `value` and the expected value.<br>• `value` parameter can be a [**value of any data type**](https://developer.4d.com/docs/Concepts/data-types) or a [**formula**](https://developer.4d.com/docs/API/FunctionClass) returning a value, in which case it will be evaluated during execution.<br><br>💡 Applies only to values of type: **Text**, **Object**, **Collection**, **Image**, **Blob** or **numeric**, but can also be used with 2 **4D.Files** to compare their contents or with a **Text** and a **4D.File** to make a comparison between the text and the contents of the file.  For other types, an error is generated.
|.**isLessThan**(`value`)<br>.**isLessOrEqualTo**(`value`)<br>.**isGreaterThan**(`value`)<br>.**isGreaterOrEqualTo**(`value`)<br> | Performs a comparaisonon between a numeric `value` and the expected value.<br>If `value` or `expected value`  is not a numeric value an error is raised like : "*[suite]test : Unable to cast 'hello' to num*"

----
### <a name="keyword">• Keywords </a>

| | |
|-------- | ------ |
|**.not** | Called before an [execution](#execution) function, reverses the comparison. <br>In other words, it allows you to check whether the test should fail.
|**.strictly** | Called before an [execution](#execution) function, defines that the comparison will be diacritical if relevant.
|**.try** | Called before an [execution](#execution) function, prevents the `reporter` from being invoked even if the [Test](./test.md) object is filled. In other words, no error will be reported, but if the test has failed, its `success` property will be **False** and its `error` property will be filled in with the error description..

💡 See [How to use keywords](#howTokeyword) for some examples.

----
### <a name="shortcuts">• Shortcuts</a>

>The shortcuts avoid calling `.expect()` before running the test if you pass a value to the function. See [How to](#howTo)

|Function|Action|
|--------|------|
|.**in** ( list: `Collection`)| Tests whether the expected value is contained in a collection of values.<br>⚠️ *For objects, the comparison is made by reference and not by their content.*
|.**isTrue** (`value`)<br>.**isFalse** (`value`)| Tests the **True**/**False** status of the `value` parameter.
|.**isTruthy** (`value`)<br>.**isFalsy** (`value`)| Tests the **truthy**/**falsy** status of the `value` parameter.
|.**isNull** (`value`)<br>.**isNotNull** (`value`)| Tests the **null** or not status of the `value` parameter.
|.**isEmpty** (`value`)<br>.**isNotEmpty** (`value`)| Tests the **empty** or not status of the `value` parameter.
|.**toLength** (`value`; length:`Integer`)| Tests if the `value` length is equal to the `length` parameter.<br>⚠️ *Applies only to : Text & Collection. For other types, an error is generated.*
|.**isObject** (`value`)<br>.**isCollection** (`value`)<br>.**isText** (`value`)<br>.**isPicture** (`value`)<br>.**isBoolean** (`value`)<br>.**isUndefined** (`value`)<br>.**isBlob** (`value`)<br>.**isPointer** (`value`)<br>.**isDate** (`value`)<br>.**isTime** (`value`)<br>.**isFile** (`value`)<br>.**isFolder** (`value`)| Tests whether the type of `value` is the expected one.<br>When `isFile(...)` or `isFolder(...)` returns True, so does `isObject(...)`.

## <a name="testObject">Test object</a>

See class [`test`](./test.md)

## <a name="formattedMessages">Formatted messages</a>

The assert error message is automatically formatted according to this scheme:

`[suite.desc] {test.desc}: gives '{test.result}' when '{test.expected}' was {strictly} expected`

or

`[suite.desc] {test.desc}: {error message}`

Some examples:

>* *[suite] \<test>: gives 'Hello World' when 'hello world' was expected*
>* *[suite] \<test>: gives 'HELLO WORLD' when 'hello world' was strictly expected*
>* *[suite] \<test>: TYPE MISMATCH - Text instead of Null*
>* *[suite] \<test>: gives '2' when '1' was expected*
>* *[suite] \<test>: gives 'True' when 'False' was expected*
>* *[suite] \<test>: gives 'picture: {\"size\":166,\"width\":12,\"height\":12}' when 'picture: empty' was expected*
>* *[suite] \<test>: gives '00/00/00' when '1958/08/08' was expected*
>* *[suite] \<test>: Property '.foo' type mismatch. ACTUAL (Object) EXPECTED (Text)*
>* *[suite] \<test>: Property number mismatch ACTUAL (10) EXPECTED (12)*
>* *[suite] \<test>: Property '[1]' mismatch ACTUAL (\"bar\") EXPECTED (\"BAR\")*
>* *[suite] \<test>: gives '->number' when '->foo' was expected*
>* *[suite] \<test>: TYPE MISMATCH - Pointer instead of Nil pointer*
>* *[suite] \<test>: isFalse() cannot be applied to the type Object*
>* *[suite] \<test>: Skipped on Windows*
>* *[suite] \<test>: '10' is not less than '20'*
>* *[suite] \<test>: Succeeded when it was expected to fail, '30' is greater or equal than '20'*
>* *[suite] \<test>: Succeeded when it was expected to fail, '[1,2,3]' should not return a length of 3*

More examples in the ***test\_xxx*** methods.

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

  // Use .isNotEqual()
$ut.test("Not strictly equal objects")\
   .expect(New object("foo"; "bar"))\
   .strict().isNotEqualTo(New object("foo"; "BAR"))
```

### Use shortcuts

```4d
$ut.test("Boolean").isTrue(Formula(myMethodThatReturnsBoolean))
$ut.test("is True").isTrue(True)
$ut.test("is Null").isNull(Null)
$ut.test("is empty string").isEmpty("")
$ut.test("is empty object").isEmpty(New object)
$ut.test("is empty collection").isEmpty(New collection)
var $emptyPicture : Picture
$ut.test("is empty picture").isEmpty($emptyPicture)
var $blob : Blob
$ut.test("is empty blob").isEmpty($blob)
LONGINT TO BLOB(8858; $blob)
$ut.test("is not empty blob").isNotEmpty($blob)
```

### <a name="howTokeyword">Use keywords</a>

```4d
var $c : Collection:=[0; 1; 2; 3; 4]$ut.test().expect(10).not.in($c)$ut.test().not.expect("hello").in($c)

$ut.test().not.isFalse(Folder("/RESOURCES/"))

$ut.test().not.expect(1).isEqualTo(Null)

$ut.test("Text").expect("Hello World").strictly.isEqualTo("Hello World")$ut.test("Text").expect("Hello World").not.strictly.isEqualTo("HELLO WORLD")$ut.test("Collection").expect(["foo"; "bar"]).strictly.isEqualTo(["foo"; "bar"])$ut.test("Collection").expect(["foo"; "bar"]).not.strictly.isEqualTo(["foo"; "BAR"])
```

### Use isTrue/isFalse with a File or a Folder

```4d
$ut.test().isTrue(File(Structure file; fk platform path)) // Must pass
$ut.test().isTrue(Folder(fk database folder)) // Must pass

$test:=$ut.test().isFalse(File("/RESOURCES/fileThatDoesNotExist")) // Must pass
$test:=$ut.test().isFalse(Folder("/RESOURCES/folderThatDoesNotExist")) // Must pass
```

### Use strict() for a rigourous comparison

```4d
// The default comparison is non-diacritical
$ut.test("equal text").expect("HELLO WORLD").equal("hello world")

$ut.test("not strictly equal text")\
   .expect("HELLO WORLD")\
   .strict()\
   .expect("hello world")\
   .isNotEqualTo("HELLO WORLD")
```

### Test collections

```4d
$ut.test("Collection")\
  .expect(New collection(1; "foo"; New collection(1; "foo"; "bar")))\
  .isEqualTo(JSON Parse("[1,\"foo\",[1,\"foo\",\"bar\"]]"))
```

### Test pointers

```4d
var number : Integer
$ut.test("Pointer").expect(->number).isEqualTo(Get pointer("number"))
$ut.test("Pointer").expect(->number).isNotEqualTo(Get pointer("foo"))  // Nil pointer
```

### Use toLength()

```4d
$ut.test("Text length").expect(11).toLength("HELLO WORLD")
$ut.test("Text length").toLength("HELLO WORLD";11)
```

### Set platform restriction

```4d
$ut.test("Only on macOS").macOS().expect(True).isTrue() // This test will be skipped on Windows
```

### Start a new suite in the same test method

```4d
var $ut : cs.ut
$ut:=cs.ut.new()

    // Start a suite
$ut.suite("First Suite")

    //…

    // Start a new suite
$ut.suite("Second Suite")
ASSERT($ut.success=False)
ASSERT($ut.desc="Second Suite")
ASSERT($ut.lastError=Null)
ASSERT($ut.lastErrorText="")
ASSERT($ut.tests.length=0)
```

### Test the suite results
```4d
    // Start a new suite
$ut.suite("Test Suite")

// Perform 3 tests with 1 failing

// …

ASSERT($ut.success=False)
ASSERT($ut.desc="Test Suite")
ASSERT($ut.tests.length=3)
ASSERT($ut.lastError#Null)
ASSERT($ut.lastErrorText="something")
```

