// To parse this JSON data, do
//
//     final coronaData = coronaDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_corona_app/main.dart';

Map<String, CoronaData> coronaDataFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, CoronaData>(k, CoronaData.fromJson(v)));

String coronaDataToJson(Map<String, CoronaData> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CoronaData {
  CoronaData({
    this.patients,
    this.totalPatients,
    this.deaths,
    this.totalDeaths,
    this.recovered,
    this.totalRecovered,
    this.totalIntubated,
    this.totalIntensiveCare,
    this.tests,
    this.totalTests,
    this.date,
    this.critical,
    this.pneumoniaPercent,
    this.cases,
  });

  String patients;
  String totalPatients;
  String deaths;
  String totalDeaths;
  String recovered;
  String totalRecovered;
  String totalIntubated;
  String totalIntensiveCare;
  String tests;
  String totalTests;
  String date;
  String critical;
  String pneumoniaPercent;
  String cases;

  factory CoronaData.fromJson(Map<String, dynamic> json) {

    return CoronaData(
    patients: json["patients"],
    totalPatients: json["totalPatients"],
    deaths: json["deaths"],
    totalDeaths: json["totalDeaths"],
    recovered: json["recovered"],
    totalRecovered: json["totalRecovered"],
    totalIntubated: json["totalIntubated"],
    totalIntensiveCare: json["totalIntensiveCare"],
    tests: json["tests"],
    totalTests: json["totalTests"],
    date: json["date"],
    critical: json["critical"],
    pneumoniaPercent: json["pneumoniaPercent"],
    cases: json["cases"] == null ? null : json["cases"],
  );
  }

  Map<String, dynamic> toJson() => {
    "patients": patients,
    "totalPatients": totalPatients,
    "deaths": deaths,
    "totalDeaths": totalDeaths,
    "recovered": recovered,
    "totalRecovered": totalRecovered,
    "totalIntubated": totalIntubated,
    "totalIntensiveCare": totalIntensiveCare,
    "tests": tests,
    "totalTests": totalTests,
    "date": date,
    "critical": critical,
    "pneumoniaPercent": pneumoniaPercent,
    "cases": cases == null ? null : cases,
  };
}
