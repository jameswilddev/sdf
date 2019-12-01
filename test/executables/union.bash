load "../framework/main"

executable_name=union
executable_help="union - combines any number of sdf streams using a csg union
  usage: union [options, paths to sdf streams] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message"

@test "help (short name)" {
  test_help "-h"
}

@test "help (long name)" {
  test_help "--help"
}

@test "help (query)" {
  test_help "/?"
}

@test "empty stdin" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union < test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "non-empty stdin" {
  check_failure "${SDF_EXECUTABLE_PREFIX}union < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "no streams" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "one stream" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "one empty stream" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample" "inf"
}

@test "two streams (first empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams (second empty)" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to first" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "two streams closest to second" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) | ${SDF_EXECUTABLE_PREFIX}sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to first" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to second" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams closest to third" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to second" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (first empty) closest to third" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to first" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (second empty) closest to third" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) test/sdf/empty.sdf <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 15) | ${SDF_EXECUTABLE_PREFIX}sample -x 15.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to first" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 0.3 -y 0.5 -z 0.5" "-0.300000"
}

@test "three streams (third empty) closest to second" {
  check_successful "${SDF_EXECUTABLE_PREFIX}union <(${SDF_EXECUTABLE_PREFIX}cuboid) <(${SDF_EXECUTABLE_PREFIX}cuboid | ${SDF_EXECUTABLE_PREFIX}translate -x 10) test/sdf/empty.sdf | ${SDF_EXECUTABLE_PREFIX}sample -x 10.3 -y 0.5 -z 0.5" "-0.300000"
}
