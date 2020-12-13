import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_corona_app/veri_islemleri.dart';
import 'models/corona_data.dart';
import 'package:http/http.dart' as http;

class CoronaTablo extends StatefulWidget {
  @override
  _CoronaTabloState createState() => _CoronaTabloState();
}

class _CoronaTabloState extends State<CoronaTablo> {



  @override
  Widget build(BuildContext context) {
    return KoronaTablo();
  }

  Widget KoronaTablo() {
    return FutureBuilder(
      future: VeriIslemleri.tumVeriListesi,
      builder: (context, AsyncSnapshot<List<CoronaData>> gelenListe) {
        if (gelenListe.hasData) {
          // return Text(gelenListe.data[gelenListe.data.length-1].deaths);
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: (10)),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 35,
                    color: Colors.yellow.shade800,
                    child: Center(
                      child: Text(
                        gelenListe.data[gelenListe.data.length - 1].date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  tabloEleman(context, "TEST SAYISI",
                      gelenListe.data[gelenListe.data.length - 1].tests),
                  tabloEleman(context, "HASTA SAYISI",
                      gelenListe.data[gelenListe.data.length - 1].patients),
                  tabloEleman(context, "VEFAT SAYISI",
                      gelenListe.data[gelenListe.data.length - 1].deaths),
                  tabloEleman(context, "İYİLEŞEN HASTA SAYISI",
                      gelenListe.data[gelenListe.data.length - 1].recovered),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "TOPLAM HASTA SAYISI",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    gelenListe.data[gelenListe.data.length - 1].totalPatients,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "TOPLAM ÖLÜM SAYISI",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    gelenListe.data[gelenListe.data.length - 1].totalDeaths,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "TOPLAM İYİLEŞME SAYISI",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    gelenListe
                        .data[gelenListe.data.length - 1].totalRecovered,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }



  Card tabloEleman(BuildContext context, String isim, String veri) {
    return Card(
      elevation: 8,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 30,
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                isim,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 45,
            color: Colors.grey.shade600,
            child: Center(
              child: Text(
                veri,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
