import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_apps/common/navigation.dart';
import 'package:resto_apps/data/model/restaurant.dart';
import 'package:resto_apps/provider/db_provider.dart';
import 'package:resto_apps/screens/detail_screen.dart';

class CustomCard extends StatelessWidget {
  final Restaurant restaurant;

  const CustomCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Container(
              margin: EdgeInsets.fromLTRB(15, 20, 15, 5),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        leading: Hero(
                          tag: restaurant.pictureId,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://restaurant-api.dicoding.dev/images/large/" +
                                        restaurant.pictureId),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          restaurant.name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          restaurant.city,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigation.intentWithData(
                              RestaurantDetailScreen.routeName, restaurant);
                        },
                        trailing: isFavorite
                            ? IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () =>
                                    provider.removeFavorite(restaurant.id),
                              )
                            : IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () =>
                                    provider.addFavorite(restaurant),
                              ),
                      ),
                      Divider(
                        color: Colors.grey.shade500,
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.orangeAccent,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
