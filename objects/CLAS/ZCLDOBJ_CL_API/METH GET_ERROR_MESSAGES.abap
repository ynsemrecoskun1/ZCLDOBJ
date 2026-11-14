  METHOD get_error_messages.
    DATA: lv_body  TYPE string,
          lv_code  TYPE string,
          lv_text  TYPE string,
          lt_found TYPE tyt_message_items.

    IF io_catch_data IS NOT BOUND.
      RETURN.
    ENDIF.

    IF io_catch_data IS INSTANCE OF /iwbep/cx_cp_remote.
      DATA(lx_remote) = CAST /iwbep/cx_cp_remote( io_catch_data ).
      lv_body = lx_remote->http_error_body.
      lv_code = lx_remote->s_odata_error-code.
      lv_text = lx_remote->s_odata_error-message.
    ENDIF.

    IF lv_body IS NOT INITIAL.
      TRY.
          walk_error_node( EXPORTING ir_node     = /ui2/cl_json=>generate( json = lv_body )
                           CHANGING  ct_messages = lt_found ).
        CATCH cx_root.
          CLEAR lt_found.
      ENDTRY.
    ENDIF.

    IF lt_found IS INITIAL.
      IF lv_text IS INITIAL AND io_catch_data IS INSTANCE OF if_message.
        DATA(lo_message) = CAST if_message( io_catch_data ).
        lv_text = lo_message->get_longtext( ).
        IF lv_text IS INITIAL.
          lv_text = lo_message->get_text( ).
        ENDIF.
      ENDIF.
      IF lv_text IS NOT INITIAL.
        DATA(ls_fallback) = VALUE ty_message_item( code = lv_code message = lv_text severity = 'error' ).
        enrich_message_item( CHANGING cs_item = ls_fallback ).
        APPEND ls_fallback TO lt_found.
      ENDIF.
    ENDIF.

    LOOP AT lt_found INTO DATA(ls_found).
      IF ls_found-severity = 'warning' OR ls_found-severity = 'info' OR ls_found-severity = 'success'.
        CONTINUE.
      ENDIF.
      IF ir_codes IS NOT INITIAL AND ls_found-code IN ir_codes.
        CONTINUE.
      ENDIF.
      IF line_exists( rt_messages[ message = ls_found-message ] ).
        CONTINUE.
      ENDIF.
      APPEND ls_found TO rt_messages.
    ENDLOOP.
  ENDMETHOD.