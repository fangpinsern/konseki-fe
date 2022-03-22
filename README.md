# Konseki App Frontend Mobile App

Written in Dart - using the flutter framework

Dart is a kind of a strictly typed language with support for dynamic typing as well. Everything can be an object and casted.

## Development Principle

```english
Does it look good in a Pixel 4a and an iPhone?
```

For simplicity, we develop for regular phone screen sizes trying to have relative sizes where possible. This application has the expected assumption that people will use it more on their phones rather than tablets or laptop. Web version will be done on a seperate repo. This is solely for mobile application development.

## Structure of code

Currently, developement is in pages - widgets model. Pages will call different widgets to be displayed on their page. However that is an ideal. Some refactoring is required in the near future as we work to ge the feature up and running as soon as possible.

Pages - main back bone where every widget is attached to

Widgets - sub components that are placed in pages.

All codes are in the lib folders as both iOS and Android will share a common code base where possible. we only enter the respective Operating System (OS) of the folders when OS specific configurations are needed.

For example, in iOS, there is a requirement to give a reason to the user why you need access to the camera. Hence this will be done in the iOS folder of code. For those interested, we have to add the following line to the `Info.plist` file under `<dict>` section.

```plist
    <key>NSCameraUsageDescription</key>
    <string>Camera required for scanning QR Code.</string>
```

## Futter Bootstrap Archive

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
