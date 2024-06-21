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
    return Container(
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
      ),
    );
  }
}
