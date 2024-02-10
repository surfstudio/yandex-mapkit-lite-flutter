import 'package:flutter/material.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

/// Delegate for Yandex Map feature showcase strategy.
///
/// This delegate is responsible for providing map objects and actions to be
/// displayed on the map.
///
/// The delegate is also responsible for handling user interactions with the map
/// objects and updating the map objects accordingly.
abstract class MapStrategyDelegate extends ChangeNotifier {
  /// Set of map objects to be displayed on the map.
  Set<MapObject> get mapObjects;

  /// Widget to be displayed as the floating action button on the screen.
  ///
  /// This widget is used to provide user interactions with the map objects.
  ///
  /// This widget is displayed at the bottom right corner of the screen.
  Widget buildActions(BuildContext context);

  /// Callback for traffic level change event.
  ///
  /// This callback is called when the traffic level on the map is changed.
  ///
  /// The implementation of this callback is optional.
  void onTrafficLevelChanged(TrafficLevel? trafficLevel) {}

  /// Callback for user location layer toggle.
  ///
  /// Callback is called when user location layer is toggled, and
  /// the placemark is soon to be displayed on the map.
  ///
  /// Allows us to load custom placemark appearance and accuracy circle.
  ///
  /// The implementation of this callback is optional.
  Future<UserLocationView>? onUserLayer(UserLocationView view) => null;

  /// Map controller.
  ///
  /// This controller is used to interact with the map.
  YandexMapController? controller;

  /// Whether user interactions with the map are allowed.
  ///
  /// This property is used to control whether user interactions with the map are
  /// allowed.
  bool get allowUserInteractions => true;
}
