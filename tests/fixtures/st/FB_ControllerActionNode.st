(*
FB_ControllerActionNode
----------------------------------------------------------------------------
PURPOSE:
Abstract base class for all controller-related action nodes.
Provides common validation and error handling logic for controllers.
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK ABSTRACT FB_ControllerActionNode EXTENDS FB_TreeNode
VAR PROTECTED
    _ipController : I_Controller;
END_VAR

// Initialization - Inject controller dependency
METHOD PUBLIC Init
VAR_INPUT
    ipController : I_Controller;
END_VAR
    _ipController := ipController;
END_METHOD

// Validates that controller interface is configured
METHOD PROTECTED ValidateInterface : BOOL
    IF _ipController = 0 THEN
        SetError(E_ErrorId.ERR_BT_NULL_INTERFACE, 'Controller interface not configured');
        eLastStatus := E_NodeStatus.FAILURE;
        ValidateInterface := FALSE;
    ELSE
        ValidateInterface := TRUE;
    END_IF
END_METHOD

// Abstract method - subclasses provide operation-specific error message
METHOD PROTECTED ABSTRACT GetOperationErrorMessage : STRING(255)
END_METHOD

END_FUNCTION_BLOCK
