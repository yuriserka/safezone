import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class GeolocationService {
  late Stream<Position> _positionStream;
  final _logger = Modular.get<Logger>();

  Future<Position> determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }

  void init({
    void Function(Position position)? onLocationUpdate,
  }) async {
    _watchPosition(onLocationUpdate);
  }

  void _watchPosition(
      void Function(Position position)? onLocationUpdate) async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
      ),
    );

    _positionStream.listen((final Position position) {
      _logger.d('lat=${position.latitude}, lng=${position.longitude}');
      if (onLocationUpdate != null) {
        onLocationUpdate(position);
      }
    });
  }
}
