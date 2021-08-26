import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavbarState createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var bottomNavStyle =
      GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(0, 5))
      ]),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? new FaIcon(FontAwesomeIcons.home)
                : new FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? new FaIcon(FontAwesomeIcons.cog)
                : new FaIcon(FontAwesomeIcons.cog),
            label: 'User',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
      ),
    );
  }
}
