#!/bin/bash

# - - - - - - - - -  V A R I A B L E S - - - - - - - - -
SECONDS=0
GSUTIL_INSTALL_DIR=$HOME/gsutil-install-dir
LOG_FILE=setup-log.txt
CHECK_XCODE_INSTALLATION=false


# - - - - - - - - -  F U N C T I O N S - - - - - - - - -
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m' # No Color


function step {
	echo -e "\n\n${GREEN}####### $* #######${NC}"
}

function info {
	echo -e "\n${MAGENTA}--> $* ${NC}"
}


# - - - - - - - - -  S E T U P - - - - - - - - -

info "On failure check the log from $LOG_FILE"
exec > >(tee ${LOG_FILE}) 2>&1

step "SETTING APPLE CREDENTIAL"
info "Setting the following environment variables: XCODE_INSTALL_USER, XCODE_INSTALL_PASSWORD"
while IFS= read -r line; do
	if [[ $line =~ ^.*(email|password)$ ]]; then
		info "Please replace ${YELLOW}EMAIL / PASSWORD${MAGENTA} in .apple-cred with your Apple Account\n"
		exit 1
	fi

	if [[ $line == *=* ]]; then
		export $line;
	fi
done < .apple-cred


step "INSTALL HOMEBREW"
if [[ $(command -v brew) == "" ]]; then
    info "Installing Homebrew. Need sudo access, enter the password of the user"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    info "You have Homebrew, so updating it"
    brew update
fi


step "INSTALL RBENV"
if brew list | grep -q rbenv; then
	info "You have RBENV"
else
	info "Installing RBENV"
	brew install rbenv
fi


step "SETUP LASTEST RUBY"
LASTEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
if rbenv versions | grep -q $LASTEST_RUBY; then
	info "You have the lastest Ruby version, setting-up local Ruby with the version $LASTEST_RUBY"
	rbenv local $LASTEST_RUBY
else
	info "You don't have the lastest Ruby version, Installing version $LASTEST_RUBY"
	rbenv install $LASTEST_RUBY
	info "Setting-up local Ruby with the version $LASTEST_RUBY"
	rbenv local $LASTEST_RUBY
fi


step "INSTALL GEMS"
if gem list | grep -q bundler; then
	info "You have the BUNDLER, installing GEMS"
	bundle install
else
	info "Installing BUNDLER"
	gem install bundler
	info "Installing GEMS"
	bundle install
fi


step "INSTALL LASTEST XCODE"
INSTALLED_XCODE=$(xcversion list | grep -v - | grep -v b | grep installed | awk '{print $1}')
LASTEST_XCODE=$(xcversion list | grep -v - | grep -v b | tail -1)
if [[ $INSTALLED_XCODE == $LASTEST_XCODE ]] ; then
	info "You have the LASTEST XCODE version $LASTEST_XCODE"
else
	info "Installing XCODE version $LASTEST_XCODE"
	xcversion install $LASTEST_XCODE

	EXIT_CODE=$?
	if [[ $EXIT_CODE -eq 0 ]]; then
		info "Selecting XCODE with the version $LASTEST_XCODE"
		xcversion select $LASTEST_XCODE
	else
		info "Installation XCODE with the version $LASTEST_XCODE failed"
		if [[ $CHECK_XCODE_INSTALLATION == true ]]; then
			exit 1
		fi
	fi
fi


step "INSTALL CERTIFICATES"
info "Installing all the certificates"
bundle exec fastlane certs_all


step "SETUP NODE"
info "Installing Node Version Manager - NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
info "Installing LTS version of NODE, and using it locally, then installing the latest NPM"
nvm install --lts --latest-npm


step "SETUP COCOAPODS"
info "Installing pods"
bundle exec pod install


# Google cloud requires Python
step "INSTALL PYENV"
if brew list | grep -q pyenv; then
	info "You have PYENV"
else
	info "Installing PYENV"
	brew install pyenv
fi


step "SETUP LASTEST PYTHON"
LASTEST_PYTHON=$(pyenv install --list | grep -v - | grep -v b | tail -1)
if pyenv versions | grep -q $LASTEST_PYTHON; then
	info "You have the lastest Python version, setting-up local Python with the version $LASTEST_PYTHON"
	pyenv local $LASTEST_PYTHON
else
	info "You don't have the lastest Python version, Installing version $LASTEST_PYTHON"
	pyenv install $LASTEST_PYTHON
	info "Setting-up local Python with the version $LASTEST_PYTHON"
	pyenv local $LASTEST_PYTHON
fi


# curl https://sdk.cloud.google.com | bash
# GSUTIL setup requires user prompt for install-dir and other 2 options
# to bypass this, we are using the script directly with the following arguments
# sctript url: https://dl.google.com/dl/cloudsdk/channels/rapid/install_google_cloud_sdk.bash
step "SETUP GSUTIL"
info "Installing GSUTIL to $GSUTIL_INSTALL_DIR"
rm -fr $GSUTIL_INSTALL_DIR
bash install_google_cloud_sdk.bash --disable-prompts --install-dir=$GSUTIL_INSTALL_DIR


step "INSTALL COMMITIZEN"
if npm list -g --depth=0 | grep -q commitizen; then
	info "You have the COMMITIZEN"
else
	info "Installing COMMITIZEN"
	npm install -g commitizen
fi


step "SETUP COMPLETED!"
wait
duration_total=$SECONDS
info "$(($duration_total / 60)) minutes and $(($duration_total % 60)) seconds elapsed.${NC}\n"
