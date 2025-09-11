  PRIVATE SECTION.
    METHODS: get_duration RETURNING VALUE(rv_time) LIKE sy-uzeit.
    DATA: mo_instance       TYPE REF TO zcldobj_cl_log,
          mt_log            TYPE TABLE OF zcldobj_a_log,
          mt_log_detail     TYPE TABLE OF zcldobj_a_logdet,
          mv_detail_index   TYPE int4 VALUE 0,
          mv_log_id         TYPE sysuuid_x16,
          mv_begin_datetime TYPE zcldobj_e_log_datetime.