import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class DraggablePlacemarkMapStrategyDelegate extends MapStrategyDelegate {
  @override
  Widget buildActions(BuildContext context) => const SizedBox();

  Point point = Constants.defaultLocation;

  bool _isDragging = false;

  void updatePoint(Point point) {
    if (point == this.point) {
      return;
    }

    this.point = point;

    notifyListeners();
  }

  void updateDragging(bool isDragging) {
    _isDragging = isDragging;

    notifyListeners();
  }

  @override
  Set<MapObject> get mapObjects => {
        PlacemarkMapObject(
          point: point,

          /// The unique identifier of the placemark.
          ///
          /// Very important to provide a unique identifier for each map object.
          ///
          /// Do not change the identifier of the map object, if you want to
          /// update the map object place or appearance, because instead of
          /// updating the existing map object, a new map object will be created
          /// and old one will be disposed.
          mapId: const MapObjectId('draggable'),

          /// Enables the placemark to be draggable.
          ///
          /// If set to true, the placemark can be dragged by the user.
          ///
          /// The [onDrag] callback will be called when the placemark is dragged.
          ///
          /// The [onDragStart] callback will be called when the placemark dragging is started.
          ///
          /// The [onDragEnd] callback will be called when the placemark dragging is ended.
          ///
          /// P.S. I don't really know how to trigger the drag event, but according
          /// to the documentation, it should be possible.
          isDraggable: true,
          onDrag: (mapObject, point) {
            updatePoint(point);
          },
          onDragStart: (mapObject) {
            updateDragging(true);
          },
          onDragEnd: (mapObject) {
            updateDragging(false);
          },

          /// Switcher for tap events consumption.
          ///
          /// If set to true, the tap event will be consumed, which means
          /// that only [onTap] callback will be called.
          ///
          /// Otherwise the [onTap] and [onMapTap] (from YandexMap widget) callbacks will be called.
          consumeTapEvents: true,
          opacity: 1,

          /// The icon to be displayed as the placemark.
          ///
          /// The only way is to use placemarks from the assets.
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(_isDragging ? Assets.routeStart : Assets.routeEnd),
            ),
          ),
        ),
      };

  @override
  bool get allowUserInteractions => false;
}
