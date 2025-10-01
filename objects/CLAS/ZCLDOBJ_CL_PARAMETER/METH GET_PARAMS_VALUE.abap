  METHOD get_params_value.
    CHECK ct_params IS NOT INITIAL.

    SELECT param~pname,
           param~value
     FROM @ct_params AS itab
      INNER JOIN ZI_ParameterValueTable WITH PRIVILEGED ACCESS AS param
      ON itab~name EQ param~pname
      INTO TABLE @ct_params.
  ENDMETHOD.