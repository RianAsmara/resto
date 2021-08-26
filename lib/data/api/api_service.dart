import 'dart:convert';
import 'package:resto_apps/data/model/restaurant.dart';
import 'package:resto_apps/data/model/review.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed To Load Restaurant List!');
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed To Load Restaurant Detail!');
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed To Load Search Result!');
    }
  }

  Future<ResponseReview> postReview(Review review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ResponseReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed To Add Review!');
    }
  }
}
