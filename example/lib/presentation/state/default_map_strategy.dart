import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class DefaultIncrementMapStrategyDelegate extends MapStrategyDelegate {
  int _count = 0;

  void onPressed() {
    _count++;
    notifyListeners();
  }

  @override
  Widget buildActions(BuildContext context) => ListenableBuilder(
        listenable: this,
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 8),
              FloatingActionButton.extended(
                onPressed: onPressed,
                label: Text('INCREMENT: $_count'),
              ),
            ],
          );
        },
      );

  /// There is only one placemark on the map.
  ///
  /// The placemark is a circle with a red number inside, which is incremented
  /// every time the user taps on the placemark.
  ///
  /// There is also a action button for incrementing.
  @override
  Set<MapObject> get mapObjects => {
        PlacemarkMapObject(
          /// The point on the map, where the placemark is located.
          point: Constants.defaultLocation,

          /// The unique identifier of the placemark.
          ///
          /// Very important to provide a unique identifier for each map object.
          ///
          /// Do not change the identifier of the map object, if you want to
          /// update the map object place or appearance, because instead of
          /// updating the existing map object, a new map object will be created
          /// and old one will be disposed.
          mapId: const MapObjectId('counter'),
          onTap: (_, __) {
            onPressed();
          },

          /// Switcher for tap events consumption.
          ///
          /// If set to true, the tap event will be consumed, which means
          /// that only [onTap] callback will be called.
          ///
          /// Otherwise the [onTap] and [onMapTap] (from YandexMap widget) callbacks will be called.
          consumeTapEvents: true,

          /// The text to be displayed on the placemark.
          ///
          /// If you need to diplay text on the placemark, it is highly recommended
          /// to use [PlacemarkText] widget, because it will be more cost-effective.
          ///
          /// If there is a need to draw a complex text or widget on the placemark,
          /// see [icon] example below.
          text: PlacemarkText(
            text: '$_count',
            style: const PlacemarkTextStyle(
              color: Colors.black,
              size: 10,
            ),
          ),

          /// The icon to be displayed as the placemark.
          ///
          /// The only way is to use placemarks from the assets.
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(Assets.cluster),
            ),
          ),
        ),
      };
}
