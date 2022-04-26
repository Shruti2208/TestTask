import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../data_model.dart';
import '../home_view_provider.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Map<PolylineId, Polyline> mapPolyLines = {};
  int _polylineIdCounter = 1;

  void _add(DataModel data) {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: _createPoints(data),
    );

    setState(() {
      mapPolyLines[polylineId] = polyline;
    });
  }

  List<LatLng> _createPoints(DataModel data) {
    final List<LatLng> points = <LatLng>[];
    for (var element in data.data!) {
      points.add(LatLng(element.lat!, element.lon!));
    }

    return points;
  }

  @override
  void initState() {
    var homeViewProvider =
        Provider.of<HomeViewProvider>(context, listen: false);
    _add(homeViewProvider.data);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewProvider>(builder: (ctx, homeViewProvider, child) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(homeViewProvider.data.data!.first.lat!,
                homeViewProvider.data.data!.first.lon!),
            zoom: 15.0),
        polylines: Set<Polyline>.of(mapPolyLines.values),
      );
    });
  }
}
