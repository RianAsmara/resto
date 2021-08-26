import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_apps/common/navigation.dart';
import 'package:resto_apps/data/api/api_service.dart';
import 'package:resto_apps/provider/db_provider.dart';
import 'package:resto_apps/provider/preferences_provider.dart';
import 'package:resto_apps/provider/restaurant_provider.dart';
import 'package:resto_apps/provider/scheduling_provider.dart';
import 'package:resto_apps/screens/detail_screen.dart';
import 'package:resto_apps/data/model/restaurant.dart';
import 'package:resto_apps/screens/home_screen.dart';
import 'package:resto_apps/screens/splash_screen.dart';
import 'package:resto_apps/utils/background_service.dart';
import 'package:resto_apps/utils/db_helper.dart';
import 'package:resto_apps/utils/notification_helper.dart';
import 'package:resto_apps/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
              apiService: ApiService(), type: 'list', id: ''),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant Apps',
            theme: provider.themeData,
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              RestaurantDetailScreen.routeName: (context) =>
                  RestaurantDetailScreen(
                    restaurant: ModalRoute.of(context)?.settings.arguments
                        as Restaurant,
                  ),
            },
          );
        },
      ),
    );
  }
}
