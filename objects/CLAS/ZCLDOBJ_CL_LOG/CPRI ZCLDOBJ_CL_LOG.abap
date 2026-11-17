  PRIVATE SECTION.
    METHODS: get_duration RETURNING VALUE(rv_time) LIKE sy-uzeit,
             "! Filtre ve kritiklik rengi için değerleri tek biçime getirir
             normalize_status IMPORTING iv_value        TYPE zcldobj_e_status
                              RETURNING VALUE(rv_value) TYPE zcldobj_e_status,
             normalize_type   IMPORTING iv_value        TYPE zcldobj_e_service_type
                              RETURNING VALUE(rv_value) TYPE zcldobj_e_service_type.
    DATA: mo_instance       TYPE REF TO zcldobj_cl_log,
          mv_header_created TYPE abap_boolean,
          mv_details_saved  TYPE int4 VALUE 0,
          mt_log            TYPE TABLE OF zcldobj_a_log,
          mt_log_detail     TYPE TABLE OF zcldobj_a_logdet,
          mv_detail_index   TYPE int4 VALUE 0,
          mv_log_id         TYPE sysuuid_x16,
          mv_begin_datetime TYPE zcldobj_e_log_datetime.