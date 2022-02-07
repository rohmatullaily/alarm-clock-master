import 'package:alarm_clock_master/page/bar_chart/models/time_response.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:rxdart/rxdart.dart';

part 'bar_chart_bloc.rxb.g.dart';


abstract class BarChartBlocEvents {
  void fetchData();
}

abstract class BarChartBlocStates {
  Stream<bool> get isLoading;
  Stream<String> get errors;
  Stream<List<chart.Series<TimeResponse, String>>> get series;
}

@RxBloc()
class BarChartBloc extends $BarChartBloc {
  final List<TimeResponse> time;

  BarChartBloc(this.time);

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;

  @override
  Stream<List<chart.Series<TimeResponse, String>>> _mapToSeriesState() => _$fetchDataEvent.startWith(null)

          .switchMap((value) async* {
            List<chart.Series<TimeResponse, String>> seriesData = [
              chart.Series(
                id: "",
                data: time,
                domainFn: (TimeResponse series, _) => series.notif,
                measureFn: (TimeResponse series, _) => series.range,
                colorFn: (TimeResponse series, _) => series.color,
              )
            ];
            yield seriesData;
  });
}
