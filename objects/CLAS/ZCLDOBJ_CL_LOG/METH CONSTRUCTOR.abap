  METHOD constructor.
*    IF mo_instance IS NOT BOUND.
*      mo_instance = NEW #( ).
*    ENDIF.



    TRY.
        IF iv_logid IS INITIAL.
          mv_log_id = cl_system_uuid=>create_uuid_x16_static( ).
        ELSE.

          SELECT MAX( detail_id ) AS max_detail_id
            FROM zcldobj_a_logdet WITH PRIVILEGED ACCESS
           WHERE log_id = @iv_logid
            INTO @mv_detail_index.

          SELECT *
            FROM zcldobj_a_log WITH PRIVILEGED ACCESS
           WHERE log_id = @iv_logid
            INTO TABLE @mt_log.

          mv_log_id = iv_logid.

        ENDIF.
      CATCH cx_uuid_error.
    ENDTRY.
    GET TIME STAMP FIELD mv_begin_datetime.
  ENDMETHOD.