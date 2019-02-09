#!/usr/bin/env roundup

source "helpers.sh"

# SplitForks-test.sh
#
# Test suite to confirm that SplitForks works the way we expect

describe "SplitForks"

# setup & teardown
before() {
  touch "${rsrc_file}"
}

after() {
  if test -e "${rsrc_file}"; then rm "${rsrc_file}"; fi
  if test -e "${rsrc_file}.r"; then rm "${rsrc_file}.r"; fi
  if test -e "._${rsrc_file}"; then rm "._${rsrc_file}"; fi
}

# test cases
it_makes_apple_double_file_from_a_valid_resource_fork() {
  make_str_rsrc
  SplitForks "${rsrc_file}"
  test -e "._${rsrc_file}"
}

it_makes_apple_double_file_containing_same_data_as_resource_fork() {
  make_str_rsrc
  SplitForks "${rsrc_file}"
  ( strings "${rsrc_file}/..namedfork/rsrc" | grep "${rsrc_str}" ) && ( strings "._${rsrc_file}" | grep "${rsrc_str}" )
}

it_retains_original_resource_fork_if_s_option_is_omitted() {
  make_str_rsrc
  SplitForks "${rsrc_file}"
  test -n "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_strips_original_resource_fork_if_s_option_is_included() {
  make_str_rsrc
  SplitForks -s "${rsrc_file}"
  test -z "$(cat "${rsrc_file}/..namedfork/rsrc")"
}