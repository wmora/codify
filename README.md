# Codify

The purpose of this app is to post an issue to a GitHub repo with the ability to attach an image from the device photo library. Very handy for creating issues with screenshots from the device. Unfortunately, the approach used here does not work with GitHub since their markdown does not allow the use of base64 images :(. I will look into other alternatives.

The app is far from finished, but if you want to give it a try:

* If it's your first time using the app, tap "Login" to authenticate with GH
* Go to "Create an issue" to create an issue for a GH repo. Note that the user is not notified if the issue was created or if it couldn't be created.

## Getting Started
* Register a new OAuth application in GitHub (if you haven't done it yet) [here](https://github.com/settings/applications/new)
* Run `setup.sh`
* Add your client ID and client secret `Credentials.plist`. Note that this file is ignored for versioning
