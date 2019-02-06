#!/usr/bin/env roundup

describe "git-resource-fork-hooks"

REPO=tmp
rsrc_file="Test"
rsrc_str="Resource String"

make_rsrc_fork_file() {
  # Use Rez to build a file with data in its resource fork
  # http://xahlee.info/UnixResource_dir/macosx.html
  # http://preserve.mactech.com/articles/mactech/Vol.14/14.09/RezIsYourFriend/index.html
  # http://mirror.informatimago.com/next/developer.apple.com/documentation/mac/MoreToolbox/MoreToolbox-17.html#HEADING17-0
  # http://www.manpagez.com/man/1/Rez/
  cat << EOM > ${REPO}/${rsrc_file}.r
resource 'STR ' (128) {
  "${rsrc_str}"
};
EOM
  Rez -F Carbon Carbon.r ${REPO}/${rsrc_file}.r -o ${REPO}/${rsrc_file}
}

before() {
  git init ${REPO}
  cp hooks/post-checkout ${REPO}/.git/hooks/
  cp hooks/post-merge ${REPO}/.git/hooks/
  cp hooks/pre-commit ${REPO}/.git/hooks
}

after() {
  rm -Rf ${REPO}
}

it_has_post_checkout_hook() {
  test -e ${REPO}/.git/hooks/post-checkout
}

it_has_post_merge_hook() {
  test -e ${REPO}/.git/hooks/post-merge
}

it_has_pre_commit_hook() {
  test -e ${REPO}/.git/hooks/pre-commit
}

it_splits_resource_forks_upon_commit() {
  make_rsrc_fork_file
  if test -e ${REPO}/._${rsrc_file}; then
    false
  fi
  cd ${REPO}
  git add ${rsrc_file}
  git commit -m "Adding '${rsrc_file}' file with resource fork"
  cd -
  strings ${REPO}/${rsrc_file}/..namedfork/rsrc
  cat ${REPO}/${rsrc_file}.r
  test -e ${REPO}/._${rsrc_file} && strings ${REPO}/${rsrc_file}/..namedfork/rsrc | grep "${rsrc_str}" && strings ${REPO}/._${rsrc_file} | grep "${rsrc_str}"
}

#xit_fixes_resource_forks_upon_checkout() {
  
#}

#xit_fixes_resource_forks_upon_merge() {
  
#}
