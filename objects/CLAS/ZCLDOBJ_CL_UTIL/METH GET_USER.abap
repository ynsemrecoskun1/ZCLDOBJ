  METHOD get_user.
    RETURN cl_abap_context_info=>get_user_technical_name(  ).
  ENDMETHOD.