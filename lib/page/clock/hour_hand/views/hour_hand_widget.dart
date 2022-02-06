import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../blocs/hour_hand_bloc.dart';

class HourHandWidget extends StatelessWidget {
  final Function(int)? onHourChanged;
  const HourHandWidget({Key? key, this.onHourChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => RxBlocProvider<HourHandBlocType>(
        create: (context) => HourHandBloc(),
        child: Builder(
          builder: (context) {
            RxBlocProvider.of<HourHandBlocType>(context)
                .events
                .setRadius(200 / 2);
            return GestureDetector(
              onPanUpdate: (details) {
                RxBlocProvider.of<HourHandBlocType>(context)
                  .events
                  .onPanUpdate(details);
              },
              child: Container(
                height: 200 / 2 * 1.5,
                width: 200 / 2 * 1.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: Column(children: [
                    RxBlocListener<HourHandBlocType, int>(
                      listener: (context, hour) {
                        onHourChanged?.call(hour ?? 0);
                      },
                      state: (bloc) => bloc.states.hour,
                    ),
                    RxBlocBuilder<HourHandBlocType, double>(
                        state: (bloc) => bloc.states.angle,
                        builder: (context, angle, bloc) => Transform.rotate(
                              angle: angle.data ?? 0.0,
                              child: Container(
                                width: 10,
                                height: 150,
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
