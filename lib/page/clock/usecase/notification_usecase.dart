import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as timezone;

abstract class ANotificationUseCase {

  Future<dynamic> showNotification(
    int? id,
    String? title,
    String? body,
    String? payload,
    DateTime time
    );

  Stream<String?> get onselectnotif;
}

class NotificationUseCase implements ANotificationUseCase {

  late final FlutterLocalNotificationsPlugin _notif;
  late final BehaviorSubject<String?> _onselectnotif;

  NotificationUseCase({required FlutterLocalNotificationsPlugin notifUseCase, required BehaviorSubject<String?> onselectnotifUsecase}): 
  _notif = notifUseCase, _onselectnotif = onselectnotifUsecase {
 const android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios =  IOSInitializationSettings();
    const initializationSettings = InitializationSettings(android: android, iOS: ios);
    _notif.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        _onselectnotif.add(payload);
      },
    );
  }
  
  @override
  Future showNotification(int? id, String? title, String? body, String? payload, DateTime time) {

    var notification = _notif.zonedSchedule(
          id ?? 0,
          title,
          body,
          timezone.TZDateTime.from(time, timezone.local),
         const NotificationDetails(
          android:  AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_desc',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(
        )),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
           UILocalNotificationDateInterpretation.absoluteTime);

   return notification;
  }


  @override
  Stream<String?> get onselectnotif => _onselectnotif;
}