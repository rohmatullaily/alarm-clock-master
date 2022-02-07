// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'clock_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class ClockBlocType extends RxBlocTypeBase {
  ClockBlocEvents get events;
  ClockBlocStates get states;
}

/// [$ClockBloc] extended by the [ClockBloc]
/// {@nodoc}
abstract class $ClockBloc extends RxBlocBase
    implements ClockBlocEvents, ClockBlocStates, ClockBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [setMinute]
  final _$setMinuteEvent = PublishSubject<int>();

  /// Тhe [Subject] where events sink to by calling [setHour]
  final _$setHourEvent = PublishSubject<int>();

  /// Тhe [Subject] where events sink to by calling [setIndexToogle]
  final _$setIndexToogleEvent = PublishSubject<int>();

  /// Тhe [Subject] where events sink to by calling [setAMActive]
  final _$setAMActiveEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [setPMActive]
  final _$setPMActiveEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [setItemActive]
  final _$setItemActiveEvent = PublishSubject<int>();

  /// Тhe [Subject] where events sink to by calling [setAlarmActive]
  final _$setAlarmActiveEvent = PublishSubject<_SetAlarmActiveEventArgs>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [minute] implemented in [_mapToMinuteState]
  late final Stream<String> _minuteState = _mapToMinuteState();

  /// The state of [hour] implemented in [_mapToHourState]
  late final Stream<String> _hourState = _mapToHourState();

  /// The state of [isItemActive] implemented in [_mapToIsItemActiveState]
  late final Stream<List<bool>> _isItemActiveState = _mapToIsItemActiveState();

  /// The state of [isAMActive] implemented in [_mapToIsAMActiveState]
  late final Stream<bool> _isAMActiveState = _mapToIsAMActiveState();

  /// The state of [isPMActive] implemented in [_mapToIsPMActiveState]
  late final Stream<bool> _isPMActiveState = _mapToIsPMActiveState();

  /// The state of [isAlarmActive] implemented in [_mapToIsAlarmActiveState]
  late final Stream<AlarmResponse> _isAlarmActiveState =
      _mapToIsAlarmActiveState();

  /// The state of [notification] implemented in [_mapToNotificationState]
  late final Stream<String?> _notificationState = _mapToNotificationState();

  @override
  void setMinute(int minute) => _$setMinuteEvent.add(minute);

  @override
  void setHour(int hour) => _$setHourEvent.add(hour);

  @override
  void setIndexToogle(int hour) => _$setIndexToogleEvent.add(hour);

  @override
  void setAMActive() => _$setAMActiveEvent.add(null);

  @override
  void setPMActive() => _$setPMActiveEvent.add(null);

  @override
  void setItemActive(int index) => _$setItemActiveEvent.add(index);

  @override
  void setAlarmActive(
          String? hourData, String? minuteData, List<bool>? isItemActive) =>
      _$setAlarmActiveEvent
          .add(_SetAlarmActiveEventArgs(hourData, minuteData, isItemActive));

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<String> get minute => _minuteState;

  @override
  Stream<String> get hour => _hourState;

  @override
  Stream<List<bool>> get isItemActive => _isItemActiveState;

  @override
  Stream<bool> get isAMActive => _isAMActiveState;

  @override
  Stream<bool> get isPMActive => _isPMActiveState;

  @override
  Stream<AlarmResponse> get isAlarmActive => _isAlarmActiveState;

  @override
  Stream<String?> get notification => _notificationState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<String> _mapToMinuteState();

  Stream<String> _mapToHourState();

  Stream<List<bool>> _mapToIsItemActiveState();

  Stream<bool> _mapToIsAMActiveState();

  Stream<bool> _mapToIsPMActiveState();

  Stream<AlarmResponse> _mapToIsAlarmActiveState();

  Stream<String?> _mapToNotificationState();

  @override
  ClockBlocEvents get events => this;

  @override
  ClockBlocStates get states => this;

  @override
  void dispose() {
    _$setMinuteEvent.close();
    _$setHourEvent.close();
    _$setIndexToogleEvent.close();
    _$setAMActiveEvent.close();
    _$setPMActiveEvent.close();
    _$setItemActiveEvent.close();
    _$setAlarmActiveEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}

/// Helps providing the arguments in the [Subject.add] for
/// [ClockBlocEvents.setAlarmActive] event
class _SetAlarmActiveEventArgs {
  const _SetAlarmActiveEventArgs(
      this.hourData, this.minuteData, this.isItemActive);

  final String? hourData;

  final String? minuteData;

  final List<bool>? isItemActive;
}
