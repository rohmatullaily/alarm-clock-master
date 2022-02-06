import 'package:alarm_clock_master/page/clock/blocs/clock_bloc.dart';
import 'package:alarm_clock_master/page/clock/hour_hand/views/hour_hand_widget.dart';
import 'package:alarm_clock_master/page/clock/minute_hand/views/minute_hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import 'clock_analog_painter.dart';

class ClockAnalog extends StatelessWidget {
  const ClockAnalog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Center(
                  child: CustomPaint(
                      painter: ClockAnalogPainter(
                          size: 300))),
            ),
            MinuteHandWidget(
              onMinuteChanged: (minute) {
                RxBlocProvider.of<ClockBlocType>(context)
                    .events
                    .setMinute(minute);
              },
            ),
             HourHandWidget(
                onHourChanged: (hour) {
                RxBlocProvider.of<ClockBlocType>(context)
                    .events
                    .setHour(hour);
              },
                ),
            Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Center(
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        )
      ],
    );
  }
}