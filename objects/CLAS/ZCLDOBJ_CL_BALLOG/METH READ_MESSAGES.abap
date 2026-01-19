    METHOD read_messages.
      DATA(lo_log_db) = cl_bali_log_db=>get_instance( ).

      TRY.
          DATA(lo_log) = lo_log_db->load_log( mo_log->get_handle( ) ).
        CATCH cx_bali_runtime.
          "handle exception
      ENDTRY.

      TRY.
          et_messages = lo_log->get_all_items( ).
        CATCH cx_bali_runtime.
          "handle exception
      ENDTRY.

    ENDMETHOD.