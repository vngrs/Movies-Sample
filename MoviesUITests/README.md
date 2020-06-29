# XCTUITests Run on Local and Firebase
## Build Project
xcodebuild -workspace /Users/mesut/Projects/vngrs-toolkits/Movies-Sample-ios/Movies.xcworkspace \
    -scheme Movies \
    -derivedDataPath /Users/mesut/Desktop/vngrs-toolset-ios \
    -sdk iphoneos build-for-testing 

## Build Project for Specific Test Classes / Methods
xcodebuild build-for-testing -workspace /Users/mesut/Projects/vngrs-toolkits/Movies-Sample-ios/Movies.xcworkspace \
    -scheme Movies \
    -derivedDataPath /Users/mesut/Desktop/vngrs-toolset-ios \
    -sdk iphoneos \
    -only-testing:MoviesUITests/Tests/HomePageTests test

## Zip the Project Output
cd /Users/mesut/Desktop/vngrs-toolset-ios/Build/Products
zip -r Movies.zip Debug-iphoneos Movies_iphoneos13.2-arm64e.xctestrun


## List the Device Options for iOS
gcloud firebase test ios locales list
gcloud firebase test ios models list
gcloud firebase test ios versions list
gcloud firebase test ios locales describe
gcloud firebase test ios models describe
gcloud firebase test ios run
gcloud firebase test ios versions describe


## Local Run /  Check Build Before the Firabse Run 
This command run the tests on a real ios device to helps if there is anything wrong with the package. 

xcodebuild test-without-building \
    -xctestrun "/Users/mesut/Desktop/vngrs-toolset-ios/Build/Products/Movies_iphoneos13.2-arm64e.xctestrun" \
    -destination id=00008030-001425D81410802E

xcodebuild test-without-building \
    -xctestrun "/Users/mesut/Desktop/vngrs-toolset-ios/Build/Products/Movies_iphoneos13.2-arm64e.xctestrun" \
    -destination id=44B6846E-C920-4293-9FA6-312E418C2EF9


## Run the Tests on Firebase
Create UUID to store the outputs of the test under it in Google cloud

gcloud firebase test ios run --test /Users/mesut/Desktop/vngrs-toolset-ios/Build/Products/Movies.zip \
  --device model=iphone11,version=13.3,locale=tr_TR,orientation=portrait \
  --xcode-version=11.3 \
  --results-dir=$UUID 



## CI Integration
if gcloud firebase test ios run --test MyTest.zip --timeout 2m
then
    echo "Test matrix successfully finished"
else
    echo "Test matrix exited abnormally with non-zero exit code: " $?
fi

Exit code    Notes
0    All test executions passed.
1    A general failure occurred. Possible causes include: a filename that does not exist or an HTTP/network error.
2    Testing exited because unknown commands or arguments were provided.
10    One or more test cases (tested classes or class methods) within a test execution did not pass.
15    Firebase Test Lab could not determine if the test matrix passed or failed, because of an unexpected error.
19    The test matrix was canceled by the user.
20    A test infrastructure error occurred.
