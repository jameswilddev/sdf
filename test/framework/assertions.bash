function stdout_only {
  "$@" 2>/dev/null
}

function stderr_only {
  "$@" 1>/dev/null
}

function check_stdout {
  run stdout_only $1
  assert_output ("$2" $TEXT_PREPROCESSOR)
}

function check_stderr {
  run stderr_only $1
  assert_output ("$2" $TEXT_PREPROCESSOR)
}

function check_exit_successful {
  run $1
  assert_success
}

function check_successful {
  check_exit_successful "$1"
  check_stdout "$1" "$2"
}
