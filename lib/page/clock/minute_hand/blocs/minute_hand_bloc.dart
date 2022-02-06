import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'minute_hand_bloc.rxb.g.dart';

/// A contract class containing all events of the MinuteHandBloC.
abstract class MinuteHandBlocEvents {
  void onPanUpdate(DragUpdateDetails? details);
  void setRadius(double radius);
}

/// A contract class containing all states of the MinuteHandBloC.
abstract class MinuteHandBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  Stream<double> get angle;
  Stream<double> get degree;
  Stream<int> get minute;
}

@RxBloc()
class MinuteHandBloc extends $MinuteHandBloc {
  double _lastDegree = 0;
  
  @override
  Stream<double> _mapToDegreeState() => _$onPanUpdateEvent
          .withLatestFrom<double, Map>(
              _$setRadiusEvent.startWith(0), (t, s) => {"details": t, "radius": s})
          .switchMap((map) async* {
        final radius = map["radius"] as double;
        final d = map["details"] as DragUpdateDetails?;
        if (d != null) {
          bool onTop = d.localPosition.dy <= radius;
          bool onLeftSide = d.localPosition.dx <= radius;
          bool onRightSide = !onLeftSide;
          bool onBottom = !onTop;

          bool panUp = d.delta.dy <= 0.0;
          bool panLeft = d.delta.dx <= 0.0;
          bool panRight = !panLeft;
          bool panDown = !panUp;

          double yChange = d.delta.dy.abs();
          double xChange = d.delta.dx.abs();

          double verticalRotation =
              (onRightSide && panDown) || (onLeftSide && panUp)
                  ? yChange
                  : yChange * -1;

          double horizontalRotation =
              (onTop && panRight) || (onBottom && panLeft)
                  ? xChange
                  : xChange * -1;

          double rotationalChange = verticalRotation + horizontalRotation;

          double _value = _lastDegree + (rotationalChange / 5);
          _lastDegree = _value > 0 ? _value : 0;
          yield _lastDegree;
        }
      });

  @override
  Stream<double> _mapToAngleState() =>
      degree.map((event) => _degreeToRadians(event));

  @override
  Stream<int> _mapToMinuteState() => degree.switchMap((_degree) async* {
        var a = _degree < 360 ? _degree.roundToDouble() : _degree - 360;
        var degrees = _roundToBase(a.roundToDouble(), 10);
        yield degrees ~/ 6 == 60 ? 0 : degrees ~/ 6;
      });

  double _degreeToRadians(double degrees) => degrees * (pi / 180);

  double _roundToBase(double number, int base) {
    double reminder = number % base;
    double result = number;
    if (reminder < (base / 2)) {
      result = number - reminder;
    } else {
      result = number + (base - reminder);
    }
    return result;
  }

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
