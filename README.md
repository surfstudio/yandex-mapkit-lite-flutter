# Yandex Mapkit Light

<img src="https://raw.githubusercontent.com/surfstudio/flutter-open-source/main/assets/logo_white.png#gh-dark-mode-only" width="200">
<img src="https://raw.githubusercontent.com/surfstudio/flutter-open-source/main/assets/logo_black.png#gh-light-mode-only" width="200">

Fork of [yandex_mapkit](https://pub.dev/packages/yandex_mapkit) library, but lightweight and more appropriate for the majority of the apps.

Made by [Surf 🏄‍♂️🏄‍♂️🏄‍♂️](https://surf.dev/)

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/yandex-mapkit-lite-flutter/on_pull_request.yml?logo=github&logoColor=white)](https://github.com/surfstudio/yandex-mapkit-lite-flutter)
[![Pub Version](https://img.shields.io/pub/v/yandex_mapkit_lite?logo=dart&logoColor=white)](https://pub.dev/packages/yandex_mapkit_lite)
[![Pub Likes](https://badgen.net/pub/likes/yandex_mapkit_lite)](https://pub.dev/packages/yandex_mapkit_lite)
[![Pub popularity](https://badgen.net/pub/popularity/yandex_mapkit_lite)](https://pub.dev/packages/yandex_mapkit_lite/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/yandex_mapkit_lite)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

<p align="center">
<img src="https://raw.githubusercontent.com/surfstudio/yandex-mapkit-lite-flutter/main/assets/yandex_mapkit_lite.light.png" height="125" alt="yandex mapkit logo" />
</p>

## Overview

- :earth_africa: Map overview - enables to view the map of the world, with which user can interact with any convenient way, usually in order to demonstrate the location of some place
- :house: Custom map objects - enables for developers to add custom map objects in order to indicate some place on the map
- :video_game: Convenient map controls - there is an API for straight-to-point map controls through the code - from zooming and moving to limiting user scroll and controlling the speed
- :leaves: App bundle size reduction - noticeable app bundle size reduction comparing to projects with [original package](https://pub.dev/packages/yandex_mapkit)
- :sparkles: Recommended for use if you don't need anything but basic map

## Usage

### Generate your API Key

Before you can use MapKit SDK in your application, you need the **API key**.

1) Go to the [Developer Dashboard.](https://developer.tech.yandex.ru/services/)

2) **Log in** to your Yandex account or **create** a new one.

3) Click **Connect APIs** and choose **MapKit Mobile SDK**.

4) Enter information about yourself and your project, select a pricing plan, and click **Continue**.

5) After your API key is successfully created, it will be available in the **API Interfaces → MapKit Mobile SDK** tab.

### Installation

Add `yandex_mapkit_lite` to your `pubspec.yaml` file:

```yaml
dependencies:
  yandex_mapkit_lite: $currentVersion$
```

### Setup for iOS

Specify your API key and locale in `ios/Runner/AppDelegate.swift`. It should be similar to the following

```swift
import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
    YMKMapKit.setApiKey("YOUR_API_KEY") // Your generated API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

Uncomment `platform :ios, '9.0'` in `ios/Podfile` and change to `platform :ios, '12.0'`

```ruby
# Uncomment this line to define a global platform for your project
platform :ios, '12.0'
```

### Setup for Android

Add dependency `implementation 'com.yandex.android:maps.mobile:4.4.0-lite'` to `android/app/build.gradle`

```groovy
dependencies {
    implementation 'com.yandex.android:maps.mobile:4.4.0-lite'
}
```

Specify your API key and locale in your custom application class. If you don't have one the you can create it like so

`android/app/src/main/.../MainApplication.java`

```java
import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        MapKitFactory.setLocale("YOUR_LOCALE"); // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("YOUR_API_KEY"); // Your generated API key
    }
}
```

`android/app/src/main/.../MainApplication.kt`

```kotlin
import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("YOUR_API_KEY") // Your generated API key
  }
}
```

In your `android/app/src/main/AndroidManifest.xml` Add necessary permissions:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

## Comparison with the full version

It is recommended to take into account the drawbacks of this mapkit version.

For app bundle size optimization purposes, the original package was moved to lite version, so some functionality will not be included:

|                                              | Full version       | Lite version                                                                     |
|----------------------------------------------|--------------------|----------------------------------------------------------------------------------|
| Map                                          | :white_check_mark: | :white_check_mark:                                                               |
| Traffic layer                                | :white_check_mark: | :white_check_mark:                                                               |
| Offline maps                                 | :white_check_mark: | :white_check_mark:                                                               |
| Location manager                             | :white_check_mark: | :white_check_mark:                                                               |
| User location layer                          | :white_check_mark: | :white_check_mark:                                                               |
| Custom clusterization                        | :x:                | :white_check_mark: - see the example project                                     |
| Search, hints, geocoding                     | :white_check_mark: | :x: - consider using [yandex_geocoder](https://pub.dev/packages/yandex_geocoder) |
| Automobile, bicycle, and pedestrian routing  | :white_check_mark: | :x:                                                                              |
| Routing taking into account public transport | :white_check_mark: | :x:                                                                              |
| Panorama display                             | :white_check_mark: | :x:                                                                              |

If your app needs functionality mentioned upper, that is not supported in lite version, consider using [full](https://pub.dev/packages/yandex_mapkit) version.

## Issues

### Minimal versions

There is OS version and platform restrictions for this package. The table for supported platforms and versions of their OS is presented lower:

|             | Android |   iOS   |
|-------------|---------|---------|
| **Support** | SDK 21+ | iOS 12+ |

### Localizations

Mapkit can be used with one language only at the same time.

Due to native constraints after the application is launched language can't be changed.

### Android

### Example

Example project is soon to be refactored.

#### Hybrid Composition

By default android views are rendered using [Hybrid Composition](https://flutter.dev/docs/development/platform-integration/platform-views). In order to render the `YandexMap` widget on Android using Virtual Display (old composition), set [AndroidYandexMap.useAndroidViewSurface] to false before using `YandexMap` widget.

```dart
AndroidYandexMap.useAndroidViewSurface = false;
```

### Terms of use

**Disclaimer**: This project uses Yandex Mapkit which belongs to Yandex. When using Mapkit refer to these [terms of use](https://yandex.com/dev/mapkit/doc/en/conditions).

Credits to [Unact](https://github.com/Unact).

## Contribute

To report your issues, submit them directly in the [Issues](https://github.com/surfstudio/yandex-mapkit-lite-flutter/issues) section.

If you would like to contribute to the package (e.g. by improving the documentation, fixing a bug or adding a cool new feature), please read our [contribution guide](./CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.
[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/surf_flutter)
