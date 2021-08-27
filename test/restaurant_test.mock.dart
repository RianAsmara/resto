import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:resto_apps/data/api/api_service.dart' as _i4;
import 'package:resto_apps/data/model/restaurant.dart' as _i2;
import 'package:resto_apps/data/model/review.dart' as _i3;

// ignore: camel_case_types
class _FakeRestaurantList_0 extends _i1.Fake implements _i2.RestaurantList {}

// ignore: camel_case_types
class _FakeRestaurantDetail_1 extends _i1.Fake implements _i2.RestaurantDetail {
}

// ignore: camel_case_types
class _FakeRestaurantSearch_2 extends _i1.Fake implements _i2.RestaurantSearch {
}

// ignore: camel_case_types
class _FakeResponseReview_3 extends _i1.Fake implements _i3.ResponseReview {}

class MockApiService extends _i1.Mock implements _i4.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.RestaurantList> restaurantList() =>
      (super.noSuchMethod(Invocation.method(#restaurantList, []),
              returnValue:
                  Future<_i2.RestaurantList>.value(_FakeRestaurantList_0()))
          as _i5.Future<_i2.RestaurantList>);
  @override
  _i5.Future<_i2.RestaurantDetail> restaurantDetail(String? id) =>
      (super.noSuchMethod(Invocation.method(#restaurantDetail, [id]),
              returnValue:
                  Future<_i2.RestaurantDetail>.value(_FakeRestaurantDetail_1()))
          as _i5.Future<_i2.RestaurantDetail>);
  @override
  _i5.Future<_i2.RestaurantSearch> restaurantSearch(String? query) =>
      (super.noSuchMethod(Invocation.method(#restaurantSearch, [query]),
              returnValue:
                  Future<_i2.RestaurantSearch>.value(_FakeRestaurantSearch_2()))
          as _i5.Future<_i2.RestaurantSearch>);
  @override
  _i5.Future<_i3.ResponseReview> postReview(_i3.Review? review) =>
      (super.noSuchMethod(Invocation.method(#postReview, [review]),
              returnValue:
                  Future<_i3.ResponseReview>.value(_FakeResponseReview_3()))
          as _i5.Future<_i3.ResponseReview>);
  @override
  String toString() => super.toString();
}
