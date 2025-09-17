class-pool .
*"* class pool for class ZTEST1

*"* local type definitions
include ZTEST1========================ccdef.

*"* class ZTEST1 definition
*"* public declarations
  include ZTEST1========================cu.
*"* protected declarations
  include ZTEST1========================co.
*"* private declarations
  include ZTEST1========================ci.
endclass. "ZTEST1 definition

*"* macro definitions
include ZTEST1========================ccmac.
*"* local class implementation
include ZTEST1========================ccimp.

*"* test class
include ZTEST1========================ccau.

class ZTEST1 implementation.
*"* method's implementations
  include methods.
endclass. "ZTEST1 implementation
