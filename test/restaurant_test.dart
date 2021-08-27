import 'package:flutter_test/flutter_test.dart';
import 'package:resto_apps/data/api/api_service.dart';
import 'package:resto_apps/data/model/restaurant.dart';
import 'package:resto_apps/data/model/review.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_test.mock.dart';

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Apps Test', () {
    late Restaurant restaurant;
    late RestaurantComplete restaurantComplete;
    late ApiService apiService;

    setUp(() {
      apiService = MockApiService();
      restaurant = Restaurant(
        id: "0131ufsjf",
        name: "Nasi Balap",
        description: "Nasi Balap Description",
        pictureId: "12",
        city: "Lombok",
        rating: 5,
      );
      restaurantComplete = RestaurantComplete(
        id: "01231usfau",
        name: "Nasi Balap Puyung",
        description: "Nasi Balap Description",
        city: "Mataram",
        address: "Jl. Raden Puguh Puyung. Jonggat",
        pictureId: "11",
        categories: [
          Category(name: "Indonesia"),
          Category(name: "Industrial"),
        ],
        menus: Menus(
          foods: [
            Category(name: "Nasi Balap"),
            Category(name: "Nasi Lindung"),
          ],
          drinks: [
            Category(name: "Es Kelapa Muda"),
            Category(name: "Es Susu"),
          ],
        ),
        rating: 4.7,
        reviews: [
          Review(
            id: "123012lakdf",
            name: "John",
            review: "Murah, Enak, Pedas",
            date: "26 Agustus 2021",
          ),
          Review(
            id: "018241sdkf",
            name: "Doe",
            review: "Pecinta Pedas Wajib Datang!",
            date: "26 Agustus 2021",
          ),
        ],
      );
    });

    test('Should success parsing to JSON', () {
      var result = Restaurant.fromJson(restaurant.toJson());

      expect(result.name, restaurant.name);
    });

    test("Should return restaurant detail from endpoint", () async {
      when(apiService.restaurantDetail(restaurant.id)).thenAnswer((_) async {
        return RestaurantDetail(
          error: false,
          message: 'success',
          restaurant: restaurantComplete,
        );
      });

      expect(await apiService.restaurantDetail(restaurant.id),
          isA<RestaurantDetail>());
    });
  });
}
