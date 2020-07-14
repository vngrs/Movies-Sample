fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios certs_all
```
fastlane ios certs_all
```

### ios uitesting_signing
```
fastlane ios uitesting_signing
```

### ios certs_dev
```
fastlane ios certs_dev
```
Fetches the provisioning profiles so you can build locally and deploy to your device
### ios certs_adhoc
```
fastlane ios certs_adhoc
```
Fetches the provisioning profiles so you can build for beta or appstore distribution
### ios certs_appstore
```
fastlane ios certs_appstore
```
AppStore signing
### ios go_testflight
```
fastlane ios go_testflight
```
AppStore Distribution
### ios go_firebase
```
fastlane ios go_firebase
```
Firebase App Distribution
### ios upload_dsyms
```
fastlane ios upload_dsyms
```
Upload any dsyms in the current directory to crashlytics

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
