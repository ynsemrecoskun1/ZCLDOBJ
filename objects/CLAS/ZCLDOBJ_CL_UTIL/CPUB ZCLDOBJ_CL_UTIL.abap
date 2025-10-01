CLASS zcldobj_cl_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_user  TYPE c LENGTH 12,
           ty_tcode TYPE c LENGTH 20,
           ty_ucomm TYPE c LENGTH 70.
    CLASS-METHODS:
      get_user RETURNING VALUE(rv_user) TYPE ty_user,

      get_tcode RETURNING VALUE(rv_tcode) TYPE ty_tcode,

      get_ucomm RETURNING VALUE(rv_tcode) TYPE ty_ucomm.