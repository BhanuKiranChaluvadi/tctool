(*
FB_ValveActionNode
----------------------------------------------------------------------------
PURPOSE:
Abstract base class for all valve-related action nodes.
Provides common validation and error handling logic.

TEMPLATE METHOD PATTERN:
- Subclasses implement specific valve operations (Open, Close, etc.)
- Base class handles null checks and error propagation

USAGE:
  FUNCTION_BLOCK FB_OpenValveNode EXTENDS FB_ValveActionNode
      // Override Tick() and GetErrorMessage()
  END_FUNCTION_BLOCK
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK ABSTRACT FB_ValveActionNode EXTENDS FB_TreeNode
VAR PROTECTED
    _ipValve : I_Valve;
END_VAR

// Initialization - Inject valve dependency
METHOD PUBLIC Init
VAR_INPUT
    ipValve : I_Valve;
END_VAR
    _ipValve := ipValve;
END_METHOD

// Validates that valve interface is configured
// Returns FALSE and sets error if validation fails
METHOD PROTECTED ValidateInterface : BOOL
    IF _ipValve = 0 THEN
        SetError(E_ErrorId.ERR_BT_NULL_INTERFACE, 'Valve interface not configured');
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
