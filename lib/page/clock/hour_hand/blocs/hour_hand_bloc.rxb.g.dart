// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'hour_hand_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class HourHandBlocType extends RxBlocTypeBase {
  HourHandBlocEvents get events;
  HourHandBlocStates get states;
}

/// [$HourHandBloc] extended by the [HourHandBloc]
/// {@nodoc}
abstract class $HourHandBloc extends RxBlocBase
    implements HourHandBlocEvents, HourHandBlocStates, HourHandBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [onPanUpdate]
  final _$onPanUpdateEvent = PublishSubject<DragUpdateDetails?>();

  /// Тhe [Subject] where events sink to by calling [setRadius]
  final _$setRadiusEvent = PublishSubject<double>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [angle] implemented in [_mapToAngleState]
  late final Stream<double> _angleState = _mapToAngleState();

  /// The state of [degree] implemented in [_mapToDegreeState]
  late final Stream<double> _degreeState = _mapToDegreeState();

  /// The state of [hour] implemented in [_mapToHourState]
  late final Stream<int> _hourState = _mapToHourState();

  @override
  void onPanUpdate(DragUpdateDetails? details) =>
      _$onPanUpdateEvent.add(details);

  @override
  void setRadius(double radius) => _$setRadiusEvent.add(radius);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<double> get angle => _angleState;

  @override
  Stream<double> get degree => _degreeState;

  @override
  Stream<int> get hour => _hourState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<double> _mapToAngleState();

  Stream<double> _mapToDegreeState();

  Stream<int> _mapToHourState();

  @override
  HourHandBlocEvents get events => this;

  @override
  HourHandBlocStates get states => this;

  @override
  void dispose() {
    _$onPanUpdateEvent.close();
    _$setRadiusEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
