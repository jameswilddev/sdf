#ifndef SDF_OPCODE_H
#define SDF_OPCODE_H

#include "types.h"
#include "primitive.h"

typedef sdf_u16_t sdf_opcode_t;

typedef sdf_u8_t sdf_opcode_id_t;
#define SDF_OPCODE_ID_MAX SDF_U8_MAX
#define SDF_OPCODE_ID_RANGE SDF_U8_RANGE

typedef sdf_u8_t sdf_opcode_arity_t;
#define SDF_OPCODE_ARITY_MAX 3

#define SDF_OPCODE_NOT 0x5000
#define SDF_OPCODE_AND 0x5400
#define SDF_OPCODE_OR 0x5401
#define SDF_OPCODE_EQUAL 0x5402
#define SDF_OPCODE_NOT_EQUAL 0x5403
#define SDF_OPCODE_CONDITIONAL_BOOLEAN 0x5500
#define SDF_OPCODE_CONDITIONAL_NUMBER 0x5A00
#define SDF_OPCODE_GREATER_THAN 0x6800
#define SDF_OPCODE_PARAMETER(id) (0x8000 + id)
#define SDF_OPCODE_PARAMETER_MIN SDF_OPCODE_PARAMETER(0)
#define SDF_OPCODE_PARAMETER_MAX SDF_OPCODE_PARAMETER(SDF_U8_MAX)
#define SDF_OPCODE_NEGATE 0xA000
#define SDF_OPCODE_SINE 0xA001
#define SDF_OPCODE_COSINE 0xA002
#define SDF_OPCODE_TANGENT 0xA003
#define SDF_OPCODE_ARC_SINE 0xA004
#define SDF_OPCODE_ARC_COSINE 0xA005
#define SDF_OPCODE_ARC_TANGENT 0xA006
#define SDF_OPCODE_HYPERBOLIC_SINE 0xA007
#define SDF_OPCODE_HYPERBOLIC_COSINE 0xA008
#define SDF_OPCODE_HYPERBOLIC_TANGENT 0xA009
#define SDF_OPCODE_HYPERBOLIC_ARC_SINE 0xA00A
#define SDF_OPCODE_HYPERBOLIC_ARC_COSINE 0xA00B
#define SDF_OPCODE_HYPERBOLIC_ARC_TANGENT 0xA00C
#define SDF_OPCODE_ABSOLUTE 0xA00D
#define SDF_OPCODE_SQUARE_ROOT 0xA00E
#define SDF_OPCODE_FLOOR 0xA00F
#define SDF_OPCODE_CEILING 0xA010
#define SDF_OPCODE_NATURAL_LOGARITHM 0xA011
#define SDF_OPCODE_LOGARITHM_10 0xA012
#define SDF_OPCODE_NATURAL_POWER 0xA013
#define SDF_OPCODE_ADD 0xA800
#define SDF_OPCODE_SUBTRACT 0xA801
#define SDF_OPCODE_MULTIPLY 0xA802
#define SDF_OPCODE_DIVIDE 0xA803
#define SDF_OPCODE_POW 0xA804
#define SDF_OPCODE_MODULO 0xA805
#define SDF_OPCODE_ARC_TANGENT_2 0xA806

sdf_primitive_t sdf_opcode_result(
  sdf_opcode_t opcode
);

sdf_primitive_t sdf_opcode_parameter_a(
  sdf_opcode_t opcode
);

sdf_primitive_t sdf_opcode_parameter_b(
  sdf_opcode_t opcode
);

sdf_primitive_t sdf_opcode_parameter_c(
  sdf_opcode_t opcode
);

sdf_opcode_arity_t sdf_opcode_arity(
  sdf_opcode_t opcode
);

sdf_opcode_id_t sdf_opcode_id(
  sdf_opcode_t opcode
);

#endif
