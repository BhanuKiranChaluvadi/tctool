(*
FB_SetControllerNode
----------------------------------------------------------------------------
Concrete implementation for setting controller setpoint.
Extends FB_ControllerActionNode with setpoint operation logic.
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK FB_SetControllerNode EXTENDS FB_ControllerActionNode
VAR
    _rSetpoint : REAL;
END_VAR

// Configure setpoint value
METHOD PUBLIC Configure
VAR_INPUT
    rSetpoint : REAL;
END_VAR
    _rSetpoint := rSetpoint;
END_METHOD

// Execute controller setpoint operation
METHOD Tick : E_NodeStatus
    IF NOT ValidateInterface() THEN
        Tick := E_NodeStatus.FAILURE;
        RETURN;
    END_IF

    _ipController.SetSetpoint(_rSetpoint);

    IF _ipController.IsAtSetpoint() THEN
        ClearError();
        Tick := E_NodeStatus.SUCCESS;
    ELSIF _ipController.IsError() THEN
        SetError(E_ErrorId.ERR_BT_CONTROLLER_ERROR, GetOperationErrorMessage());
        Tick := E_NodeStatus.FAILURE;
    ELSE
        Tick := E_NodeStatus.RUNNING;
    END_IF

    eLastStatus := Tick;
END_METHOD

// Provide operation-specific error message
METHOD PROTECTED GetOperationErrorMessage : STRING(255)
    GetOperationErrorMessage := 'Controller reported error while setting setpoint';
END_METHOD

END_FUNCTION_BLOCK
