import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/res/assets.dart';
import 'package:yandex_mapkit_example/presentation/state/collection_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/custom_clusterization_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/custom_shape_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/default_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/draggable_placemark_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/traffic_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/state/user_location_map_strategy.dart';
import 'package:yandex_mapkit_example/presentation/widgets/map_widget.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late MapStrategyDelegate _mapStrategy;

  YandexMapController? _controller;

  @override
  void initState() {
    _mapStrategy = _strategies[_selectedStrategy];

    super.initState();
  }

  int _selectedStrategy = 0;

  final _strategies = <MapStrategyDelegate>[
    /// Default strategy for map feature showcase.
    ///
    /// This strategy is showing how to add a placemark to the map and how to
    /// handle user interactions with the placemark.
    ///
    /// The placemark is a circle with a red number inside, which is incremented
    /// every time the user taps on the placemark.
    ///
    /// See [DefaultIncrementMapStrategyDelegate] for more details.
    DefaultIncrementMapStrategyDelegate(),

    /// Strategy for map feature showcase with a collection of placemarks.
    ///
    /// This strategy is showing how to add a collection of placemarks to the map
    /// and how to handle user interactions with the placemarks.
    ///
    /// Also there is a native package limitations, which you have to be
    /// warned about.
    ///
    /// See [ClusterMapStrategyDelegate] for more details.
    ClusterMapStrategyDelegate(),

    /// Strategy for map feature showcase with traffic layer.
    ///
    /// This strategy is showing how to add a traffic layer to the map and how to
    /// handle user interactions with the traffic layer.
    ///
    /// See [TrafficMapStrategyDelegate] for more details.
    TrafficMapStrategyDelegate(),

    /// Strategy for map feature showcase with user location layer.
    ///
    /// This strategy is showing how to add a user location layer to the map and
    /// how to handle user interactions with the user location layer.
    ///
    /// See [UserLocationMapStrategyDelegate] for more details.
    UserLocationMapStrategyDelegate(),

    /// Strategy for map feature showcase with draggable placemark.
    ///
    /// This strategy is showing how to add a draggable placemark to the map and
    /// how to handle user interactions with the placemark.
    ///
    /// See [DraggablePlacemarkMapStrategyDelegate] for more details.
    DraggablePlacemarkMapStrategyDelegate(),

    /// Strategy for map feature showcase with custom shape.
    ///
    /// This strategy is showing how to add a custom shape to the map and how to
    /// handle user interactions with the shape.
    ///
    /// See [CustomShapeMapStrategyDelegate] for more details.
    CustomShapeMapStrategyDelegate(),

    /// Strategy for map feature showcase with custom clusterization.
    ///
    /// This strategy is showing how to add a custom clusterization to the map and
    /// how to handle user interactions with the clusterization.
    ///
    /// See [CustomClusterizationMapStrategyDelegate] for more details.
    CustomClusterizationMapStrategyDelegate(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mapStrategy.title),
        actions: [
          DropdownButton<int>(
            value: _selectedStrategy,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Icon(Icons.place),
              ),
              DropdownMenuItem(
                value: 1,
                child: Icon(Icons.collections),
              ),
              DropdownMenuItem(
                value: 2,
                child: Icon(Icons.traffic),
              ),
              DropdownMenuItem(
                value: 3,
                child: Icon(Icons.person),
              ),
              DropdownMenuItem(
                value: 4,
                child: Icon(Icons.move_down_sharp),
              ),
              DropdownMenuItem(
                value: 5,
                child: Icon(Icons.shape_line),
              ),
              DropdownMenuItem(
                value: 6,
                child: Icon(Icons.dashboard_customize),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStrategy = value!;
                _mapStrategy = _strategies[_selectedStrategy];
              });

              _controller?.moveCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    target: Constants.defaultLocation,
                    zoom: 10,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _mapStrategy,
        builder: (context, child) => MapWidget(
          mapObjects: _mapStrategy.mapObjects.toList(),
          onControllerCreated: (controller) {
            _controller = controller;
            _controller?.moveCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                  target: Constants.defaultLocation,
                  zoom: 10,
                ),
              ),
            );
            for (final strategy in _strategies) {
              strategy.controller = controller;
            }
          },
          onTrafficChanged: _mapStrategy.onTrafficLevelChanged,
          onUserLocationUpdated: _mapStrategy.onUserLayer,
          onCameraPositionChanged: _mapStrategy.onCameraPositionChanged,
          allowUserInteractions: _mapStrategy.allowUserInteractions,
        ),
      ),
      floatingActionButton: _mapStrategy.buildActions(context),
    );
  }
}
