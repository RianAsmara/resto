import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_apps/data/api/api_service.dart';
import 'package:resto_apps/data/model/restaurant.dart';
import 'package:resto_apps/data/model/review.dart';
import 'package:resto_apps/provider/restaurant_provider.dart';
import 'package:resto_apps/utils/result_state.dart';
import 'package:resto_apps/widget/add_review_dialog.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurantdetailscreen';

  final Restaurant restaurant;
  const RestaurantDetailScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    RestaurantProvider _provider;
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(
            apiService: ApiService(), type: 'detail', id: restaurant.id),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            _provider = state;
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.result.restaurant;
              var restaurantComplete = state.result.restaurant;
              return RestaurantDetail(
                restaurant: restaurant,
                provider: _provider,
                restaurantComplete: restaurantComplete,
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text("Tidak Ada Koneksi Internet!"));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}

class RestaurantDetail extends StatelessWidget {
  final RestaurantComplete restaurant;
  final RestaurantProvider provider;
  final RestaurantComplete restaurantComplete;

  const RestaurantDetail(
      {required this.restaurant,
      required this.provider,
      required this.restaurantComplete});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            restaurant.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://restaurant-api.dicoding.dev/images/large/" +
                                    restaurant.pictureId),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Deskripsi Singkat Restoran',
                          style: GoogleFonts.poppins(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            restaurantComplete.description,
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Lokasi -',
                          style: GoogleFonts.poppins(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            restaurantComplete.city,
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: FractionalOffset.centerLeft,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Rating -',
                          style: GoogleFonts.poppins(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            restaurantComplete.rating.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantComplete.menus.foods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: GestureDetector(
                              onTap: () => {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Coming Soon!'),
                                      // content: Text('Coming Soon'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              },
                              child: Container(
                                child: Card(
                                  elevation: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        restaurant.menus.foods[index].name
                                            .toUpperCase(),
                                        style: GoogleFonts.lato(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantComplete.menus.drinks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: GestureDetector(
                              onTap: () => {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Coming Soon!'),
                                      // content: Text('Coming Soon'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              },
                              child: Container(
                                child: Card(
                                  elevation: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        restaurantComplete
                                            .menus.drinks[index].name
                                            .toUpperCase(),
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddReviewDialog(
                                    provider: provider,
                                    id: restaurantComplete.id),
                              );
                            },
                            child: const Text('Berikan Review'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: restaurantComplete.reviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        Review review = restaurantComplete.reviews[index];
                        return Card(
                            elevation: 3,
                            margin: EdgeInsets.all(15),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Oleh ${review.name.toUpperCase()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            review.date,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            review.review,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
