import 'package:flutter/material.dart';
import 'package:location/location.dart' as l;
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexPage extends StatefulWidget {
  const YandexPage({super.key});

  @override
  State<YandexPage> createState() => _YandexPageState();
}

class _YandexPageState extends State<YandexPage> {
  late YandexMapController controller;
  GlobalKey mapKey = GlobalKey();

  Future<bool> get locationPermissionNotGranted async =>
      !(await Permission.location.request().isGranted);

  Future<PermissionStatus> get request async =>
      await Permission.location.request();
  final List<MapObject> _mapObject = [
    PlacemarkMapObject(
      text: const PlacemarkText(
        text: 'Men',
        style: PlacemarkTextStyle(
          offset: 1,
          outlineColor: Colors.white,
          placement: TextStylePlacement.top,
        ),
      ),
      mapId: const MapObjectId('1'),
      point: const Point(
        latitude: 41.339153,
        longitude: 69.21571,
      ),
      consumeTapEvents: true,
      onTap: (self, point) async {},
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            'lib/assets/point.png',
          ),
          scale: 0.85,
        ),
      ),
      opacity: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    hasPermission();
  }

  Future<bool> hasPermission() async {
    l.Location location = l.Location();

    bool _serviceEnabled;
    l.PermissionStatus _permissionGranted;
    l.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied ||
        _permissionGranted == l.PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != l.PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            key: mapKey,
            mapObjects: _mapObject,
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await hasPermission();
                  print(result);
                  final location = await l.Location().getLocation();
                  _mapObject[0] = PlacemarkMapObject(
                    text: const PlacemarkText(
                      text: 'Men',
                      style: PlacemarkTextStyle(
                        offset: 1,
                        outlineColor: Colors.white,
                        placement: TextStylePlacement.top,
                      ),
                    ),
                    mapId: const MapObjectId('1'),
                    point: Point(
                      latitude: location.latitude ?? 0,
                      longitude: location.longitude ?? 0,
                    ),
                    consumeTapEvents: true,
                    onTap: (self, point) async {},
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          'assets/location.png',
                        ),
                        scale: 0.85,
                      ),
                    ),
                    opacity: 1,
                  );
                  await controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 18,
                        target: Point(
                          latitude: location.latitude ?? 0,
                          longitude: location.longitude ?? 0,
                        ),
                      ),
                    ),
                    animation: const MapAnimation(
                      type: MapAnimationType.linear,
                      duration: 0.1,
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
