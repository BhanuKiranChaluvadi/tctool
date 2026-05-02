(*
FB_MultipleInheritance
----------------------------------------------------------------------------
Test fixture for EXTENDS and IMPLEMENTS together.
Demonstrates a function block that extends a base class and implements interfaces.
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK FB_MultipleInheritance EXTENDS FB_TreeNode IMPLEMENTS I_Device, I_Errorable
VAR
    _sName : STRING(80);
    _bError : BOOL;
END_VAR

METHOD PUBLIC GetName : STRING(80)
    GetName := _sName;
END_METHOD

METHOD PUBLIC IsError : BOOL
    IsError := _bError;
END_METHOD

METHOD PUBLIC GetError : ST_Error
VAR
    stError : ST_Error;
END_VAR
    stError.eErrorId := E_ErrorId.NO_ERROR;
    GetError := stError;
END_METHOD

METHOD PUBLIC Tick : E_NodeStatus
    Tick := E_NodeStatus.SUCCESS;
END_METHOD

END_FUNCTION_BLOCK
