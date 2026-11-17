  METHOD normalize_type.
    " Inbound / Outbound biçimi (ilk harf büyük, kalanı küçük)
    IF strlen( condense( iv_value ) ) = 0.
      RETURN.
    ENDIF.
    DATA(lv_text) = condense( iv_value ).
    rv_value = |{ to_upper( substring( val = lv_text len = 1 ) ) }{ to_lower( substring( val = lv_text off = 1 ) ) }|.
  ENDMETHOD.