#!/usr/bin/env roundup

source "helpers.sh"

# Rez-test.sh
#
# Test suite to confirm that Rez works the way we expect

describe "Rez"

# setup & teardown
before() {
  touch "${rsrc_file}"
}

after() {
  if test -e "${rsrc_file}"; then rm "${rsrc_file}"; fi
  if test -e "${rsrc_file}.r"; then rm "${rsrc_file}.r"; fi
}

# test cases
it_new_file_has_no_resource_fork() {
  test -z "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_makes_a_resource_fork_when_none_exists() {
  make_str_rsrc
  test -n "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_does_not_create_an_apple_double_resource_fork() {
  make_str_rsrc
  test ! -e "._${rsrc_file}"
}

it_makes_a_string_resource_given_a_valid_dot_r_file() {
  make_str_rsrc
  strings "${rsrc_file}/..namedfork/rsrc" | grep "${rsrc_str}"
  test $? -eq 0
}