#!/usr/bin/env roundup

# Rez-test.sh
#
# Test suite to confirm that Rez works the way we expect

describe "Rez"

rsrc_file="Test"
rsrc_str="Resource String"

before() {
  touch "${rsrc_file}"
}

after() {
  if test -e "${rsrc_file}"; then rm "${rsrc_file}"; fi
  if test -e "${rsrc_file}.r"; then rm "${rsrc_file}.r"; fi
}

make_str_rsrc() {
  cat << EOM > "${rsrc_file}.r"
resource 'STR ' (128) {
  "${rsrc_str}"
};
EOM
  Rez -F Carbon Carbon.r "${rsrc_file}.r" -o "${rsrc_file}"
}

it_new_file_has_no_resource_fork() {
  test -z "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_makes_a_resource_fork_when_none_exists() {
  make_str_rsrc
  test -n "$(cat "${rsrc_file}/..namedfork/rsrc")"
}

it_does_not_create_an_apple_double_resource_fork() {
  make_str_rsrc
  test -e "${rsrc_file}/..namedfork/rsrc"
}

it_makes_a_string_resource_given_a_valid_dot_r_file() {
  make_str_rsrc
  strings "${rsrc_file}/..namedfork/rsrc" | grep "${rsrc_str}"
  test $? -eq 0
}