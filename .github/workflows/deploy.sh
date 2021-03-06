#!/usr/bin/env bash

SRC_BRANCH="master"
DEPLOY_BRANCH="gh-pages"

USAGE_MSG="usage: deploy.sh [-h|--help] [-u|--user] [-s|--src SRC_BRANCH] [-d|--deploy DEPLOY_BRANCH] [--verbose] [--no-push]"

while [[ $# > 0 ]]; do
    key="$1"

    case $key in
        -h|--help)
        echo $USAGE_MSG
        exit 0
        ;;
        -u|--user)
        SRC_BRANCH="source"
        DEPLOY_BRANCH="master"
        ;;
        -s|--src)
        SRC_BRANCH="$2"
        shift
        ;;
        -d|--deploy)
        DEPLOY_BRANCH="$2"
        shift
        ;;
        --verbose)
        set -x
        ;;
        --no-push)
        NO_PUSH="--no-push"
        ;;
        *)
        echo "Option $1 is unknown." >&2
        echo $USAGE_MSG >&2
        exit 1
        ;;
    esac
    shift
done

set -e

echo "Deploying..."
echo "Source branch: $SRC_BRANCH"
echo "Deploy branch: $DEPLOY_BRANCH"

read -r -p "Do you want to proceed? [y/N] " response
if [[ ! $response =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "Aborting."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

if ! git diff-index --quiet HEAD --; then
    echo "Changes to the following files are uncommitted:"
    git diff-index --name-only HEAD --
    echo "Please commit the changes before proceeding."
    echo "Aborting."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

if ! test -z "$(git ls-files --exclude-standard --others)"; then
    echo "There are untracked files:"
    git ls-files --exclude-standard --others
    echo "Please commit those files or stash them before proceeding."
    echo "Aborting."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

if [ `git branch | grep $SRC_BRANCH | tr ' ' '\n' | tail -1` ]
then
    git checkout $SRC_BRANCH
else
    git checkout -b $SRC_BRANCH
fi

if [ `git branch | grep $DEPLOY_BRANCH` ]
then
  git branch -D $DEPLOY_BRANCH
fi
git checkout -b $DEPLOY_BRANCH

bundle exec jekyll build

find . -maxdepth 1 ! -name '_site' ! -name '.git' ! -name 'CNAME' ! -name '.gitignore' -exec rm -rf {} \;
mv _site/* .
rm -R _site/

git add -fA
git commit --allow-empty -m "$(git log -1 --pretty=%B) [ci skip]"
[[ ${NO_PUSH} ]] || git push -f -q origin $DEPLOY_BRANCH

git checkout $SRC_BRANCH

echo "Deployed successfully!"

exit 0
