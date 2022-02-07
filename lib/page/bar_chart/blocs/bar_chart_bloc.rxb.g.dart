// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'bar_chart_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class BarChartBlocType extends RxBlocTypeBase {
  BarChartBlocEvents get events;
  BarChartBlocStates get states;
}

/// [$BarChartBloc] extended by the [BarChartBloc]
/// {@nodoc}
abstract class $BarChartBloc extends RxBlocBase
    implements BarChartBlocEvents, BarChartBlocStates, BarChartBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [series] implemented in [_mapToSeriesState]
  late final Stream<List<Series<TimeResponse, String>>> _seriesState =
      _mapToSeriesState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<List<Series<TimeResponse, String>>> get series => _seriesState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<List<Series<TimeResponse, String>>> _mapToSeriesState();

  @override
  BarChartBlocEvents get events => this;

  @override
  BarChartBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
