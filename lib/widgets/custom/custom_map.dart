import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatelessWidget {
  final LatLng markerLocation;
  final String markerTitle;

  const CustomMap({
    super.key,
    required this.markerLocation,
    this.markerTitle = "Marker",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: markerLocation,
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId(markerTitle),
            position: markerLocation,
            infoWindow: InfoWindow(title: markerTitle),
          ),
        },
      ),
    );
  }
}
