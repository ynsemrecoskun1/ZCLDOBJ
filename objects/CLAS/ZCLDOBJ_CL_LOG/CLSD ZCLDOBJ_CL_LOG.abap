class-pool .
*"* class pool for class ZCLDOBJ_CL_LOG

*"* local type definitions
include ZCLDOBJ_CL_LOG================ccdef.

*"* class ZCLDOBJ_CL_LOG definition
*"* public declarations
  include ZCLDOBJ_CL_LOG================cu.
*"* protected declarations
  include ZCLDOBJ_CL_LOG================co.
*"* private declarations
  include ZCLDOBJ_CL_LOG================ci.
endclass. "ZCLDOBJ_CL_LOG definition

*"* macro definitions
include ZCLDOBJ_CL_LOG================ccmac.
*"* local class implementation
include ZCLDOBJ_CL_LOG================ccimp.

class ZCLDOBJ_CL_LOG implementation.
*"* method's implementations
  include methods.
endclass. "ZCLDOBJ_CL_LOG implementation
