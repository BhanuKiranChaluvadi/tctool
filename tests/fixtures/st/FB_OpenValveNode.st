(*
FB_OpenValveNode
----------------------------------------------------------------------------
Concrete implementation of valve action node for opening valves.
Extends FB_ValveActionNode with specific open operation logic.
----------------------------------------------------------------------------
*)
FUNCTION_BLOCK FB_OpenValveNode EXTENDS FB_ValveActionNode

// Execute valve open operation
METHOD Tick : E_NodeStatus
    IF NOT ValidateInterface() THEN
        Tick := E_NodeStatus.FAILURE;
        RETURN;
    END_IF

    _ipValve.Open();

    IF _ipValve.IsOpen() THEN
        ClearError();
        Tick := E_NodeStatus.SUCCESS;
    ELSIF CheckValveError() THEN
        Tick := E_NodeStatus.FAILURE;
    ELSE
        Tick := E_NodeStatus.RUNNING;
    END_IF

    eLastStatus := Tick;
END_METHOD

// Provide operation-specific error message
METHOD PROTECTED GetOperationErrorMessage : STRING(255)
    GetOperationErrorMessage := 'Valve reported error while opening';
END_METHOD

END_FUNCTION_BLOCK
