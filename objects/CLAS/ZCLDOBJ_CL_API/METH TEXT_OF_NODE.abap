  METHOD text_of_node.
    IF ir_node IS NOT BOUND.
      RETURN.
    ENDIF.

    ASSIGN ir_node->* TO FIELD-SYMBOL(<value>).
    DATA(lo_descr) = cl_abap_typedescr=>describe_by_data( <value> ).

    CASE lo_descr->kind.
      WHEN cl_abap_typedescr=>kind_elem.
        rv_text = |{ <value> }|.
      WHEN cl_abap_typedescr=>kind_struct.
        ASSIGN COMPONENT 'VALUE' OF STRUCTURE <value> TO FIELD-SYMBOL(<inner>).
        IF sy-subrc = 0
           AND cl_abap_typedescr=>describe_by_data( <inner> )->type_kind = cl_abap_typedescr=>typekind_dref.
          rv_text = text_of_node( <inner> ).
        ENDIF.
    ENDCASE.
  ENDMETHOD.