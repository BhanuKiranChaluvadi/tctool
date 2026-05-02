(*
FB_PublicAbstractExtends
----------------------------------------------------------------------------
Test fixture for PUBLIC ABSTRACT EXTENDS combination.
Tests that all three keywords are properly parsed together.
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK PUBLIC ABSTRACT FB_PublicAbstractExtends EXTENDS FB_BaseNode
VAR PROTECTED
    _iCounter : INT;
END_VAR

METHOD PUBLIC ABSTRACT Execute : BOOL
END_METHOD

METHOD PROTECTED GetCounter : INT
    GetCounter := _iCounter;
END_METHOD

END_FUNCTION_BLOCK
