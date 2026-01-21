  METHOD deserialize_errors.
    DATA: ls_error_body TYPE ty_errorbody.
    TRY.
        ASSIGN ('IO_CATCH_DATA->HTTP_ERROR_BODY') TO FIELD-SYMBOL(<lfs_error_body>).

        IF <lfs_error_body> IS ASSIGNED.
          CALL METHOD /ui2/cl_json=>deserialize
            EXPORTING
              json         = <lfs_error_body>
*             pretty_name  = /ui2/cl_json=>pretty_mode-camel_case
              assoc_arrays = abap_true
            CHANGING
              data         = ls_error_body.

          DELETE ls_error_body-error-innererror-errordetails WHERE severity = 'warning'.

          IF ir_codes IS NOT INITIAL.
            DELETE ls_error_body-error-innererror-errordetails WHERE code IN ir_codes.
          ENDIF.

          IF ls_error_body-error-innererror-errordetails IS NOT INITIAL.
            ev_message = REDUCE #( INIT lv_message TYPE string FOR ls_detail IN ls_error_body-error-innererror-errordetails
                                   NEXT lv_message = COND #( WHEN lv_message IS NOT INITIAL
                                                             THEN |{ lv_message }, { ls_detail-message }|
                                                             ELSE ls_detail-message ) ).
          ENDIF.

        ENDIF.

        IF ev_message IS INITIAL.
          CALL METHOD io_catch_data->('GET_LONGTEXT') RECEIVING result = ev_message.
        ENDIF.
      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.

  ENDMETHOD.