import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/presentation/state/map_strategy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class CustomShapeMapStrategyDelegate extends MapStrategyDelegate {
  @override
  Widget buildActions(BuildContext context) => const SizedBox();

  @override
  Set<MapObject> get mapObjects => {
        /// Custom shape map objects.

        /// Polygon map object.
        ///
        /// A polygon is a closed figure on the map, which is defined by a set of
        /// points, which are connected by straight lines. Last point is connected
        /// with the first one.
        ///
        /// The polygon can have inner rings, which are also defined by a
        /// set of points, polygons of which are going to cut
        /// through the outer ring.
        ///
        /// Inner rings are not required, but if they are present,
        /// they generally should be inside the outer ring.
        ///
        /// See [PolygonMapObject] for more details.
        const PolygonMapObject(
          mapId: MapObjectId('polygon'),
          fillColor: Colors.black,
          polygon: Polygon(
            outerRing: LinearRing(
              points: [
                Point(latitude: 55.9, longitude: 37.5),
                Point(latitude: 55.9, longitude: 37.6),
                Point(latitude: 55.8, longitude: 37.6),
                Point(latitude: 55.8, longitude: 37.5),
              ],
            ),
            innerRings: [
              LinearRing(
                points: [
                  Point(latitude: 55.85, longitude: 37.55),
                  Point(latitude: 55.85, longitude: 37.58),
                  Point(latitude: 55.82, longitude: 37.58),
                  Point(latitude: 55.82, longitude: 37.55),
                ],
              ),
              LinearRing(
                points: [
                  Point(latitude: 55.88, longitude: 37.52),
                  Point(latitude: 55.88, longitude: 37.54),
                  Point(latitude: 55.86, longitude: 37.54),
                  Point(latitude: 55.86, longitude: 37.52),
                ],
              ),
            ],
          ),
        ),

        /// Polyline map object.
        ///
        /// A polyline is a line on the map, which is defined by a set of points,
        /// which are connected by straight lines.
        ///
        /// The ends are not connected, so the polyline is not a closed figure.
        ///
        /// See [PolylineMapObject] for more details.
        const PolylineMapObject(
          mapId: MapObjectId('polyline'),
          polyline: Polyline(
            points: [
              Point(latitude: 56, longitude: 37.5),
              Point(latitude: 56, longitude: 37.4),
              Point(latitude: 56.1, longitude: 37.8),
              Point(latitude: 55.7, longitude: 37.5),
            ],
          ),
        ),

        /// Circle map object.
        ///
        /// A circle is a closed figure on the map, which is defined by a center
        /// point and a radius.
        ///
        /// See [CircleMapObject] for more details.
        const CircleMapObject(
          mapId: MapObjectId('circle'),
          circle: Circle(
            center: Point(latitude: 56.2, longitude: 38),
            radius: 10000,
          ),
        ),
      };

  @override
  String get title => "Custom map shapess";
}
