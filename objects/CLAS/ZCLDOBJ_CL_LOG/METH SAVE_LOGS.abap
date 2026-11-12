  METHOD save_logs.
    DATA lt_log_create  TYPE TABLE FOR CREATE zcldobj_r_log.
    DATA lt_log_update  TYPE TABLE FOR UPDATE zcldobj_r_log.
    DATA lt_item_create TYPE TABLE FOR CREATE zcldobj_r_log\_item.
    DATA ls_item_create LIKE LINE OF lt_item_create.
    DATA lt_item_target LIKE ls_item_create-%target.
    DATA lv_exists      TYPE abap_bool.
    DATA lv_cid_log     TYPE abp_behv_cid.

    lv_cid_log = |LOG_{ mv_log_id }|.

    SELECT SINGLE @abap_true
      FROM zcldobj_a_log WITH PRIVILEGED ACCESS
     WHERE log_id = @mv_log_id
      INTO @lv_exists.

    IF mt_log IS NOT INITIAL.
      IF lv_exists = abap_true.
        APPEND VALUE #( %key-LogId      = mv_log_id
                         LogDatetime     = mt_log[ 1 ]-log_datetime
                         ServiceName     = mt_log[ 1 ]-service_name
                         ServiceType     = mt_log[ 1 ]-service_type
                         TriggerType     = mt_log[ 1 ]-trigger_type
                         RequestPayload  = mt_log[ 1 ]-request_payload
                         ResponsePayload = mt_log[ 1 ]-response_payload
                         Status          = mt_log[ 1 ]-status
                         ErrorMessage    = mt_log[ 1 ]-error_message
                         Duration        = mt_log[ 1 ]-duration )
               TO lt_log_update.
      ELSE.
        APPEND VALUE #( %cid            = lv_cid_log
                         LogId           = mv_log_id
                         LogDatetime     = mt_log[ 1 ]-log_datetime
                         ServiceName     = mt_log[ 1 ]-service_name
                         ServiceType     = mt_log[ 1 ]-service_type
                         TriggerType     = mt_log[ 1 ]-trigger_type
                         RequestPayload  = mt_log[ 1 ]-request_payload
                         ResponsePayload = mt_log[ 1 ]-response_payload
                         Status          = mt_log[ 1 ]-status
                         ErrorMessage    = mt_log[ 1 ]-error_message
                         Duration        = mt_log[ 1 ]-duration )
               TO lt_log_create.
      ENDIF.
    ENDIF.

    IF mt_log_detail IS NOT INITIAL.
      LOOP AT mt_log_detail ASSIGNING FIELD-SYMBOL(<ls_detail>).
        APPEND VALUE #( %cid          = |LOGDET_{ <ls_detail>-log_id }_{ <ls_detail>-detail_id }|
                         LogId         = <ls_detail>-log_id
                         DetailId      = <ls_detail>-detail_id
                         StepName      = <ls_detail>-step_name
                         StepDatetime  = <ls_detail>-step_datetime
                         StepStatus    = <ls_detail>-step_status
                         StepErrorMsg  = <ls_detail>-step_error_msg )
               TO lt_item_target.
      ENDLOOP.

      IF lv_exists = abap_true.
        APPEND VALUE #( %key-LogId = mv_log_id
                         %target   = lt_item_target )
               TO lt_item_create.
      ELSE.
        APPEND VALUE #( %cid_ref = lv_cid_log
                         %target = lt_item_target )
               TO lt_item_create.
      ENDIF.
    ENDIF.

    MODIFY ENTITIES OF zcldobj_r_log
      ENTITY log
        CREATE FIELDS ( LogId LogDatetime ServiceName ServiceType TriggerType
                         RequestPayload ResponsePayload Status ErrorMessage Duration )
          WITH lt_log_create
        UPDATE FIELDS ( LogDatetime ServiceName ServiceType TriggerType
                         RequestPayload ResponsePayload Status ErrorMessage Duration )
          WITH lt_log_update
        CREATE BY \_Item
          FIELDS ( LogId DetailId StepName StepDatetime StepStatus StepErrorMsg )
          WITH lt_item_create
      FAILED   DATA(ls_failed)
      REPORTED DATA(ls_reported).

    IF ls_failed-log IS INITIAL AND ls_failed-logdetail IS INITIAL.
      IF iv_behavior IS INITIAL.
        COMMIT ENTITIES
          RESPONSE OF zcldobj_r_log
          FAILED   DATA(ls_commit_failed)
          REPORTED DATA(ls_commit_reported).
      ENDIF.
    ELSE.
      IF iv_behavior IS INITIAL.
        ROLLBACK ENTITIES.
      ENDIF.
    ENDIF.
  ENDMETHOD.