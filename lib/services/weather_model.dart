// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    // this.header,
    required this.provinces,
  });

  List<Province> provinces;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        // header: Header.fromJson(json["Header"]),
        provinces: List<Province>.from(
            json["Provinces"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "Header": header.toJson(),
        "Provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    required this.provinceNameTh,
    required this.sevenDaysForecast,
  });

  String provinceNameTh;
  List<SevenDaysForecast> sevenDaysForecast;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceNameTh: json["ProvinceNameTh"],
        sevenDaysForecast: List<SevenDaysForecast>.from(
            json["SevenDaysForecast"]
                .map((x) => SevenDaysForecast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ProvinceNameTh": provinceNameTh,
        "SevenDaysForecast":
            List<dynamic>.from(sevenDaysForecast.map((x) => x.toJson())),
      };
}

class SevenDaysForecast {
  SevenDaysForecast({
    required this.date,
    required this.weatherDescription,
  });

  String date;
  String weatherDescription;

  factory SevenDaysForecast.fromJson(Map<String, dynamic> json) =>
      SevenDaysForecast(
        date: json["Date"], //may need mapping?
        weatherDescription: json["WeatherDescription"],
      );

  Map<String, dynamic> toJson() => {
        "Date": date,
        "WeatherDescription": weatherDescription,
      };
}

// enum Date {
//   THE_1872022,
//   THE_1972022,
//   THE_2072022,
//   THE_2172022,
//   THE_2272022,
//   THE_2372022,
//   THE_2472022
// }

// final dateValues = EnumValues({
//   "18/7/2022": Date.THE_1872022,
//   "19/7/2022": Date.THE_1972022,
//   "20/7/2022": Date.THE_2072022,
//   "21/7/2022": Date.THE_2172022,
//   "22/7/2022": Date.THE_2272022,
//   "23/7/2022": Date.THE_2372022,
//   "24/7/2022": Date.THE_2472022
// }
// );

// enum WeatherDescription { EMPTY, WEATHER_STATE }
//
// final weatherDescriptionValues =
//     EnumValues({"ฝนไม่ตก": WeatherDescription.EMPTY, "ฝนฟ้าคะนอง": WeatherDescription.WEATHER_STATE});
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);

  // Map<T, String> get reverse {
  //   if (reverseMap == null) {
  //     reverseMap = map.map((k, v) => new MapEntry(v, k));
  //   }
  //   return reverseMap;
  // }
// }
