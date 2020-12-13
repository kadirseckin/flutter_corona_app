import 'dart:convert';

import 'models/corona_data.dart';
import 'package:http/http.dart' as http;

class VeriIslemleri{

  static Future<List<CoronaData>>tumVeriListesi=verileriGetir();

  static Future<List<CoronaData>> verileriGetir() async {
    String url =
        "https://raw.githubusercontent.com/ozanerturk/covid19-turkey-api/master/dataset/timeline.json";
    final response = await http.get(url);

    //json datasını mapa atıyoruz. Mapin key değerleri tarih value değerleri işte baska bir map ve ölüm,vaka vs tutuyor.
    final Map<String, dynamic> data = json.decode(response.body);

    //value değerlerini CoronaData çevirip listeye atadık.
    List<CoronaData> coronaList = [];
    data.forEach((key, value) {
      return coronaList.add(CoronaData.fromJson(value));
    });

    return coronaList;
  }
}