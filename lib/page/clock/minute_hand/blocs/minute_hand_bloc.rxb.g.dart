// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'minute_hand_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class MinuteHandBlocType extends RxBlocTypeBase {
  MinuteHandBlocEvents get events;
  MinuteHandBlocStates get states;
}

/// [$MinuteHandBloc] extended by the [MinuteHandBloc]
/// {@nodoc}
abstract class $MinuteHandBloc extends RxBlocBase
    implements MinuteHandBlocEvents, MinuteHandBlocStates, MinuteHandBlocType {
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

  /// The state of [minute] implemented in [_mapToMinuteState]
  late final Stream<int> _minuteState = _mapToMinuteState();

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
  Stream<int> get minute => _minuteState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<double> _mapToAngleState();

  Stream<double> _mapToDegreeState();

  Stream<int> _mapToMinuteState();

  @override
  MinuteHandBlocEvents get events => this;

  @override
  MinuteHandBlocStates get states => this;

  @override
  void dispose() {
    _$onPanUpdateEvent.close();
    _$setRadiusEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
