import 'package:alarm_clock_master/page/bar_chart/models/time_response.dart';
import 'package:alarm_clock_master/page/bar_chart/views/bar_chart_page.dart';
import 'package:alarm_clock_master/page/clock/blocs/clock_bloc.dart';
import 'package:alarm_clock_master/page/clock/models/alarm_response.dart';
import 'package:alarm_clock_master/page/clock/usecase/notification_usecase.dart';
import 'package:alarm_clock_master/page/clock/views/clock_analog.dart';
import 'package:alarm_clock_master/shared/component/button.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildSelectNotification() => RxBlocListener<ClockBlocType, String?>(
        state: (bloc) => bloc.states.notification,
        listener: (context, notif) => showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: BarChartPage(
                    [
                      TimeResponse(
                        notif: notif ?? "",
                        range: DateTime.now()
                            .difference(DateTime.parse(notif!))
                            .inSeconds,
                        color: chart.ColorUtil.fromDartColor(
                          Colors.blue,
                        ),
                      )
                    ],
                  ),
                );
              },
            ));

    return RxBlocProvider<ClockBlocType>(
        create: (context) => ClockBloc(
              useCase: NotificationUseCase(
                  notifUseCase: FlutterLocalNotificationsPlugin(),
                  onselectnotifUsecase: BehaviorSubject<String?>()),
            ),
        child: RxBlocBuilder<ClockBlocType, AlarmResponse>(
            state: (bloc) => bloc.states.isAlarmActive,
            builder: (context, isAlarmActive, bloc) => RxBlocBuilder<
                    ClockBlocType, String>(
                state: (bloc) => bloc.states.hour,
                builder: (context, hour, bloc) => RxBlocBuilder<ClockBlocType,
                        String>(
                    state: (bloc) => bloc.states.minute,
                    builder: (context, minutes, bloc) =>
                        RxBlocBuilder<ClockBlocType, List<bool>>(
                          state: (bloc) => bloc.states.isItemActive,
                          builder: (context, isActive, bloc) =>
                              SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildSelectNotification(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(hour.data ?? "00",
                                          style: const TextStyle(
                                              fontSize: 54,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(':',
                                          style: TextStyle(
                                              fontSize: 54,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(minutes.data ?? "00",
                                          style: const TextStyle(
                                              fontSize: 54,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Alarm : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        isAlarmActive.data?.isActive == true
                                            ? "ACTIVE"
                                            : "OFF",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                isAlarmActive.data?.isActive ==
                                                        true
                                                    ? Colors.blue
                                                    : Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text("Choose One : ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                ToggleButtons(
                                  selectedColor: Colors.blue,
                                  children: const [
                                    Text(
                                      'AM',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'PM',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                  onPressed: (int index) {
                                    RxBlocProvider.of<ClockBlocType>(context)
                                        .events
                                        .setItemActive(index);
                                  },
                                  isSelected: isActive.data ?? [true, false],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const ClockAnalog(),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: AButton(
                                        onTap: () {
                                          RxBlocProvider.of<ClockBlocType>(
                                                  context)
                                              .events
                                              .setAlarmActive(
                                                  hour.data ?? "00",
                                                  minutes.data ?? "00",
                                                  isActive.data ??
                                                      [false, false]);
                                        },
                                        text: "Save Alarm")),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        )))));
  }
}
