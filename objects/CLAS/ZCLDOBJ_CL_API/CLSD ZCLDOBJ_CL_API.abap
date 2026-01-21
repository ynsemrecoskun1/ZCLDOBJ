class-pool .
*"* class pool for class ZCLDOBJ_CL_API

*"* local type definitions
include ZCLDOBJ_CL_API================ccdef.

*"* class ZCLDOBJ_CL_API definition
*"* public declarations
  include ZCLDOBJ_CL_API================cu.
*"* protected declarations
  include ZCLDOBJ_CL_API================co.
*"* private declarations
  include ZCLDOBJ_CL_API================ci.
endclass. "ZCLDOBJ_CL_API definition

*"* macro definitions
include ZCLDOBJ_CL_API================ccmac.
*"* local class implementation
include ZCLDOBJ_CL_API================ccimp.

*"* test class
include ZCLDOBJ_CL_API================ccau.

class ZCLDOBJ_CL_API implementation.
*"* method's implementations
  include methods.
endclass. "ZCLDOBJ_CL_API implementation
