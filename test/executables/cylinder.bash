load "../framework/main"

executable_name=cylinder
executable_help="cylinder - generates a cylinder along the z axis
  usage: cylinder [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -sxy [number], --size-xy [number]: size on x and y axes (diameter, millimeters) (default: 1.000000)
    -sz [number], --size-z [number]: size on z axis (length/height, millimeters) (default: 1.000000)
    -cxy, --center-xy: center on x and y axes
    -cz, --center-z: center on z axis"

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
  check_successful "bin/cylinder < test/sdf/empty.sdf | bin/sample" "0.207107"
}

@test "non-empty stdin" {
  check_failure "bin/cylinder < test/sdf/parameter_x.sdf" "unexpected stdin"
}

@test "parameter size xy" {
  number_parameter "cylinder" "sxy" "size-xy"
}

@test "parameter size z" {
  number_parameter "cylinder" "sz" "size-z"
}

@test "distances" {
  check_successful "bin/cylinder | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-xy | bin/sample -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-z | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-z | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 0.500000 -z 5.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -z 5.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder | bin/sample -x 0.500000 -y 0.500000 -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-xy | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-xy | bin/sample -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-z | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-z | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-z | bin/sample -x 0.500000 -y 0.500000 -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --center-xy --center-z | bin/sample -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 | bin/sample -x 0.500000 -y 0.500000 -z 5.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-xy | bin/sample -z 5.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 1.000000 -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -y 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 1.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-z | bin/sample -x 0.500000 -y 0.500000 -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x 0.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x -0.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x 0.000000 -y 0.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -x -0.000000 -y -0.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-z 5 --center-xy --center-z | bin/sample -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 1.500000 -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x -1.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x 0.000000 -y 1.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x -0.000000 -y -1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 1.500000 -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x -1.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x 0.000000 -y 1.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x -0.000000 -y -1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -x 1.500000 -y 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 | bin/sample -x 1.500000 -y 1.500000 -z 5.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.400000 -y 0.000000 -z 2.500000" "-0.100000" # - inside 0 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.400000 -y 0.000000 -z 2.500000" "-0.100000" # - inside 0 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.400000 -z 2.500000" "-0.100000" # + inside 0 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.400000 -z 2.500000" "-0.100000" # + inside 0 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.400000 -z 2.500000" "-0.100000" # 0 - inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.400000 -z 2.500000" "-0.100000" # 0 - inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.400000 -z 2.500000" "-0.100000" # 0 + inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.400000 -z 2.500000" "-0.100000" # 0 + inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.315570 -y 0.478828 -z 2.500000" "-0.100000" # + inside + inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.315570 -y 0.478828 -z 2.500000" "-0.100000" # + inside + inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.362347 -y 1.352296 -z 2.500000" "-0.100000" # + inside - inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.362347 -y 1.352296 -z 2.500000" "-0.100000" # + inside - inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.315570 -y -0.478828 -z 2.500000" "-0.100000" # - inside - inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.315570 -y -0.478828 -z 2.500000" "-0.100000" # - inside - inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.478828 -y -1.315570 -z 2.500000" "-0.100000" # - inside + inside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.478828 -y -1.315570 -z 2.500000" "-0.100000" # - inside + inside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.600000 -y 0.000000 -z 2.500000" "0.100000" # - outside 0 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.600000 -y 0.000000 -z 2.500000" "0.100000" # - outside 0 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.600000 -z 2.500000" "0.100000" # + outside 0 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.600000 -z 2.500000" "0.100000" # + outside 0 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.600000 -z 2.500000" "0.100000" # 0 - outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.600000 -z 2.500000" "0.100000" # 0 - outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.600000 -z 2.500000" "0.100000" # 0 + outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.600000 -z 2.500000" "0.100000" # 0 + outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.503508 -y 0.547232 -z 2.500000" "0.100000" # + outside + outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.503508 -y 0.547232 -z 2.500000" "0.100000" # + outside + outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.414110 -y 1.545481 -z 2.500000" "0.100000" # + outside - outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.414110 -y 1.545481 -z 2.500000" "0.100000" # + outside - outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.503508 -y -0.547232 -z 2.500000" "0.100000" # - outside - outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.503508 -y -0.547232 -z 2.500000" "0.100000" # - outside - outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.547232 -y -1.503508 -z 2.500000" "0.100000" # - outside + outside 0 short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.547232 -y -1.503508 -z 2.500000" "0.100000" # - outside + outside 0 long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -z 0.100000" "-0.100000" # 0 0 - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -z 0.100000" "-0.100000" # 0 0 - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -z -0.100000" "0.100000" # 0 0 - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -z -0.100000" "0.100000" # 0 0 - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.400000 -y 0.000000 -z 0.200000" "-0.100000" # - inside closer 0 - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.400000 -y 0.000000 -z 0.200000" "-0.100000" # - inside closer 0 - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.400000 -z 0.200000" "-0.100000" # + inside closer 0 - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.400000 -z 0.200000" "-0.100000" # + inside closer 0 - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.400000 -z 0.200000" "-0.100000" # 0 - inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.400000 -z 0.200000" "-0.100000" # 0 - inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.400000 -z 0.200000" "-0.100000" # 0 + inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.400000 -z 0.200000" "-0.100000" # 0 + inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.315570 -y 0.478828 -z 0.200000" "-0.100000" # + inside closer + inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.315570 -y 0.478828 -z 0.200000" "-0.100000" # + inside closer + inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.362347 -y 1.352296 -z 0.200000" "-0.100000" # + inside closer - inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.362347 -y 1.352296 -z 0.200000" "-0.100000" # + inside closer - inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.315570 -y -0.478828 -z 0.200000" "-0.100000" # - inside closer - inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.315570 -y -0.478828 -z 0.200000" "-0.100000" # - inside closer - inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.478828 -y -1.315570 -z 0.200000" "-0.100000" # - inside closer + inside closer - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.478828 -y -1.315570 -z 0.200000" "-0.100000" # - inside closer + inside closer - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.300000 -y 0.000000 -z 0.100000" "-0.100000" # - inside 0 - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.300000 -y 0.000000 -z 0.100000" "-0.100000" # - inside 0 - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.300000 -z 0.100000" "-0.100000" # + inside 0 - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.300000 -z 0.100000" "-0.100000" # + inside 0 - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.300000 -z 0.100000" "-0.100000" # 0 - inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.300000 -z 0.100000" "-0.100000" # 0 - inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.300000 -z 0.100000" "-0.100000" # 0 + inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.300000 -z 0.100000" "-0.100000" # 0 + inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.221600 -y 0.444626 -z 0.100000" "-0.100000" # + inside + inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.221600 -y 0.444626 -z 0.100000" "-0.100000" # + inside + inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.336465 -y 1.255704 -z 0.100000" "-0.100000" # + inside - inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.336465 -y 1.255704 -z 0.100000" "-0.100000" # + inside - inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.221600 -y -0.444626 -z 0.100000" "-0.100000" # - inside - inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.221600 -y -0.444626 -z 0.100000" "-0.100000" # - inside - inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.444626 -y -1.221600 -z 0.100000" "-0.100000" # - inside + inside - inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.444626 -y -1.221600 -z 0.100000" "-0.100000" # - inside + inside - inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.600000 -y 0.000000 -z 0.200000" "0.100000" # - outside 0 - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.600000 -y 0.000000 -z 0.200000" "0.100000" # - outside 0 - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.600000 -z 0.200000" "0.100000" # + outside 0 - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.600000 -z 0.200000" "0.100000" # + outside 0 - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.600000 -z 0.200000" "0.100000" # 0 - outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.600000 -z 0.200000" "0.100000" # 0 - outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.600000 -z 0.200000" "0.100000" # 0 + outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.600000 -z 0.200000" "0.100000" # 0 + outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.503508 -y 0.547232 -z 0.200000" "0.100000" # + outside + outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.503508 -y 0.547232 -z 0.200000" "0.100000" # + outside + outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.414110 -y 1.545481 -z 0.200000" "0.100000" # + outside - outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.414110 -y 1.545481 -z 0.200000" "0.100000" # + outside - outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.503508 -y -0.547232 -z 0.200000" "0.100000" # - outside - outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.503508 -y -0.547232 -z 0.200000" "0.100000" # - outside - outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.547232 -y -1.503508 -z 0.200000" "0.100000" # - outside + outside - inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.547232 -y -1.503508 -z 0.200000" "0.100000" # - outside + outside - inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.400000 -y 0.000000 -z -0.200000" "0.200000" # - inside 0 - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.400000 -y 0.000000 -z -0.200000" "0.200000" # - inside 0 - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.400000 -z -0.200000" "0.200000" # + inside 0 - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.400000 -z -0.200000" "0.200000" # + inside 0 - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.400000 -z -0.200000" "0.200000" # 0 - inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.400000 -z -0.200000" "0.200000" # 0 - inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.400000 -z -0.200000" "0.200000" # 0 + inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.400000 -z -0.200000" "0.200000" # 0 + inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.315570 -y 0.478828 -z -0.200000" "0.200000" # + inside + inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.315570 -y 0.478828 -z -0.200000" "0.200000" # + inside + inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.362347 -y 1.352296 -z -0.200000" "0.200000" # + inside - inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.362347 -y 1.352296 -z -0.200000" "0.200000" # + inside - inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.315570 -y -0.478828 -z -0.200000" "0.200000" # - inside - inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.315570 -y -0.478828 -z -0.200000" "0.200000" # - inside - inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.478828 -y -1.315570 -z -0.200000" "0.200000" # - inside + inside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.478828 -y -1.315570 -z -0.200000" "0.200000" # - inside + inside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.600000 -y 0.000000 -z -0.200000" "0.223607" # - outside 0 - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.600000 -y 0.000000 -z -0.200000" "0.223607" # - outside 0 - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.600000 -z -0.200000" "0.223607" # + outside 0 - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.600000 -z -0.200000" "0.223607" # + outside 0 - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.600000 -z -0.200000" "0.223607" # 0 - outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.600000 -z -0.200000" "0.223607" # 0 - outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.600000 -z -0.200000" "0.223607" # 0 + outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.600000 -z -0.200000" "0.223607" # 0 + outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.503508 -y 0.547232 -z -0.200000" "0.223607" # + outside + outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.503508 -y 0.547232 -z -0.200000" "0.223607" # + outside + outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.414110 -y 1.545481 -z -0.200000" "0.223607" # + outside - outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.414110 -y 1.545481 -z -0.200000" "0.223607" # + outside - outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.503508 -y -0.547232 -z -0.200000" "0.223607" # - outside - outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.503508 -y -0.547232 -z -0.200000" "0.223607" # - outside - outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.547232 -y -1.503508 -z -0.200000" "0.223607" # - outside + outside - outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.547232 -y -1.503508 -z -0.200000" "0.223607" # - outside + outside - outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -z 4.900000" "-0.100000" # 0 0 + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -z 4.900000" "-0.100000" # 0 0 + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -z 5.100000" "0.100000" # 0 0 + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -z 5.100000" "0.100000" # 0 0 + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.400000 -y 0.000000 -z 4.800000" "-0.100000" # - inside closer 0 + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.400000 -y 0.000000 -z 4.800000" "-0.100000" # - inside closer 0 + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.400000 -z 4.800000" "-0.100000" # + inside closer 0 + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.400000 -z 4.800000" "-0.100000" # + inside closer 0 + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.400000 -z 4.800000" "-0.100000" # 0 - inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.400000 -z 4.800000" "-0.100000" # 0 - inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.400000 -z 4.800000" "-0.100000" # 0 + inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.400000 -z 4.800000" "-0.100000" # 0 + inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.315570 -y 0.478828 -z 4.800000" "-0.100000" # + inside closer + inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.315570 -y 0.478828 -z 4.800000" "-0.100000" # + inside closer + inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.362347 -y 1.352296 -z 4.800000" "-0.100000" # + inside closer - inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.362347 -y 1.352296 -z 4.800000" "-0.100000" # + inside closer - inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.315570 -y -0.478828 -z 4.800000" "-0.100000" # - inside closer - inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.315570 -y -0.478828 -z 4.800000" "-0.100000" # - inside closer - inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.478828 -y -1.315570 -z 4.800000" "-0.100000" # - inside closer + inside closer + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.478828 -y -1.315570 -z 4.800000" "-0.100000" # - inside closer + inside closer + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.300000 -y 0.000000 -z 4.900000" "-0.100000" # - inside 0 + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.300000 -y 0.000000 -z 4.900000" "-0.100000" # - inside 0 + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.300000 -z 4.900000" "-0.100000" # + inside 0 + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.300000 -z 4.900000" "-0.100000" # + inside 0 + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.300000 -z 4.900000" "-0.100000" # 0 - inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.300000 -z 4.900000" "-0.100000" # 0 - inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.300000 -z 4.900000" "-0.100000" # 0 + inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.300000 -z 4.900000" "-0.100000" # 0 + inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.221600 -y 0.444626 -z 4.900000" "-0.100000" # + inside + inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.221600 -y 0.444626 -z 4.900000" "-0.100000" # + inside + inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.336465 -y 1.255704 -z 4.900000" "-0.100000" # + inside - inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.336465 -y 1.255704 -z 4.900000" "-0.100000" # + inside - inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.221600 -y -0.444626 -z 4.900000" "-0.100000" # - inside - inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.221600 -y -0.444626 -z 4.900000" "-0.100000" # - inside - inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.444626 -y -1.221600 -z 4.900000" "-0.100000" # - inside + inside + inside closer short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.444626 -y -1.221600 -z 4.900000" "-0.100000" # - inside + inside + inside closer long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.600000 -y 0.000000 -z 4.800000" "0.100000" # - outside 0 + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.600000 -y 0.000000 -z 4.800000" "0.100000" # - outside 0 + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.600000 -z 4.800000" "0.100000" # + outside 0 + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.600000 -z 4.800000" "0.100000" # + outside 0 + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.600000 -z 4.800000" "0.100000" # 0 - outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.600000 -z 4.800000" "0.100000" # 0 - outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.600000 -z 4.800000" "0.100000" # 0 + outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.600000 -z 4.800000" "0.100000" # 0 + outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.503508 -y 0.547232 -z 4.800000" "0.100000" # + outside + outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.503508 -y 0.547232 -z 4.800000" "0.100000" # + outside + outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.414110 -y 1.545481 -z 4.800000" "0.100000" # + outside - outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.414110 -y 1.545481 -z 4.800000" "0.100000" # + outside - outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.503508 -y -0.547232 -z 4.800000" "0.100000" # - outside - outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.503508 -y -0.547232 -z 4.800000" "0.100000" # - outside - outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.547232 -y -1.503508 -z 4.800000" "0.100000" # - outside + outside + inside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.547232 -y -1.503508 -z 4.800000" "0.100000" # - outside + outside + inside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.400000 -y 0.000000 -z 5.200000" "0.200000" # - inside 0 + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.400000 -y 0.000000 -z 5.200000" "0.200000" # - inside 0 + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.400000 -z 5.200000" "0.200000" # + inside 0 + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.400000 -z 5.200000" "0.200000" # + inside 0 + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.400000 -z 5.200000" "0.200000" # 0 - inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.400000 -z 5.200000" "0.200000" # 0 - inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.400000 -z 5.200000" "0.200000" # 0 + inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.400000 -z 5.200000" "0.200000" # 0 + inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.315570 -y 0.478828 -z 5.200000" "0.200000" # + inside + inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.315570 -y 0.478828 -z 5.200000" "0.200000" # + inside + inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.362347 -y 1.352296 -z 5.200000" "0.200000" # + inside - inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.362347 -y 1.352296 -z 5.200000" "0.200000" # + inside - inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.315570 -y -0.478828 -z 5.200000" "0.200000" # - inside - inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.315570 -y -0.478828 -z 5.200000" "0.200000" # - inside - inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.478828 -y -1.315570 -z 5.200000" "0.200000" # - inside + inside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.478828 -y -1.315570 -z 5.200000" "0.200000" # - inside + inside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.600000 -y 0.000000 -z 5.200000" "0.223607" # - outside 0 + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.600000 -y 0.000000 -z 5.200000" "0.223607" # - outside 0 + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.600000 -z 5.200000" "0.223607" # + outside 0 + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.600000 -z 5.200000" "0.223607" # + outside 0 + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.000000 -y -1.600000 -z 5.200000" "0.223607" # 0 - outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.000000 -y -1.600000 -z 5.200000" "0.223607" # 0 - outside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.000000 -y 1.600000 -z 5.200000" "0.223607" # 0 + outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.000000 -y 1.600000 -z 5.200000" "0.223607" # 0 + outside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 1.503508 -y 0.547232 -z 5.200000" "0.223606" # + outside + outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 1.503508 -y 0.547232 -z 5.200000" "0.223606" # + outside + outside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -0.414110 -y 1.545481 -z 5.200000" "0.223606" # + outside - outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -0.414110 -y 1.545481 -z 5.200000" "0.223606" # + outside - outside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x -1.503508 -y -0.547232 -z 5.200000" "0.223606" # - outside - outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x -1.503508 -y -0.547232 -z 5.200000" "0.223606" # - outside - outside + outside long
  check_successful "bin/cylinder -sxy 3 -sz 5 -cxy | bin/sample -x 0.547232 -y -1.503508 -z 5.200000" "0.223606" # - outside + outside + outside short
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy | bin/sample -x 0.547232 -y -1.503508 -z 5.200000" "0.223606" # - outside + outside + outside long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -x 1.500000 -y 1.500000 -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-z | bin/sample -x 1.500000 -y 1.500000 -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -x 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -x -1.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -x 0.000000 -y 1.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -x -0.000000 -y -1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -z -2.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --size-z 5 --center-xy --center-z | bin/sample -z 2.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 1.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 | bin/sample -x 1.500000 -y 1.500000 -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x -1.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x 0.000000 -y 1.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -x -0.000000 -y -1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-xy | bin/sample -z 1.000000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 3.000000 -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -y 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 3.000000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 1.500000 -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-z | bin/sample -x 1.500000 -y 1.500000 -z 0.500000" "0.000000" # 0 0 + long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x 1.500000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x -1.500000 -y 0.000000" "0.000000" # + 0 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x 0.000000 -y 1.500000" "0.000000" # 0 + 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -x -0.000000 -y -1.500000" "0.000000" # 0 - 0 long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -z -0.500000" "0.000000" # 0 0 - long
  check_successful "bin/cylinder --size-xy 3 --center-xy --center-z | bin/sample -z 0.500000" "0.000000" # 0 0 + long
}
