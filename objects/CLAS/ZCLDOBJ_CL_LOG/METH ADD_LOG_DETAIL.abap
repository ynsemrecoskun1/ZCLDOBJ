  METHOD add_log_detail.
    mv_detail_index += 1.

    APPEND INITIAL LINE TO mt_log_detail ASSIGNING FIELD-SYMBOL(<lfs_log_detail>).
    <lfs_log_detail>               = CORRESPONDING #( is_log_detail ).
    <lfs_log_detail>-log_id        = mv_log_id.
    <lfs_log_detail>-detail_id     = mv_detail_index.
    GET TIME STAMP FIELD <lfs_log_detail>-step_datetime.

*    <lfs_log_detail>-step_datetime = get_datetime_turkey( ).

  ENDMETHOD.