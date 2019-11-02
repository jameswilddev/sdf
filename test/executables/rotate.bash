load "../framework/main"

executable_name=rotate
executable_help="rotate - rotates the geometry described by a sdf stream
  usage: [sdf stream] | rotate [options] | [consumer of sdf stream]
  options:
    -h, --help, /?: display this message
    -x [number], --x [number]: rotation around the x axis (degrees) (default: 0.000000)
    -y [number], --y [number]: rotation around the y axis (degrees) (default: 0.000000)
    -z [number], --z [number]: rotation around the z axis (degrees) (default: 0.000000)"

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
  check_successful "bin/rotate < test/sdf/empty.sdf | bin/sample" "inf"
}

@test "default" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 1.9 -y 4.5 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 3.1 -y 4.5 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 2.5 -y 3.9 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 2.5 -y 5.1 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 2.5 -y 4.5 -z 5.9" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate | bin/sample -x 2.5 -y 4.5 -z 7.1" "0.100000"
}

@test "x short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 1.9 -y 2.66434 -z 7.44321" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 3.1 -y 2.66434 -z 7.44321" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 2.5 -y 2.0847875 -z 7.28791" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 2.5 -y 3.243897 -z 7.5985" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 2.5 -y 2.81963 -z 6.863647" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 15 | bin/sample -x 2.5 -y 2.509055 -z 8.02276" "0.100000"
}

@test "x long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 1.9 -y 2.66434 -z 7.44321" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 3.1 -y 2.66434 -z 7.44321" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 2.5 -y 2.0847875 -z 7.28791" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 2.5 -y 3.243897 -z 7.5985" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 2.5 -y 2.81963 -z 6.863647" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 15 | bin/sample -x 2.5 -y 2.509055 -z 8.02276" "0.100000"
}

@test "y short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 3.517583 -y 4.5 -z 5.78676" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 4.676695 -y 4.5 -z 5.47618" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 4.09714 -y 3.9 -z 5.63147" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 4.09714 -y 5.1 -z 5.63147" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 3.941827 -y 4.5 -z 5.05192" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 15 | bin/sample -x 4.252452 -y 4.5 -z 6.21102" "0.100000"
}

@test "y long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 3.517583 -y 4.5 -z 5.78676" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 4.676695 -y 4.5 -z 5.47618" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 4.09714 -y 3.9 -z 5.63147" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 4.09714 -y 5.1 -z 5.63147" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 3.941827 -y 4.5 -z 5.05192" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 15 | bin/sample -x 4.252452 -y 4.5 -z 6.21102" "0.100000"
}

@test "z short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 0.670574 -y 4.83842 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 1.829683 -y 5.14901 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 1.405425 -y 4.41416 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 1.09484 -y 5.57327 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 1.25013 -y 4.99372 -z 5.9" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -z 15 | bin/sample -x 1.25013 -y 4.99372 -z 7.1" "0.100000"
}

@test "z long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 0.670574 -y 4.83842 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 1.829683 -y 5.14901 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 1.405425 -y 4.41416 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 1.09484 -y 5.57327 -z 6.5" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 1.25013 -y 4.99372 -z 5.9" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --z 15 | bin/sample -x 1.25013 -y 4.99372 -z 7.1" "0.100000"
}

@test "x y short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 3.199038 -y 2.00549 -z 7.20098" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 4.380809 -y 2.00549 -z 6.99261" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 3.7543 -y 1.44167 -z 6.8947" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 3.82559 -y 2.5693 -z 7.29889" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 3.692 -y 2.2107 -z 6.54155" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 | bin/sample -x 3.8878 -y 1.80027 -z 7.65205" "0.100000"
}

@test "x y long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 3.199038 -y 2.00549 -z 7.20098" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 4.380809 -y 2.00549 -z 6.99261" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 3.7543 -y 1.44167 -z 6.8947" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 3.82559 -y 2.5693 -z 7.29889" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 3.692 -y 2.2107 -z 6.54155" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 | bin/sample -x 3.8878 -y 1.80027 -z 7.65205" "0.100000"
}

@test "x z short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 1.3162 -y 2.42891 -z 7.64709" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 2.475312 -y 2.73949 -z 7.64709" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 2.041705 -y 2.0396 -z 7.44188" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 1.749827 -y 3.1288 -z 7.85231" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 1.84262 -y 2.78242 -z 7.08328" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -z 15 | bin/sample -x 1.94886 -y 2.38598 -z 8.21091" "0.100000"
}

@test "x z long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 1.3162 -y 2.42891 -z 7.64709" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 2.475312 -y 2.73949 -z 7.64709" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 2.041705 -y 2.0396 -z 7.44188" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 1.749827 -y 3.1288 -z 7.85231" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 1.84262 -y 2.78242 -z 7.08328" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --z 15 | bin/sample -x 1.94886 -y 2.38598 -z 8.21091" "0.100000"
}

@test "y z short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 1.732946 -y 5.12308 -z 6.07132" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 2.874446 -y 5.42895 -z 5.86294" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 2.458985 -y 4.69646 -z 5.96713" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 2.148395 -y 5.85557 -z 5.96713" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 2.20309 -y 5.24905 -z 5.37624" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -y 10 -z 15 | bin/sample -x 2.404305 -y 5.30298 -z 6.55802" "0.100000"
}

@test "y z long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 1.732946 -y 5.12308 -z 6.07132" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 2.874446 -y 5.42895 -z 5.86294" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 2.458985 -y 4.69646 -z 5.96713" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 2.148395 -y 5.85557 -z 5.96713" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 2.20309 -y 5.24905 -z 5.37624" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --y 10 --z 15 | bin/sample -x 2.404305 -y 5.30298 -z 6.55802" "0.100000"
}

@test "x y z short" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 2.570976 -y 2.76512 -z 7.20098" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 3.712478 -y 3.07099 -z 6.99261" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 3.25324 -y 2.36423 -z 6.8947" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 3.03021 -y 3.47188 -z 7.29889" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 2.994035 -y 3.09094 -z 6.54155" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate -x 20 -y 10 -z 15 | bin/sample -x 3.2893875 -y 2.74517 -z 7.65205" "0.100000"
}

@test "x y z long" {
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 2.570976 -y 2.76512 -z 7.20098" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 3.712478 -y 3.07099 -z 6.99261" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 3.25324 -y 2.36423 -z 6.8947" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 3.03021 -y 3.47188 -z 7.29889" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 2.994035 -y 3.09094 -z 6.54155" "0.100000"
  check_successful "bin/cuboid | bin/translate -x 2 -y 4 -z 6 | bin/rotate --x 20 --y 10 --z 15 | bin/sample -x 3.2893875 -y 2.74517 -z 7.65205" "0.100000"
}

@test "x validation" {
  number_parameter "rotate" "x" "x"
}

@test "y validation" {
  number_parameter "rotate" "y" "y"
}

@test "z validation" {
  number_parameter "rotate" "z" "z"
}