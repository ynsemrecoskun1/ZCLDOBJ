  PROTECTED SECTION.
*    METHODS: set_log IMPORTING it_log TYPE tty_log,
*      get_log EXPORTING et_log TYPE tty_log,
*      set_log_detail IMPORTING it_log_det TYPE tty_log_detail,
*      get_log_detail EXPORTING et_log_det TYPE tty_log_detail,
*      set_detail_index IMPORTING iv_detail_index TYPE int4,
*      get_detail_index EXPORTING ev_detail_index TYPE int4,
*      set_log_id IMPORTING iv_log_id TYPE sysuuid_x16,
*      get_log_id EXPORTING ev_log_id TYPE sysuuid_x16.