import 'dart:convert';

List<Cities> citiesFromJson(String str) =>
    List<Cities>.from(json.decode(str).map((x) => Cities.fromJson(x)));

String citiesToJson(List<Cities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cities {
  Cities({
    required this.name,
    required this.id,
  });

  String name;
  String id;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

List<Localities> localitiesFromJson(String str) =>
    List<Localities>.from(json.decode(str).map((x) => Localities.fromJson(x)));

String localitiesToJson(List<Localities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Localities {
  Localities({
    required this.title,
    required this.id,
  });

  String title;
  String id;

  factory Localities.fromJson(Map<String, dynamic> json) => Localities(
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
      };
}

List<Restaurants> restaurantsFromJson(String str) => List<Restaurants>.from(
    json.decode(str).map((x) => Restaurants.fromJson(x)));

String restaurantsToJson(List<Restaurants> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurants {
  Restaurants({
    required this.id,
    required this.name,
    required this.cuisines,
    required this.offers,
    required this.images,
    required this.orgImg,
    required this.timing,
    required this.remoteSite,
    required this.remoteUrl,
    required this.remoteId,
    required this.scrapUrl,
    required this.description,
    required this.fssai,
    required this.rating,
    required this.city,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    required this.locality,
    required this.address,
    required this.phoneNumbers,
    required this.modified,
  });

  String id;
  String name;
  List<String> cuisines;
  List<Offer> offers;
  List<dynamic> images;
  String orgImg;
  List<String> timing;
  String remoteSite;
  String remoteUrl;
  String remoteId;
  String scrapUrl;
  String description;
  String fssai;
  String rating;
  String city;
  String cityId;
  String latitude;
  String longitude;
  String locality;
  String address;
  List<String> phoneNumbers;
  DateTime modified;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        cuisines: json["cuisines"] != null
            ? List<String>.from(json["cuisines"].map((x) => x)).toList()
            : [],
        offers: json["offers"] != null
            ? List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x)))
                .toList()
            : [],
        images: json["images"] != null
            ? List<dynamic>.from(json["images"].map((x) => x)).toList()
            : [],
        orgImg: json["org_img"],
        timing: json["timing"] != null
            ? List<String>.from(json["timing"].map((x) => x)).toList()
            : [],
        remoteSite: json["remote_site"],
        remoteUrl: json["remote_url"],
        remoteId: json["remote_id"],
        scrapUrl: json["scrap_url"],
        description: json["description"],
        fssai: json["fssai"],
        rating: json["rating"],
        city: json["city"],
        cityId: json["city_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        locality: json["locality"],
        address: json["address"],
        phoneNumbers: json["phone_numbers"] != null
            ? List<String>.from(json["phone_numbers"].map((x) => x)).toList()
            : [],
        modified: DateTime.parse(json["modified"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cuisines": List<dynamic>.from(cuisines.map((x) => x)),
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
        "org_img": orgImg,
        "timing": List<dynamic>.from(timing.map((x) => x)),
        "remote_site": remoteSite,
        "remote_url": remoteUrl,
        "remote_id": remoteId,
        "scrap_url": scrapUrl,
        "description": description,
        "fssai": fssai,
        "rating": rating,
        "city": city,
        "city_id": cityId,
        "latitude": latitude,
        "longitude": longitude,
        "locality": locality,
        "address": address,
        "phone_numbers": List<dynamic>.from(phoneNumbers.map((x) => x)),
        "modified": modified.toIso8601String(),
      };
}

class Offer {
  String title;
  String code;
  String description;

  Offer({
    required this.title,
    required this.code,
    required this.description,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        title: json["title"] ?? '',
        code: json["code"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "description": description,
      };
}
