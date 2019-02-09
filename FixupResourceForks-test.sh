#!/usr/bin/env roundup

source "helpers.sh"

# FixupResourceForks-test.sh
#
# Test suite to confirm that FixupResourceForks works the way we expect

describe "FixupResourceForks" 

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
it_has_only_apple_double_file_before_fixup() {
  split_str_rsrc
  test -e "._${rsrc_file}" && test -z "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_makes_resource_fork_from_apple_double_file() {
  split_str_rsrc
  /System/Library/CoreServices/FixupResourceForks .
  test -n "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_makes_resource_fork_with_same_data_as_apple_double_file() {
  split_str_rsrc
  /System/Library/CoreServices/FixupResourceForks -nodelete .
  ( strings "._${rsrc_file}" | grep "${rsrc_str}" ) && ( strings "${rsrc_file}/..namedfork/rsrc" | grep "${rsrc_str}" )
}

it_retains_original_apple_double_file_if_nodelete_option_is_included() {
  split_str_rsrc
  /System/Library/CoreServices/FixupResourceForks -nodelete .
  test -e "._${rsrc_file}"
}

it_deletes_original_apple_double_file_if_nodelete_option_is_omitted() {
  split_str_rsrc
  /System/Library/CoreServices/FixupResourceForks .
  test ! -e "._${rsrc_file}"
}