#!/usr/bin/env roundup

describe "git-resource-fork-hooks"

REPO=tmp

before() {
  git init $REPO
  cp hooks/post-checkout $REPO/.git/hooks/
  cp hooks/post-merge $REPO/.git/hooks/
  cp hooks/pre-commit $REPO/.git/hooks
}

after() {
  rm -R $REPO
}

it_has_post_checkout_hook() {
  test -e $REPO/.git/hooks/post-checkout
}

it_has_post_merge_hook() {
  test -e $REPO/.git/hooks/post-merge
}

it_has_pre_commit_hook() {
  test -e $REPO/.git/hooks/pre-commit
}