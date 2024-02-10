<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/surfstudio/yandex-mapkit-lite-flutter/assets/54618146/b1ca707b-b162-43d5-a9b1-d1895ab99e14">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/surfstudio/yandex-mapkit-lite-flutter/assets/54618146/f88243c6-26f0-4491-93bd-baf4ad5a5e50">
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/surfstudio/yandex-mapkit-lite-flutter/assets/54618146/f88243c6-26f0-4491-93bd-baf4ad5a5e50">
</picture>

[![Build Status](https://shields.io/github/actions/workflow/status/surfstudio/yandex-mapkit-lite-flutter/main.yml?logo=github&logoColor=white)](https://github.com/surfstudio/yandex-mapkit-lite-flutter)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/yandex-mapkit-lite-flutter?logo=codecov&logoColor=white)](https://app.codecov.io/gh/surfstudio/yandex-mapkit-lite-flutter)
[![Pub Version](https://img.shields.io/pub/v/yandex_mapkit_lite?logo=dart&logoColor=white)](https://pub.dev/packages/yandex_mapkit_lite)
[![Pub Likes](https://badgen.net/pub/likes/yandex_mapkit_lite)](https://pub.dev/packages/yandex_mapkit_lite)
[![Pub popularity](https://badgen.net/pub/popularity/yandex_mapkit_lite)](https://pub.dev/packages/yandex_mapkit_lite/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/yandex_mapkit_lite)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

---------

Fork of [yandex_mapkit](https://pub.dev/packages/yandex_mapkit) library, but less heavy and more optimized.

Made by [Surf :surfer:](https://surf.dev/flutter/) Flutter team :cow2:

## Description

- :earth_africa: Map overview - enables to view the map of the world, with which user can interact with any convinient way, usually in order to demonstrate the location of some place
- :house: Custom map objects - enables for developers to add custom map objects in order to indicate some place on the map
- :video_game: Convinient map controls - there is an API for straight-to-point map controls through the code - from zooming and moving to limiting user scroll and controlling the speed
- :leaves: App bundle size reduction - the average bundle size reduction for 25% comparing to projects with [original package](https://pub.dev/packages/yandex_mapkit)
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
  yandex_mapkit_lite: ^0.0.1+1
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

## Example

It is highly recommended to manage map objects in this way due to the performance reasons:

### Setup separate widget with map

We do not advise you to mix map widget with your screens and other instances - map widget is pretty heavy and can cause huge frame losses.

Additionaly, the map requires some time to warm up and load resources. The recomended way is to make controller nullable, so if there is
any interactions with the map, they would be ignored until map is initialized.

If you wish to wait until map is loaded and then do something, consider using `Completer`.

```dart

class MapWidget extends StatefulWidget {
  final List<MapObject> mapObjects;

  final MapCreatedCallback? onControllerCreated;

  const MapWidget({
    required this.mapObjects,
    this.onControllerCreated,
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: widget.onControllerCreated,
      mapObjects: widget.mapObjects,
      nightModeEnabled: Theme.of(context).brightness == Brightness.dark,
      logoAlignment: const MapAlignment(
        horizontal: HorizontalAlignment.left,
        vertical: VerticalAlignment.top,
      ),
    );
  }
}

```

### Explore and utilize functionality

That's it! Now you can explore the documentation and use map widget for your needs!

However, there are some flaws in this package, they are described in the `example` project, and we strongly advise you to consider it.

```dart

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  YandexMapController? _controller;

  final _mapObjects = <MapObject>[];

  PlacemarkMapObject _buildPlacemark() {
    return PlacemarkMapObject(
      point: const Point(latitude: 59.945933, longitude: 30.320045),
      mapId: const MapObjectId('placemark'),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/place.png'),
        ),
      ),
      text: PlacemarkText(
        text: widget.count.toString(),
        style: const PlacemarkTextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void initState() {
    _mapObjects.add(_buildPlacemark());

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MapScreen oldWidget) {
    if (oldWidget.count != widget.count) {
      final newPlacemark = _buildPlacemark();

      _mapObjects[0] = newPlacemark;

      _controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newPlacemark.point),
        ),
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  ...

}

```

### Example project

We strongly recommend to get known to the documentation of example project - there is a lot of valuable notes there.

![Example project showcase](https://github.com/surfstudio/yandex-mapkit-lite-flutter/assets/54618146/2e964025-b70b-485e-80e4-f11e8fb6c898)

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

#### Hybrid Composition

By default android views are rendered using [Hybrid Composition](https://flutter.dev/docs/development/platform-integration/platform-views). In order to render the `YandexMap` widget on Android using Virtual Display (old composition), set [AndroidYandexMap.useAndroidViewSurface] to false before using `YandexMap` widget.

```dart
AndroidYandexMap.useAndroidViewSurface = false;
```
