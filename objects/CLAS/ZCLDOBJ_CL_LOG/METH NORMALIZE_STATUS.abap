  METHOD normalize_status.
    " S/W/E büyük harf; tanımsız değerler olduğu gibi bırakılır
    rv_value = to_upper( iv_value ).
  ENDMETHOD.