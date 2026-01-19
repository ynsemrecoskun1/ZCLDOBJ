    METHOD add_bapiret2.
      " BAPIRET2
      DATA(lo_bapi) = cl_bali_message_setter=>create_from_bapiret2( is_bapiret2 ).

      TRY.
          mo_log->add_item( lo_bapi ).
        CATCH cx_bali_runtime.
          "handle exception
      ENDTRY.
    ENDMETHOD.