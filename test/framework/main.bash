load "../../submodules/bats-support/load"
load "../../submodules/bats-assert/load"
load "../framework/assertions"
load "../framework/help"
load "../framework/number_parameter"

setup() {
  mkdir -p temp
}

teardown() {
  rm -r temp
}
