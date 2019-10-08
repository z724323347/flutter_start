
import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class MapIndexPage extends StatefulWidget {
  MapIndexPage({Key key}) : super(key: key);

  _MapIndexPageState createState() => _MapIndexPageState();
}

class _MapIndexPageState extends State<MapIndexPage> {
  AMapController _controller;
  // MyLocationStyle _myLocationStyle = MyLocationStyle();

  @override
  void initState() {
    initMap();
    super.initState();
  }

  void initMap() async {
    await AMap.init('27d67839721288be2ddd87b4fd868822');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map_Fiald'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: AMapView(
                onAMapViewCreated: (controller) {
                  _controller = controller;
                },
                amapOptions: AMapOptions(
                compassEnabled: false,
                zoomControlsEnabled: true,
                logoPosition: LOGO_POSITION_BOTTOM_CENTER,
                camera: CameraPosition(
                  target: LatLng(29.851827, 110.801637),
                  zoom: 15,
                ),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
