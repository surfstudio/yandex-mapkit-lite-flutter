import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class TrafficMapStrategyDelegate extends MapStrategyDelegate {
  bool _trafficLayer = false;

  @override
  Widget buildActions(BuildContext context) {
    return ListenableBuilder(
      listenable: this,
      builder: (context, snapshot) {
        Color trafficColor;

        switch (_trafficLevel?.color) {
          case TrafficColor.red:
            trafficColor = Colors.red;
            break;
          case TrafficColor.yellow:
            trafficColor = Colors.yellow;
            break;
          case TrafficColor.green:
            trafficColor = Colors.green;
            break;
          default:
            trafficColor = Colors.grey;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                _trafficLayer = !_trafficLayer;

                if (!_trafficLayer) {
                  onTrafficLevelChanged(null);
                }

                /// Toggles the traffic layer visibility.
                ///
                /// If the traffic layer is visible, the traffic information will be
                /// displayed on the map.
                ///
                /// Also starts sending traffic level updates to the [onTrafficLevelChanged] callback.
                controller?.toggleTrafficLayer(visible: _trafficLayer);
              },
              label: Text('Toggle traffic layer: ${_trafficLayer ? 'ON' : 'OFF'}'),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: trafficColor,
              label: Text('Traffic level: ${_trafficLevel?.level}'),
            ),
          ],
        );
      },
    );
  }

  TrafficLevel? _trafficLevel;

  @override

  /// This method is called when the traffic layer is turned on
  /// and there is a change in the traffic level.
  void onTrafficLevelChanged(TrafficLevel? trafficLevel) {
    _trafficLevel = trafficLevel;
    notifyListeners();
  }

  @override
  Set<MapObject> get mapObjects => {};

  @override
  bool get allowUserInteractions => false;
}
