import 'package:alarm_clock_master/page/clock/minute_hand/blocs/minute_hand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../blocs/minute_hand_bloc.dart';

class MinuteHandWidget extends StatelessWidget {
  final Function(int)? onMinuteChanged;
  const MinuteHandWidget({Key? key, this.onMinuteChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => RxBlocProvider<MinuteHandBlocType>(
        create: (context) => MinuteHandBloc(),
        child: Builder(
          builder: (context) {
            RxBlocProvider.of<MinuteHandBlocType>(context)
                .events
                .setRadius(300 / 2);
            return GestureDetector(
              onPanUpdate: RxBlocProvider.of<MinuteHandBlocType>(context)
                  .events
                  .onPanUpdate,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: Column(children: [
                    RxBlocListener<MinuteHandBlocType, int>(
                      listener: (context, minute) {
                        onMinuteChanged?.call(minute ?? 0);
                      },
                      state: (bloc) => bloc.states.minute,
                    ),
                    RxBlocBuilder<MinuteHandBlocType, double>(
                        state: (bloc) => bloc.states.angle,
                        builder: (context, angle, bloc) => Transform.rotate(
                              angle: angle.data ?? 0.0,
                              child: Container(
                                width: 6,
                                height: 200,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black,
                                          Colors.black,
                                        ]),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ))
                  ]),
                ),
              ),
            );
          },
        ),
      );
}
