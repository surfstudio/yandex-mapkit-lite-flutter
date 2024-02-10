import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class UserLocationMapStrategyDelegate extends MapStrategyDelegate {
  bool _visible = false;

  @override
  Widget buildActions(BuildContext context) {
    return ListenableBuilder(
      listenable: this,
      builder: (context, _) {
        return FloatingActionButton.extended(
          onPressed: () {
            /// Toggles the user location layer visibility.
            ///
            /// If the user location layer is visible, the placemark
            /// for user location will be shown.
            ///
            /// We can customize the placemark appearance and accuracy circle
            /// by providing a custom [onUserLayer] callback.
            ///
            /// If the user location layer is hidden, the placemark
            /// for user location will be hidden.
            controller?.toggleUserLayer(
              visible: !_visible,
            );

            _visible = !_visible;

            notifyListeners();
          },
          label: Text('Toggle user location layer: ${_visible ? 'ON' : 'OFF'}'),
        );
      },
    );
  }

  @override
  Future<UserLocationView>? onUserLayer(UserLocationView view) async {
    return view.copyWith(
      accuracyCircle: CircleMapObject(
        mapId: const MapObjectId('user_accuracy_circle'),
        circle: view.accuracyCircle.circle,
        fillColor: Colors.red,
      ),
      pin: PlacemarkMapObject(
        mapId: const MapObjectId('user_pin'),
        point: view.pin.point,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(Assets.user),
          ),
        ),
      ),
    );
  }

  @override
  Set<MapObject> get mapObjects => {};
}
