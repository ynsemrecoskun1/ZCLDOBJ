  METHOD constructor.
    TRY.
        " Create log object
        mo_log = cl_bali_log=>create( ).

        " Create and set header
        DATA(lo_header) = cl_bali_header_setter=>create( object      = iv_object
                                                         subobject   = iv_subobject
                                                         external_id = cl_system_uuid=>create_uuid_c32_static( )
        )->set_expiry( expiry_date       = CONV d( cl_abap_context_info=>get_system_date( ) + 7 )
                       keep_until_expiry = abap_true ).

        mo_log->set_header( lo_header ).

      CATCH cx_bali_runtime INTO DATA(lo_root).

      CATCH cx_uuid_error INTO DATA(lo_uuid).
    ENDTRY.

  ENDMETHOD.