  METHOD amount_to_word.

    TYPES: BEGIN OF str_d,
             num   TYPE int8,
             word1 TYPE string,
             word2 TYPE string,
           END OF str_d.

    TYPES: BEGIN OF str_d2,
             num  TYPE int8,
             word TYPE string,
           END OF str_d2.

    DATA: ls_h  TYPE str_d,
          ls_k  TYPE str_d,
          ls_m  TYPE str_d,
          ls_b  TYPE str_d,
          ls_t  TYPE str_d,
          ls_kt TYPE str_d,
          ls_o  TYPE str_d,
          lt_d  TYPE TABLE OF str_d2.

    DATA: lv_int       TYPE int8,
          lv_int1      TYPE int8,
          lv_int2      TYPE int8,
          lv_dec_s     TYPE string,
          lv_dec       TYPE int8,
          lv_wholenum  TYPE int8,
          lv_inp1      TYPE string,
          lv_inp2      TYPE string,
          lv_dec_words TYPE c LENGTH 255,
          lv_fraction  TYPE c LENGTH 30.

    IF iv_amount IS INITIAL.
      RETURN.
    ENDIF.

    ls_h-num = 100.
    ls_h-word1 = 'yüz'.
    ls_h-word2 = 'yüz'.

    ls_k-num = ls_h-num * 10.
    ls_k-word1 = 'Bin'.
    ls_k-word2 = 'Bin'.

    ls_m-num = ls_k-num * 1000.
    ls_m-word1 = 'Milyon'.
    ls_m-word2 = 'Milyon'.

    ls_b-num = ls_m-num * 1000.
    ls_b-word1 = 'Milyar'.
    ls_b-word2 = 'Milyar'.

    ls_t-num = ls_b-num * 1000.
    ls_t-word1 = 'Trilyon'.
    ls_t-word2 = 'Trilyon'.

    ls_kt-num = ls_t-num * 1000.
    ls_kt-word1 = 'Katrilyon'.
    ls_kt-word2 = 'Katrilyon'.

*    Use the following if this is required in Lakhs/Crores instead of Millions/Billions
*
*    ls_h-num = 100.
*    ls_h-word1 = 'Hundred'.
*    ls_h-word2 = 'Hundred and'.

*    ls_k-num = ls_h-num * 10.
*    ls_k-word1 = 'Thousand'.
*    ls_k-word2 = 'Thousand'.

*    ls_m-num = ls_k-num * 100.
*    ls_m-word1 = 'Lakh'.
*    ls_m-word2 = 'Lakh'.

*    ls_b-num = ls_m-num * 100.
*    ls_b-word1 = 'Crore'.
*    ls_b-word2 = 'Crore'.

    SPLIT iv_amount AT '.' INTO lv_inp1 lv_inp2.

    lv_int = lv_inp1.
    lv_wholenum = lv_int.

    IF cv_level IS INITIAL.
      IF lv_inp2 IS NOT INITIAL.
        CONDENSE lv_inp2.
        lv_dec_s   = lv_inp2.
        lv_dec     = lv_inp2.
      ENDIF.
    ENDIF.
    cv_level = cv_level + 1.

    lt_d = VALUE #( ( num = 0 word = 'Sıfır' )
                    ( num = 1 word = 'Bir' )
                    ( num = 2 word = 'İki' )
                    ( num = 3 word = 'Üç' )
                    ( num = 4 word = 'Dört' )
                    ( num = 5 word = 'Beş' )
                    ( num = 6 word = 'Altı' )
                    ( num = 7 word = 'Yedi' )
                    ( num = 8 word = 'Sekiz' )
                    ( num = 9 word = 'Dokuz' )
                    ( num = 10 word = 'On' )
                    ( num = 20 word = 'Yirmi' )
                    ( num = 30 word = 'Otuz' )
                    ( num = 40 word = 'Kırk' )
                    ( num = 50 word = 'Elli' )
                    ( num = 60 word = 'Altmış' )
                    ( num = 70 word = 'Yetmiş' )
                    ( num = 80 word = 'Seksen' )
                    ( num = 90 word = 'Doksan' )
     ).

    SELECT SINGLE currencyshortname FROM i_currencytext WITH PRIVILEGED ACCESS
    WHERE currency = @iv_waers
      AND language = 'T'
    INTO @DATA(lv_currshname).

