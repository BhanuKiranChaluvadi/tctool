(*
FB_AbstractMethodTest
----------------------------------------------------------------------------
Test fixture for ABSTRACT methods with different access modifier orders.
Tests both "METHOD PROTECTED ABSTRACT" and "METHOD PROTECTED ABSTRACT".
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK ABSTRACT FB_AbstractMethodTest EXTENDS FB_TreeNode
VAR
    value : INT;
END_VAR

// Test: ABSTRACT comes before access modifier
METHOD PROTECTED ABSTRACT GetOperationErrorMessage : STRING(255)
END_METHOD

// Test: ABSTRACT comes after access modifier
METHOD PROTECTED ABSTRACT GetStatusMessage : STRING(255)
END_METHOD

// Test: PUBLIC ABSTRACT
METHOD PUBLIC ABSTRACT Initialize : BOOL
END_METHOD

END_FUNCTION_BLOCK
