import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oggy/models/restaurants_model.dart';
import 'package:oggy/views/pages/error_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Api extends GetxController {
  List<Cities>? cities;
  List<Localities>? localities;
  List<Restaurants>? restaurants;

  String? defCityId;
  String? defCityName;
  String? defLocalityName;
  late int defIndex;
  String defImage =
      'https://res.cloudinary.com/swiggy/image/upload/llokcsxws7rtmqrb3o1w';

  late dynamic jsonData;

  getCities() async {
    var client = http.Client();
    var url = Uri.parse("https://oggy.co.in/staging/api_city.php");
    var res = await client.get(url);

    if (res.statusCode == 200) {
      var json = res.body;
      cities = citiesFromJson(json);
      if (cities!.length > 1) {
        defCityId = cities![1].id;
        defCityName = cities![1].name;
      } else {
        defCityId = cities![0].id;
        defCityName = cities![0].name;
      }
      await getLocalities(defCityId);
    } else {
      Get.to(() => const ErrorPage());
    }
  }

  getLocalities(String? cityId) async {
    var client = http.Client();
    var url =
        Uri.parse("https://oggy.co.in/staging/api_localities.php?city=$cityId");
    var res = await client.get(url);

    if (res.statusCode == 200) {
      var json = res.body;
      localities = localitiesFromJson(json);
    } else {
      Get.to(() => const ErrorPage());
    }
  }

  getRestaurants(String? cityId, String? localityId) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://oggy.co.in/staging/api_restaurants.php?city=$cityId&locality=$localityId");
    var res = await client.get(url);

    if (res.statusCode == 200) {
      var json = res.body;
      restaurants = restaurantsFromJson(json);
    } else {
      Get.to(() => const ErrorPage());
    }
  }
}

class MapUtils {
  MapUtils._();

  static void launchMapsUrl(String? lat, String? lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
