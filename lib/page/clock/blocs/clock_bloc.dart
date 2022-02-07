import 'package:alarm_clock_master/page/clock/models/alarm_response.dart';
import 'package:alarm_clock_master/page/clock/usecase/notification_usecase.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'clock_bloc.rxb.g.dart';

abstract class ClockBlocEvents {
  void setMinute(int minute);
  void setHour(int hour);
  void setIndexToogle(int hour);
  void setAMActive();
  void setPMActive();
  void setItemActive(int index);
  void setAlarmActive(
    String? hourData, 
    String? minuteData, 
    List<bool>? isItemActive,
  );
}

abstract class ClockBlocStates {
  Stream<bool> get isLoading;
  Stream<String> get errors;
  Stream<String> get minute;
  Stream<String> get hour;
  Stream<List<bool>> get isItemActive;
  Stream<bool> get isAMActive;
  Stream<bool> get isPMActive;
  Stream<AlarmResponse> get isAlarmActive;
  Stream<String?> get notification;

}

@RxBloc()
class ClockBloc extends $ClockBloc {
  late final ANotificationUseCase _useCase;

  ClockBloc({
    required ANotificationUseCase useCase, 
  }): 
  _useCase = useCase;
  

  @override
  Stream<String> _mapToMinuteState() => _$setMinuteEvent
          .switchMap((value) async* {
        var minute = value.toString();
        if (minute.length < 2) {
          minute = '0' + minute;
        }
        yield minute;
      });

  @override
  Stream<String> _mapToHourState() => _$setHourEvent
          .switchMap((value) async* {
        var hour = value.toString();
        if (hour.length < 2) {
          hour = '0' + hour;
        }
        yield hour;
      });


  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;

  @override
  Stream<bool> _mapToIsAMActiveState() {
    return Rx.merge([
      _$setItemActiveEvent.where((index) => index == 0).map((event) => true),
      _$setItemActiveEvent.where((index) => index == 1).map((event) => false)
    ]);
  }

  @override
  Stream<List<bool>> _mapToIsItemActiveState() {
    return Rx.combineLatest2<bool, bool, List<bool>>(isAMActive, isPMActive, (isAMActive, isPMActive) {
      return [
      isAMActive,isPMActive
    ];
    }
    
    );
  }

  @override
  Stream<bool> _mapToIsPMActiveState() {
     return Rx.merge([
      _$setItemActiveEvent.where((index) => index == 0).map((event) => false),
      _$setItemActiveEvent.where((index) => index == 1).map((event) => true)
    ]);
  }

  @override
  Stream<AlarmResponse> _mapToIsAlarmActiveState() => _$setAlarmActiveEvent
          .switchMap((value) async* {
        bool? isAM = value.isItemActive?[0] ?? false;

        String? hour = value.hourData ?? "00";
        String? minute = value.minuteData ?? "00";
        

       DateTime now = DateTime.now();
       DateTime time = DateTime(
        now.year,
        now.month,
        now.hour > (isAM ? int.parse(hour) : int.parse(hour) + 12)
            ? now.day + 1
            : now.hour == (isAM ? int.parse(hour) : int.parse(hour) + 12) &&
                    now.minute >= int.parse(minute) &&
                    now.second > 0
                ? now.day + 1
                : now.day,
        isAM ? int.parse(hour) : int.parse(hour) + 12,
        int.parse(minute));


        var notif = await _useCase.showNotification(0, "title", "body", time.toString(), time);
        var alarmResponse = AlarmResponse(errorMessage: "", isActive: true);

        if(notif != null){ 
          alarmResponse = AlarmResponse(errorMessage: "", isActive: true);
        }

        
        yield alarmResponse;
  });

  @override
  Stream<String?> _mapToNotificationState() => _useCase.onselectnotif;
}
