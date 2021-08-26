import 'package:flutter/material.dart';
import 'package:resto_apps/provider/db_provider.dart';
import 'package:resto_apps/screens/detail_screen.dart';
import 'package:resto_apps/screens/favorite_screen.dart';
import 'package:resto_apps/screens/list_screen.dart';
import 'package:resto_apps/screens/setting_screen.dart';
import 'package:resto_apps/utils/db_helper.dart';
import 'package:resto_apps/utils/notification_helper.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  // // To solve late-initialized problem, initialize the database provider and add it as a parameter to the favorite page
  static DatabaseProvider databaseProvider =
      DatabaseProvider(databaseHelper: DatabaseHelper());

  int _bottomNavIndex = 0;
  static const String _restaurantText = 'Home';

  List<Widget> _listWidget = [
    RestaurantListScreen(),
    FavoritesScreen(provider: databaseProvider),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _restaurantText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: FavoritesScreen.favoritesTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingsScreen.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 5))
        ]),
        child: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          items: _bottomNavBarItems,
          onTap: _onBottomNavTapped,
          // backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
        ),
      ),
    );
  }
}
