# test

The class `test` is intended to work with [ut](./ut.md) class.

When you prevent the display of the failed assertion, you can get the test object to perform some verifications.   
See [How to](#howTo)

## Properties

|Properties|Type|Description|
|---------|:----:|------|
|**.desc**| Text | The description of the test
|**.successfull**| Boolean | **True** if the test was successful
|**.failed**| Boolean | **True** if the test has failed
|**.expected**| Variant | The expected test result
|**.result**| Variant | The result of the test after execution
|**.error**| Text | The error description if the test failed
|**.strict**| Boolean | **True** if the comparison is rigorous
|**.bypassed**| Boolean | **True** if the test was bypassed. In this case, the `successfull` property is set to **True** and the `error` property contains the reason for the bypass. For example: *"Skipped on Windows"* if `macOS()` was called before execution and the test was run on a Windows machine.|
|**.onMac**<br>**.onWindows**<br>**.onLinux**| Boolean | **True** if the test was not bypassed on the corresponding operating system.
|**.isText**<br>**.isNumeric**<br>**.isReal**<br>**.isInteger**<br>**.isNull**<br>**.isUndefined**<br>**.isBoolean**<br>**.isPicture**<br>**.isBlob**<br>**.isObject**<br>**.isCollection**<br>**.isPointer**<br>**.isDate**<br>**.isTime**<br>**.isFile**<br>**.isFolder**| Boolean | **True** if the expected value is of the corresponding type.

## <a name="howTo">How to</a>

```4d
var $ut : Object
$ut:=cs.ut.new()

// Start a suite
$ut.suite("No report")

// Prevent the display of the failed assertion
$ut.test("Boolean").expect(True).noReport().isEqualTo(False)

// Get the test objectvar $test : Object$test:=$ut.latestASSERT($test.failed)ASSERT($test.error="No report: 'Boolean' gives 'False' when 'True' was expected")
```
