  METHOD deserialize_errors.
    CLEAR: ev_message, ev_statu, et_messages.

    et_messages = get_error_messages( io_catch_data = io_catch_data
                                      ir_codes      = ir_codes ).

    ev_message = concat_lines_of( table = VALUE string_table( FOR ls_message IN et_messages ( ls_message-message ) )
                                  sep   = `, ` ).
    IF ev_message IS NOT INITIAL.
      ev_statu = 'E'.
    ENDIF.
  ENDMETHOD.