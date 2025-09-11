managed with additional save implementation in class ZBP_I_PARAMETERVALUETABLE_S unique;
strict;
with draft;
define behavior for ZI_ParameterValueTable_S alias ParameterValueTaAll
draft table ZCLDOBJ_A_P_D_S
with unmanaged save
lock master total etag LastChangedAtMax
authorization master( global )
{
  field ( readonly )
   SingletonID;

  field ( notrigger )
   SingletonID,
   LastChangedAtMax;


  update;
  internal create;
  internal delete;

  draft action ( features : instance ) Edit;
  draft action Activate optimized;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare;

  association _ParameterValueTable { create ( features : instance ); with draft; }

}

define behavior for ZI_ParameterValueTable alias ParameterValueTable ##UNMAPPED_FIELD
persistent table ZCLDOBJ_A_PARAM
draft table ZCLDOBJ_A_PAR_D
lock dependent by _ParameterValueTaAll
authorization dependent by _ParameterValueTaAll
{
  field ( mandatory : create )
   Pname;

  field ( readonly )
   SingletonID;

  field ( readonly : update )
   Pname;

  field ( notrigger )
   SingletonID;


  update( features : global );
  delete( features : global );

  mapping for ZCLDOBJ_A_PARAM
  {
    Pname = PNAME;
    Value = VALUE;
    Description = DESCRIPTION;
  }

  association _ParameterValueTaAll { with draft; }

}