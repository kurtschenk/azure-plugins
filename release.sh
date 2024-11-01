# Create tags for release
delete_tag() {
  tag=$1
  git tag -d $1
  git push --delete origin $1
}

set_tag() {
  tag=$1
  git tag $1 -a -m ""
  git push $1
  git push --tags
}


publish() {
    
    gh auth login
    export PORTER_RELEASE_REPOSITORY=github.com/kurtschenk/azure-plugins
    export PORTER_PACKAGES_REMOTE=https://github.com/KurtSchenk/packages.git 
    mage Publish

}

tag=v1.2.3-1
delete_tag $tag
set_tag $tag

mage build
mage test # v1.2.3-1 passed
mage XBuildAll
# TODO: Set GITHUB_TOKEN to PAT token
publish

