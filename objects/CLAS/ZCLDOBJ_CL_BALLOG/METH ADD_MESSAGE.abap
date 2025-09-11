  METHOD add_message.
    " Classic Message
    DATA(lo_msg) = cl_bali_message_setter=>create(
        severity   = severity
        id         = id
        number     = number
        variable_1 = variable_1
        variable_2 = variable_2
        variable_3 = variable_3
        variable_4 = variable_4
         ).

    TRY.
        mo_log->add_item( lo_msg ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.
  ENDMETHOD.