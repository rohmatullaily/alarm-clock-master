import 'package:alarm_clock_master/page/clock/models/alarm_response.dart';
import 'package:alarm_clock_master/page/clock/usecase/notification_usecase.dart';
import 'package:alarm_clock_master/shared/component/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../blocs/clock_bloc.dart';
import 'clock_analog.dart';

class ClockPage extends StatelessWidget {

  const ClockPage({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return RxBlocProvider<ClockBlocType>(
      create: (context) => ClockBloc(
         useCase: NotificationUseCase(notif: FlutterLocalNotificationsPlugin(), onselectnotif: BehaviorSubject<String?>()), 
        ),
      child: 
      RxBlocBuilder<ClockBlocType, AlarmResponse>(
      state: (bloc) => bloc.states.isAlarmActive,
      builder: (context, isAlarmActive, bloc) =>

      RxBlocBuilder<ClockBlocType, String>(
      state: (bloc) => bloc.states.hour,
      builder: (context, hour, bloc) => 

      RxBlocBuilder<ClockBlocType, String>(
      state: (bloc) => bloc.states.minute,
      builder: (context, minutes, bloc) => 

      RxBlocBuilder<ClockBlocType, List<bool>>(
      state: (bloc) => bloc.states.isItemActive,
      builder: (context, isActive, bloc) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                        hour.data ?? "00",
                        style: const TextStyle(
                            fontSize: 54, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 5,
                ),
                const Text(':',
                    style:
                        TextStyle(fontSize: 54, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 5,
                ),
                Text(
                        minutes.data ?? "00",
                        style: const TextStyle(
                            fontSize: 54, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Alarm : ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  
                  ),
               
              Text( isAlarmActive.data?.isActive == true ? "ACTIVE" : "OFF" ,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isAlarmActive.data?.isActive == true ? Colors.blue : Colors.black)),
            ],
          ),
          const SizedBox(height : 20),
          const Text("Choose One : ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height : 10),      
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
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: AButton(onTap: () {
                RxBlocProvider.of<ClockBlocType>(context)
                        .events
                        .setAlarmActive(
                          hour.data ?? "00", minutes.data ?? "00", isActive.data ?? [false, false]
                        );
              }, text: "Save Alarm"))
        ],
      ),
       )))));
  }
}
