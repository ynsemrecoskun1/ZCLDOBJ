  METHOD get_fields_of_str.
    DATA: lo_return_descr TYPE REF TO cl_abap_structdescr.
    TRY.
        lo_return_descr ?= cl_abap_structdescr=>describe_by_name( iv_structure ).
        DATA(lt_components) = lo_return_descr->get_components( ).
        rt_fields = VALUE #( FOR ls_component IN lt_components ( ls_component-name ) ).
      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.