*   Whole Number converted to Words
    IF lt_d IS NOT INITIAL.
      IF lv_int <= 10.
        READ TABLE lt_d REFERENCE INTO DATA(ls_d) WITH KEY num = lv_int.
        IF sy-subrc IS INITIAL.
          rv_wordamount = |{ ls_d->word  WIDTH = strlen( ls_d->word ) }|.
        ENDIF.
      ELSEIF lv_int < 100 AND lv_int > 10.
        DATA(mod) = lv_int MOD 10.
        DATA(floor) = floor( lv_int DIV 10 ).
        IF mod = 0.
          READ TABLE lt_d REFERENCE INTO ls_d WITH KEY num = lv_int.
          IF sy-subrc IS INITIAL.
            rv_wordamount = ls_d->word.
          ENDIF.
        ELSE.
          READ TABLE lt_d REFERENCE INTO ls_d WITH KEY num = floor * 10.
          IF sy-subrc IS INITIAL.
            DATA(pos1) = ls_d->word.
          ENDIF.

          READ TABLE lt_d REFERENCE INTO ls_d WITH KEY num = mod.
          IF sy-subrc IS INITIAL.
            DATA(pos2) = ls_d->word.
          ENDIF.
          rv_wordamount = |{ pos1 WIDTH = strlen( pos1 ) } | && |{ pos2 WIDTH = strlen( pos2 ) }|.
        ENDIF.
      ELSE.
        IF lv_int  < ls_k-num.
          ls_o = ls_h.
        ELSEIF lv_int < ls_m-num.
          ls_o = ls_k.
        ELSEIF lv_int < ls_b-num.
          ls_o = ls_m.
        ELSEIF lv_int < ls_t-num.
          ls_o = ls_b.
        ELSEIF lv_int < ls_kt-num.
          ls_o = ls_t.
        ELSE.
          ls_o = ls_kt.
        ENDIF.
        mod = lv_int MOD ls_o-num.
        floor = floor( iv_amount DIV ls_o-num ).
        lv_inp1 = floor.
        lv_inp2 = mod.

        IF mod = 0.
          DATA(output2) = zcldobj_cl_amount_to_word=>amount_to_word( EXPORTING iv_amount  = lv_inp1
                                                                              iv_waers   = iv_waers
                                                                     CHANGING cv_level = cv_level ).

          rv_wordamount = COND #( WHEN ls_o-word1 = 'yüz' AND output2 = 'Bir'
                                  THEN |Yüz|
                                  WHEN ls_o-word1 = 'yüz' AND output2 <> 'Bir'
                                  THEN |{ output2 WIDTH = strlen( output2 ) }| && |{ ls_o-word1 WIDTH = strlen( ls_o-word1 ) }|
                                  WHEN ls_o-word1 = 'Bin' AND output2 = 'Bir'
                                  THEN |Bin|
                                  ELSE |{ output2 WIDTH = strlen( output2 ) } | && |{ ls_o-word1 WIDTH = strlen( ls_o-word1 ) }| ).

        ELSE.
          output2 = zcldobj_cl_amount_to_word=>amount_to_word( EXPORTING iv_amount = lv_inp1
                                                                    iv_waers   = iv_waers
                                                          CHANGING  cv_level  = cv_level ).
          DATA(output3) = zcldobj_cl_amount_to_word=>amount_to_word( EXPORTING iv_amount  = lv_inp2
                                                                          iv_waers   = iv_waers
                                                                CHANGING  cv_level = cv_level ).

          rv_wordamount = COND #( WHEN ls_o-word2 = 'yüz' AND output2 = 'Bir'
                                  THEN |Yüz | && |{ output3 WIDTH = strlen( output3 ) }|
                                  WHEN ls_o-word2 = 'yüz' AND output2 <> 'Bir'
                                  THEN |{ output2 WIDTH = strlen( output2 ) }| && |{ ls_o-word2 WIDTH = strlen( ls_o-word2 ) } | && |{ output3 WIDTH = strlen( output3 ) }|
                                  WHEN ls_o-word2 = 'Bin' AND output2 = 'Bir'
                                  THEN |Bin | && |{ output3 WIDTH = strlen( output3 ) }|
                                  ELSE |{ output2 WIDTH = strlen( output2 ) } | && |{ ls_o-word2 WIDTH = strlen( ls_o-word2 ) } | && |{ output3 WIDTH = strlen( output3 ) }| ).
        ENDIF.
      ENDIF.

      cv_level = cv_level - 1.
      IF cv_level IS INITIAL.
*       "Dollars" is base monetary unit used in this sample,
*       but this could change as per the currency of the scenario.
*       It must be ensured that relative fractional monetary unit
*       shall be updated later in the code relative to the base unit
        rv_wordamount = |{ rv_wordamount WIDTH = strlen( rv_wordamount ) } { lv_currshname }|.
        IF lv_dec <= 10.
          READ TABLE lt_d REFERENCE INTO DATA(ls_d2) WITH KEY num = lv_dec.
          IF sy-subrc = 0.
            lv_dec_words = |{ ls_d2->word WIDTH = strlen( ls_d2->word ) }|.
          ENDIF.
        ELSEIF lv_dec < 100 AND lv_dec > 10.
          DATA(mod1) = lv_dec MOD 10.
          DATA(floor1) = floor( lv_dec DIV 10 ).
          IF mod1 = 0.
            READ TABLE lt_d REFERENCE INTO ls_d2 WITH KEY num = lv_dec.
            IF sy-subrc = 0.
              lv_dec_words = ls_d2->word.
            ENDIF.
          ELSE.
            READ TABLE lt_d REFERENCE INTO ls_d2 WITH KEY num = floor1 * 10.
            IF sy-subrc = 0.
              DATA(pos1_d) = ls_d2->word.
            ENDIF.
            READ TABLE lt_d REFERENCE INTO ls_d2 WITH KEY num = mod1.
            IF sy-subrc = 0.
              DATA(pos2_d) = ls_d2->word.
            ENDIF.
            IF pos1_d IS NOT INITIAL AND pos2_d IS NOT INITIAL.
              lv_dec_words = |{ pos1_d WIDTH = strlen( pos1_d ) } | && |{ pos2_d WIDTH = strlen( pos2_d ) }|.
            ENDIF.
          ENDIF.
        ENDIF.
*       Since "Dollars" was used for base monetary unit, "Cents"
*       has been used as fractional monetary unit in the code below
*       This can be handled dynamically as well based on the requirement
        CASE iv_waers.
          WHEN 'TRY'.
            lv_fraction = 'Kuruş'.
          WHEN 'RUB'.
            lv_fraction = 'Kopek'.
          WHEN 'GBP'.
            lv_fraction = 'Pence'.
          WHEN OTHERS.
            lv_fraction = 'Cents'.
        ENDCASE.
        rv_wordamount = |{ rv_wordamount WIDTH = strlen( rv_wordamount ) } { lv_dec_words WIDTH = strlen( lv_dec_words ) } { lv_fraction }|.
      ENDIF.
      RETURN.
    ENDIF.

  ENDMETHOD.