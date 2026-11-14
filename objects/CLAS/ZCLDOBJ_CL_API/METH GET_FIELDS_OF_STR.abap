  METHOD get_fields_of_str.
    cl_abap_typedescr=>describe_by_name( EXPORTING  p_name      = iv_structure
                                         RECEIVING  p_descr_ref = DATA(lo_descr)
                                         EXCEPTIONS type_not_found = 1
                                                    OTHERS         = 2 ).
    IF sy-subrc <> 0 OR lo_descr IS NOT INSTANCE OF cl_abap_structdescr.
      RETURN.
    ENDIF.

    DATA(lt_components) = CAST cl_abap_structdescr( lo_descr )->get_components( ).
    rt_fields = VALUE #( FOR ls_component IN lt_components ( ls_component-name ) ).
  ENDMETHOD.