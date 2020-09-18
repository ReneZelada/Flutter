# pokedex

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Android devices  
You need to download the apk

APK: this only will run on Android devices and you can find it on build/app/outputs/flutter-apk/app-release.apk().

** To install it you need to enable apps from unknown sources, you can enable it by following the following steps:

# Android® 8.x & higher
From a Home screen, swipe up or down from the center of the display to access the apps screen.Navigate: Settings Settings icon > Apps.Tap Menu icon (upper-right).Tap Special access.Tap Install unknown apps.Select the unknown app then tap the Allow from this source switch to turn on Switch on or off Switch off.
** remember that you need to have an internet connection to run it!

# HTTP Package
I choose this package due to the fact that it helps to read or get information from the internet. By using the function GET you will get the response from the API that you are consuming in this case will the one provided for this assessment.

# Convert Package 
Once we get the information we need to convert it to a readable JSON so to do that we need to use the CONVERT package, this one helps us to translate that information without any problem.
# Async Package
I  use this package because we are getting data from the internet. We are always going to get a delay during the call back from the code to the API, so this package help us to wait for that response and get the date even though we have a delay.
