#!/usr/bin/env sh

# global variables
rsrc_file="Test"
rsrc_str="Resource String"

# helper methods
make_str_rsrc() {
  cat << EOM > "${rsrc_file}.r"
resource 'STR ' (128) {
  "${rsrc_str}"
};
EOM
  Rez -F Carbon Carbon.r "${rsrc_file}.r" -o "${rsrc_file}"
}

split_str_rsrc() {
  make_str_rsrc
  SplitForks -s "${rsrc_file}"
}