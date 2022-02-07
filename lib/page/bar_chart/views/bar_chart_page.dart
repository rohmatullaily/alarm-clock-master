import 'package:alarm_clock_master/page/bar_chart/models/time_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../blocs/bar_chart_bloc.dart';
import 'package:charts_flutter/flutter.dart' as chart;


class BarChartPage extends StatelessWidget {
  final List<TimeResponse> data;

  const BarChartPage(
    this.data, {
    Key? key, 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return RxBlocProvider<BarChartBlocType>(
        create: (context) => BarChartBloc(data),
        child: Builder(
          builder: (context) {
            return Center(
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
                    const 
                    Text(
                      'Bar Chart Notification',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    RxBlocBuilder<BarChartBlocType, List<chart.Series<TimeResponse, String>>>(
                    state: (bloc) => bloc.states.series,
                    builder: (context, series, bloc) => 
                    Expanded(
                      child: chart.BarChart(
                        series.data ?? [], 
                        animate: true,
                      ),
                    ))
                  ],
                ),
              ),
          );
          }
        ),
      );
  }
}
