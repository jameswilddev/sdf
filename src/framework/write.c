#include <stdio.h>
#include <fcntl.h>
#include "fail.h"
#include "types.h"
#include "write.h"

#ifdef _WIN32
  static sdf_boolean_t sdf__stdout_binary = SDF_BOOLEAN_FALSE;
#endif

static void sdf__set_stdout_binary(void) {
  #ifdef _WIN32
    if (sdf__stdout_binary) {
      return;
    }

    if (_setmode(_fileno(stdout), _O_BINARY) == -1) {
      sdf_fail("failed to set stdout to binary mode");
    }

    sdf__stdout_binary = SDF_BOOLEAN_TRUE;
  #endif
}

#define SDF_WRITE(type)                                                    \
  void sdf_write_##type(                                                   \
    sdf_##type##_t value,                                                  \
    const char * what                                                      \
  ) {                                                                      \
    sdf_##type##_t copy = value;                                           \
    sdf_types_##type##_swap_endianness(&copy);                             \
    sdf__set_stdout_binary();                                              \
    if (!fwrite(&copy, sizeof(sdf_##type##_t), 1, stdout)) {               \
      sdf_fail("failed to write %s (ferror: %d)\n", what, ferror(stdout)); \
    }                                                                      \
  }

SDF_WRITE(u16)
SDF_WRITE(number)
