import 'dart:async';

class DistanceBloc {
  final _distanceController = StreamController<double>();

  Stream<double> get distanceStream => _distanceController.stream;

  void updateDistance(double newDistance) {
    _distanceController.sink.add(newDistance);
  }

  void dispose() {
    _distanceController.close();
  }
}
