CLASS zcldobj_cl_amount_to_word DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_level TYPE p LENGTH 10 DECIMALS 2.

    CLASS-METHODS:
      amount_to_word IMPORTING iv_amount            TYPE string
                               iv_waers             TYPE waers
                     CHANGING  cv_level             TYPE ty_level OPTIONAL
                     RETURNING VALUE(rv_wordamount) TYPE string .