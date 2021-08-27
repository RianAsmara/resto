import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_apps/data/api/api_service.dart';
import 'package:resto_apps/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:resto_apps/utils/result_state.dart';
import 'package:resto_apps/widget/custom_card.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.grey.shade700,
  );
  Widget _appBarTitle = new Text(
    'Restaurants App',
    style: GoogleFonts.poppins(
        fontWeight: FontWeight.w700, fontSize: 25, color: Colors.grey.shade700),
  );
  late RestaurantProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            onPressed: _searchPressed,
            icon: _searchIcon,
          ),
        ],
      ),
      body: _buildRestaurantItem(context),
    );
  }

  Widget _buildRestaurantItem(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) =>
            RestaurantProvider(apiService: ApiService(), type: 'list', id: ''),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            provider = state;
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CustomCard(restaurant: restaurant);
                },
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text("Tidak ada koneksi Internet."));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
          color: Colors.black,
        );
        this._appBarTitle = new TextField(
          autofocus: true,
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          onChanged: (value) => {
            if (value != '')
              {
                provider.fetchRestaurantSearch(value),
              }
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Restaurant Apps');
        provider.fetchAllRestaurant();
        _filter.clear();
      }
    });
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    provider.fetchAllRestaurant();
    _filter.clear();
  }
}
