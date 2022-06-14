/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:airspector_mission_planner/bloc/waypoints_model.dart';
import '../bloc/mission_manager.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapController mapController =
        Provider.of<MissionManager>(context).mapController;
    List<Widget> missionList = Provider.of<MissionManager>(context).missionList;
    List<WayPoint> markerList =
        Provider.of<MissionManager>(context).missionMarkers;
    int activeWaypoint = Provider.of<MissionManager>(context).activeWaypoint;
    MissionManager missionManager = Provider.of<MissionManager>(context);
    LatLng paris = LatLng(48.8566, 2.3522);

    return Stack(children: <Widget>[
      FlutterMap(
          mapController: mapController,
          options: MapOptions(
            //onTap: (point) {mapController.move(paris, 5.0);},
            center: LatLng(46.213951, 39.939196),
            zoom: 13.0,
            maxZoom: 21.0,
            minZoom: 2.0,
            interactiveFlags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom |
                InteractiveFlag.flingAnimation,
          ),
          layers: [
            TileLayerOptions(
                //backgroundColor: Colors.transparent,
                urlTemplate:
                    "http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
                maxZoom: 21,
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
            TileLayerOptions(
                backgroundColor: Colors.transparent,
                urlTemplate:
                    "http://{s}.google.com/vt/lyrs=h&x={x}&y={y}&z={z}",
                maxZoom: 21,
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
            /*TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),*/
            PolylineLayerOptions(polylines: [
              Polyline(
                  points: context.watch<MissionManager>().missionLines,
                  color: Colors.orange,
                  strokeWidth: 3
                  //points:<LatLng>[LatLng(46.213951, 39.939196), LatLng(46.113951, 39.639196)]
                  )
            ]),

            // Circle markers which show radius of spirals and fence points
            CircleLayerOptions(circles: <CircleMarker>[
              for (int index = 0; index < markerList.length; index++)
                if (markerList[index].type == WayPointType.spiral)
                  new CircleMarker(
                      //radius marker
                      point: markerList[index].pos,
                      color: Colors.blue.withOpacity(0.3),
                      borderStrokeWidth: 3.0,
                      borderColor: Colors.blue,
                      radius: markerList[index].radius.toDouble(), //radius
                      useRadiusInMeter: true),
              for (int index = 0; index < markerList.length; index++)
                if (markerList[index].type == WayPointType.spiral)
                  new CircleMarker(
                      //radius marker
                      point: markerList[index].pos,
                      color: Colors.red.withOpacity(0.3),
                      borderStrokeWidth: 3.0,
                      borderColor: Colors.red,
                      radius: 3, //markerList[index].radius, //radius
                      useRadiusInMeter: true),
            ]),

            // General markers of all waypoints
            MarkerLayerOptions(
              markers: List.generate(
                  missionList.length,
                  (index) => Marker(
                      width: 30.0,
                      height: 30.0,
                      point: markerList[index].pos,
                      builder: (ctx) => GestureDetector(
                            onTap: () {
                              missionManager.activeWaypoint = index;
                            },
                            child: Container(
                                width: 30.0,
                                height: 30.0,
                                child: Center(child: Text(index.toString())),
                                decoration: new BoxDecoration(
                                  color: (index == activeWaypoint)
                                      ? Colors.green
                                      : getWPColor(markerList[index].type),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                )),
                          ))),
            ),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 30.0,
                  height: 30.0,
                  point: missionManager.uavMarker,
                  builder: (ctx) => GestureDetector(
                        child: Container(
                            width: 30.0,
                            height: 30.0,
                            child: Center(child: Text("X")),
                            decoration: new BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            )),
                      ))
            ])
          ]),
      Center(
        child: Opacity(
            opacity: 0.6,
            child: Icon(
              TablerIcons.crosshair,
              color: Colors.teal,
              size: 24.0,
            )),
      ),
    ]);
  }
}
*/