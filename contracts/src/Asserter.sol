/*
    Contract: Asserter

    Assertions for unit testing contracts. Tests are run with the
    <solUnit at https://github.com/smartcontractproduction/sol-unit>
    unit-testing framework.

    All assertions are internal (to make compilation faster) but the _ in front of the
    function name is still omitted. This is just for convenience.

    The library is meant to be extended by test contracts, e.g.

    (start code)
    contract ModAdder {

        function addMod(uint a, uint b, uint modulus) constant returns (uint sum) {
            if (modulus == 0)
                throw;
            return addmod(a, b, modulus);
        }

    }

    contract SomeTest is Asserter {

        function testAdd() {
            var adder = new ModAdder();
            var sum = adder.addMod(50, 66, 30);
            assertUintsEqual(sum, 26, "addition returned the wrong sum");
        }
    }
    (end)

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
contract Asserter {

    // Constant: ADDRESS_NULL
    // The null address: 0
    address constant ADDRESS_NULL = 0;
    // Constant: BYTES32_NULL
    // The null bytes32: 0
    bytes32 constant BYTES32_NULL = 0;
    // Constant: STRING_NULL
    // The null string: ""
    string constant STRING_NULL = "";

    /*
        Event: TestEvent

        Fired when an assertion is made.

        Params:
            result (bool) - Whether or not the assertion holds.
            message (string) - A message to display if the assertion does not hold.
    */
    event TestEvent(bool indexed result, string message);

    // ************************************** strings **************************************

    /*
        Function: assertStringsEqual

        Assert that two strings are equal.

        : _stringsEqual(A, B) == true

        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertStringsEqual(string A, string B, string message) internal constant returns (bool result) {
        result = _stringsEqual(A, B);
        _report(result, message);
    }

    /*
        Function: assertStringsNotEqual

        Assert that two strings are not equal.

        : _stringsEqual(A, B) == false

        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertStringsNotEqual(string A, string B, string message) internal constant returns (bool result) {
        result = !_stringsEqual(A, B);
        _report(result, message);
    }

    /*
        Function: assertStringEmpty

        Assert that a string is empty.

        : _stringsEqual(str, STRING_NULL) == true

        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertStringEmpty(string str, string message) internal constant returns (bool result) {
        result = _stringsEqual(str, STRING_NULL);
        _report(result, message);
    }

    /*
        Function: assertStringNotEmpty

        Assert that a string is not empty.

        : _stringsEqual(str, STRING_NULL) == false

        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertStringNotEmpty(string str, string message) internal constant returns (bool result) {
        result = !_stringsEqual(str, STRING_NULL);
        _report(result, message);
    }
    
/*
        Function: assertEqual(string)

        Assert that two strings are equal.

        : _stringsEqual(A, B) == true

        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(string A, string B) internal constant returns (bool result) {
        result = _stringsEqual(A, B);
    }

    /*
        Function: assertNotEqual(string)

        Assert that two strings are not equal.

        : _stringsEqual(A, B) == false

        Params:
            A (string) - The first string.
            B (string) - The second string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(string A, string B, string message) internal constant returns (bool result) {
        result = !_stringsEqual(A, B);
        _report(result, message);
    }

    /*
        Function: assertEmpty(string)

        Assert that a string is empty.

        : _stringsEqual(str, STRING_NULL) == true

        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEmpty(string str, string message) internal constant returns (bool result) {
        result = _stringsEqual(str, STRING_NULL);
        _report(result, message);
    }

    /*
        Function: assertNotEmpty(string)

        Assert that a string is not empty.

        : _stringsEqual(str, STRING_NULL) == false

        Params:
            str (string) - The string.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEmpty(string str, string message) internal constant returns (bool result) {
        result = !_stringsEqual(str, STRING_NULL);
        _report(result, message);
    }

    // ************************************** bytes32 **************************************

    /*
        Function: assertBytes32Equal

        Assert that two 'bytes32' are equal.

        : A == B

        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBytes32Equal(bytes32 A, bytes32 B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertBytes32NotEqual

        Assert that two 'bytes32' are not equal.

        : A != B

        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBytes32NotEqual(bytes32 A, bytes32 B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertBytes32Zero

        Assert that a 'bytes32' is zero.

        : bts == BYTES32_NULL

        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBytes32Zero(bytes32 bts, string message) internal constant returns (bool result) {
        result = (bts == BYTES32_NULL);
        _report(result, message);
    }

    /*
        Function: assertBytes32NotZero

        Assert that a 'bytes32' is not zero.

        : bts != BYTES32_NULL

        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBytes32NotZero(bytes32 bts, string message) internal constant returns (bool result) {
        result = (bts != BYTES32_NULL);
        _report(result, message);
    }
    
    /*
        Function: assertEqual(bytes32)

        Assert that two 'bytes32' are equal.

        : A == B

        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(bytes32 A, bytes32 B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertNotEqual(bytes32)

        Assert that two 'bytes32' are not equal.

        : A != B

        Params:
            A (bytes32) - The first 'bytes32'.
            B (bytes32) - The second 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(bytes32 A, bytes32 B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertZero(bytes32)

        Assert that a 'bytes32' is zero.

        : bts == BYTES32_NULL

        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertZero(bytes32 bts, string message) internal constant returns (bool result) {
        result = (bts == BYTES32_NULL);
        _report(result, message);
    }

    /*
        Function: assertNotZero(bytes32)

        Assert that a 'bytes32' is not zero.

        : bts != BYTES32_NULL

        Params:
            bts (bytes32) - The 'bytes32'.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotZero(bytes32 bts, string message) internal constant returns (bool result) {
        result = (bts != BYTES32_NULL);
        _report(result, message);
    }

    // ************************************** address **************************************

    /*
        Function: assertAddressesEqual

        Assert that two addresses are equal.

        : A == B

        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertAddressesEqual(address A, address B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }
    /*
        Function: assertAddressesNotEqual

        Assert that two addresses are not equal.

        : A != B

        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertAddressesNotEqual(address A, address B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertAddressZero

        Assert that an address is zero.

        : addr == ADDRESS_NULL

        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertAddressZero(address addr, string message) internal constant returns (bool result) {
        result = (addr == ADDRESS_NULL);
        _report(result, message);
    }

    /*
        Function: assertAddressNotZero

        Assert that an address is not zero.

        : addr != ADDRESS_NULL

        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertAddressNotZero(address addr, string message) internal constant returns (bool result) {
        result = (addr != ADDRESS_NULL);
        _report(result, message);
    }
    
    /*
        Function: assertEqual(address)

        Assert that two addresses are equal.

        : A == B

        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(address A, address B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }
    /*
        Function: assertNotEqual(address)

        Assert that two addresses are not equal.

        : A != B

        Params:
            A (address) - The first address.
            B (address) - The second address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(address A, address B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertZero(address)

        Assert that an address is zero.

        : addr == ADDRESS_NULL

        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertZero(address addr, string message) internal constant returns (bool result) {
        result = (addr == ADDRESS_NULL);
        _report(result, message);
    }

    /*
        Function: assertNotZero(address)

        Assert that an address is not zero.

        : addr != ADDRESS_NULL

        Params:
            addr (address) - The address.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotZero(address addr, string message) internal constant returns (bool result) {
        result = (addr != ADDRESS_NULL);
        _report(result, message);
    }

    // ************************************** bool **************************************

    /*
        Function: assertBoolsEqual

        Assert that two booleans are equal.

        : A == B

        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBoolsEqual(bool A, bool B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertBoolsNotEqual

        Assert that two booleans are not equal.

        : A != B

        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertBoolsNotEqual(bool A, bool B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertTrue

        Assert that a boolean is 'true'.

        : b == true

        Params:
            b (bool) - The boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertTrue(bool b, string message) internal constant returns (bool result) {
        result = b;
        _report(result, message);
    }

    /*
        Function: assert

        Shorthand for 'assertTrue'

        : b == true

        Params:
            b (bool) - The boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assert(bool b, string message) internal constant returns (bool result) {
        result = b;
        _report(result, message);
    }

    /*
        Function: assertFalse

        Assert that a boolean is 'false'.

        : b == false

        Params:
            b (bool) - The boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertFalse(bool b, string message) internal constant returns (bool result) {
        result = !b;
        _report(result, message);
    }

    /*
        Function: assertEqual(bool)

        Assert that two booleans are equal.

        : A == B

        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(bool A, bool B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertNotEqual(bool)

        Assert that two booleans are not equal.

        : A != B

        Params:
            A (bool) - The first boolean.
            B (bool) - The second boolean.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(bool A, bool B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    // ************************************** uint **************************************

    /*
        Function: assertUintsEqual

        Assert that two (256 bit) unsigned integers are equal.

        : A == B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintsEqual(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertUintsNotEqual

        Assert that two (256 bit) unsigned integers are not equal.

        : A != B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintsNotEqual(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertUintGT

        Assert that the uint 'A' is greater than the uint 'B'.

        : A > B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintGT(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A > B);
        _report(result, message);
    }

    /*
        Function: assertUintGTOE

        Assert that the uint 'A' is greater than or equal to the uint 'B'.

        : A >= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintGTOE(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A >= B);
        _report(result, message);
    }

    /*
        Function: assertUintLT

        Assert that the uint 'A' is lesser than the uint 'B'.

        : A < B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintLT(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A < B);
        _report(result, message);
    }

    /*
        Function: assertUintLTOE

        Assert that the uint 'A' is lesser than or equal to the uint 'B'.

        : A <= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintLTOE(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A <= B);
        _report(result, message);
    }

    /*
        Function: assertUintZero

        Assert that a (256 bit) unsigned integer is 0.

        : number == 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintZero(uint number, string message) internal constant returns (bool result) {
        result = (number == 0);
        _report(result, message);
    }

    /*
        Function: assertUintNotZero

        Assert that a (256 bit) unsigned integer is not 0.

        : number != 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertUintNotZero(uint number, string message) internal constant returns (bool result) {
        result = (number != 0);
        _report(result, message);
    }
    
    /*
        Function: assertEqual(uint)

        Assert that two (256 bit) unsigned integers are equal.

        : A == B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertNotEqual(uint)

        Assert that two (256 bit) unsigned integers are not equal.

        : A != B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertGT(uint)

        Assert that the uint 'A' is greater than the uint 'B'.

        : A > B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertGT(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A > B);
        _report(result, message);
    }

    /*
        Function: assertGTOE(uint)

        Assert that the uint 'A' is greater than or equal to the uint 'B'.

        : A >= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertGTOE(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A >= B);
        _report(result, message);
    }

    /*
        Function: assertLT(uint)

        Assert that the uint 'A' is lesser than the uint 'B'.

        : A < B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertLT(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A < B);
        _report(result, message);
    }

    /*
        Function: assertLTOE(uint)

        Assert that the uint 'A' is lesser than or equal to the uint 'B'.

        : A <= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertLTOE(uint A, uint B, string message) internal constant returns (bool result) {
        result = (A <= B);
        _report(result, message);
    }

    /*
        Function: assertZero(uint)

        Assert that a (256 bit) unsigned integer is 0.

        : number == 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertZero(uint number, string message) internal constant returns (bool result) {
        result = (number == 0);
        _report(result, message);
    }

    /*
        Function: assertNotZero(uint)

        Assert that a (256 bit) unsigned integer is not 0.

        : number != 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotZero(uint number, string message) internal constant returns (bool result) {
        result = (number != 0);
        _report(result, message);
    }

    // ************************************** int **************************************

    /*
        Function: assertUIntsEqual

        Assert that two (256 bit) signed integers are equal.

        : A == B

        Params:
            A (uint) - The first int.
            B (uint) - The second int.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntsEqual(int A, int B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertUintsNotEqual

        Assert that two (256 bit) unsigned integers are not equal.

        : A != B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntsNotEqual(int A, int B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertUintGT

        Assert that the uint 'A' is greater than the uint 'B'.

        : A > B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntGT(int A, int B, string message) internal constant returns (bool result) {
        result = (A > B);
        _report(result, message);
    }

    /*
        Function: assertUintGTOE

        Assert that the uint 'A' is greater than or equal to the uint 'B'.

        : A >= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntGTOE(int A, int B, string message) internal constant returns (bool result) {
        result = (A >= B);
        _report(result, message);
    }

    /*
        Function: assertUintLT

        Assert that the uint 'A' is lesser than the uint 'B'.

        : A < B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntLT(int A, int B, string message) internal constant returns (bool result) {
        result = (A < B);
        _report(result, message);
    }

    /*
        Function: assertUintLTOE

        Assert that the uint 'A' is lesser than or equal to the uint 'B'.

        : A <= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntLTOE(int A, int B, string message) internal constant returns (bool result) {
        result = (A <= B);
        _report(result, message);
    }

    /*
        Function: assertUintZero

        Assert that a (256 bit) unsigned integer is 0.

        : number == 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntZero(int number, string message) internal constant returns (bool result) {
        result = (number == 0);
        _report(result, message);
    }

    /*
        Function: assertUintNotZero

        Assert that a (256 bit) unsigned integer is not 0.

        : number != 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertIntNotZero(int number, string message) internal constant returns (bool result) {
        result = (number != 0);
        _report(result, message);
    }

    /*
        Function: assertEqual(int)

        Assert that two (256 bit) signed integers are equal.

        : A == B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(int A, int B, string message) internal constant returns (bool result) {
        result = (A == B);
        _report(result, message);
    }

    /*
        Function: assertNotEqual(int)

        Assert that two (256 bit) signed integers are not equal.

        : A != B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(int A, int B, string message) internal constant returns (bool result) {
        result = (A != B);
        _report(result, message);
    }

    /*
        Function: assertGT(int)

        Assert that the int 'A' is greater than the int 'B'.

        : A > B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertGT(int A, int B, string message) internal constant returns (bool result) {
        result = (A > B);
        _report(result, message);
    }

    /*
        Function: assertGTOE(int)

        Assert that the int 'A' is greater than or equal to the int 'B'.

        : A >= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertGTOE(int A, int B, string message) internal constant returns (bool result) {
        result = (A >= B);
        _report(result, message);
    }

    /*
        Function: assertLT(int)

        Assert that the int 'A' is lesser than the int 'B'.

        : A < B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertLT(int A, int B, string message) internal constant returns (bool result) {
        result = (A < B);
        _report(result, message);
    }

    /*
        Function: assertLTOE(int)

        Assert that the int 'A' is lesser than or equal to the int 'B'.

        : A <= B

        Params:
            A (uint) - The first uint.
            B (uint) - The second uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertLTOE(int A, int B, string message) internal constant returns (bool result) {
        result = (A <= B);
        _report(result, message);
    }

    /*
        Function: assertZero(int)

        Assert that a (256 bit) signed integer is 0.

        : number == 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertZero(int number, string message) internal constant returns (bool result) {
        result = (number == 0);
        _report(result, message);
    }

    /*
        Function: assertNotZero(int)

        Assert that a (256 bit) signed integer is not 0.

        : number != 0

        Params:
            number (uint) - The uint.
            message (string) - A message that is sent if the assertion fails.

        Returns:
            result (bool) - The result.
    */
    function assertNotZero(int number, string message) internal constant returns (bool result) {
        result = (number != 0);
        _report(result, message);
    }

    /******************************** errors ********************************/

    /*
        Function: assertErrorsEqual

        Assert that two error codes (uint16) are equal.

        : errorCode1 == errorCode2

        Params:
            errorCode1 (uint16) - the first error code.
            errorCode2 (uint16) - the second error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertErrorsEqual(uint16 errorCode1, uint16 errorCode2, string message) internal constant returns (bool result) {
        result = (errorCode1 == errorCode2);
        _report(result, message);
    }

    /*
        Function: assertErrorsNotEqual

        Assert that two error codes (uint16) are not equal.

        : errorCode1 != errorCode2

        Params:
            errorCode1 (uint16) - the first error code.
            errorCode2 (uint16) - the second error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertErrorsNotEqual(uint16 errorCode1, uint16 errorCode2, string message) internal constant returns (bool result) {
        result = (errorCode1 != errorCode2);
        _report(result, message);
    }

    /*
        Function: assertEqual(uint16)

        Assert that two error codes (uint16) are equal.

        : errorCode1 == errorCode2

        Params:
            errorCode1 (uint16) - the first error code.
            errorCode2 (uint16) - the second error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertEqual(uint16 errorCode1, uint16 errorCode2, string message) internal constant returns (bool result) {
        result = (errorCode1 == errorCode2);
        _report(result, message);
    }

    /*
        Function: assertNotEqual(uint16)

        Assert that two error codes (uint16) are not equal.

        : errorCode1 != errorCode2

        Params:
            errorCode1 (uint16) - the first error code.
            errorCode2 (uint16) - the second error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertNotEqual(uint16 errorCode1, uint16 errorCode2, string message) internal constant returns (bool result) {
        result = (errorCode1 != errorCode2);
        _report(result, message);
    }

    /*
        Function: assertError

        Assert that the code (uint16) is not the null error.

        : errorCode != 0

        Params:
            errorCode (uint16) - the error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertError(uint16 errorCode, string message) internal constant returns (bool result) {
        result = (errorCode != 0);
        _report(result, message);
    }

    /*
        Function: assertError

        Assert that the code (uint16) is the null error.

        : errorCode == 0

        Params:
            errorCode (uint16) - the error code.
            message (string) - A message to display if the assertion does not hold.

        Returns:
            result (bool) - The result.
    */
    function assertNoError(uint16 errorCode, string message) internal constant returns (bool result) {
        result = (errorCode == 0);
        _report(result, message);
    }

    /******************************** internal ********************************/

        /*
            Function: _report

            Internal function for triggering <TestEvent>.

            Params:
                result (bool) - The test result (true or false).
                message (string) - The message that is sent if the assertion fails.
        */
    function _report(bool result, string message) internal constant {
        if(result)
            TestEvent(true, "");
        else
            TestEvent(false, message);
    }

    /*
        Function: _compareStrings

        Does a byte-by-byte lexicographical comparison of two strings.
        Taken from the StringUtils contract in the Ethereum Dapp-bin
        (https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol).

        Params:
            a (string) - The first string.
            b (string) - The second string.

        Returns:
             result (int) - a negative number if 'a' is smaller, zero if they are equal,
                and a positive number if 'b' is smaller.
    */
    function _compareStrings(string a, string b) returns (int result) {
        bytes memory ba = bytes(a);
        bytes memory bb = bytes(b);
        uint minLength = ba.length;
        if (bb.length < minLength) minLength = bb.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint i = 0; i < minLength; i ++)
            if (ba[i] < bb[i])
                return -1;
            else if (ba[i] > bb[i])
                return 1;
        if (ba.length < bb.length)
            return -1;
        else if (ba.length > bb.length)
            return 1;
        else
            return 0;
    }

    /*
        Function: _stringsEqual

        Compares two strings. Taken from the StringUtils contract in the Ethereum Dapp-bin
        (https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol).

        Params:
            a (string) - The first string.
            b (string) - The second string.

        Returns:
             result (int) - 'true' if the strings are equal, otherwise 'false'.
    */
    function _stringsEqual(string a, string b) internal returns (bool result) {
        return _compareStrings(a, b) == 0;
    }

}