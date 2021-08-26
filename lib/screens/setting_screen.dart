import 'package:google_fonts/google_fonts.dart';
import 'package:resto_apps/provider/preferences_provider.dart';
import 'package:resto_apps/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          settingsTitle,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.grey.shade700),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text(
                  'Dark Theme',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                  ),
                ),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text(
                  'Daily Reminder',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                  ),
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyReminderActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyReminder(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
