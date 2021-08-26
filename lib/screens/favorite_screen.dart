import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_apps/provider/db_provider.dart';
import 'package:resto_apps/utils/result_state.dart';
import 'package:resto_apps/widget/custom_card.dart';

class FavoritesScreen extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  final DatabaseProvider provider;

  const FavoritesScreen({required this.provider});

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CustomCard(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          favoritesTitle,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Colors.grey.shade700),
        ),
      ),
      body: _buildList(),
    );
  }
}
