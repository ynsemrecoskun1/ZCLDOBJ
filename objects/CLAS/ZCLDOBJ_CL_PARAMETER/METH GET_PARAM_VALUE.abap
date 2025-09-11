  METHOD get_param_value.
    CHECK iv_param IS NOT INITIAL.

    SELECT SINGLE value
     FROM zi_parametervaluetable WITH PRIVILEGED ACCESS
      WHERE pname EQ @iv_param
      INTO @rv_value.
  ENDMETHOD.