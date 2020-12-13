import 'package:flutter/material.dart';
import 'package:flutter_corona_app/corona_tablo.dart';
import 'package:flutter_corona_app/corona_veri_ara.dart';
import 'package:flutter_corona_app/grafikler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/corona_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int secilen_index = 0;

  List<Widget> tumSayfalar;
  CoronaTablo koronaTabloSayfa;
  KoronaGrafik koronaGrafik;
  CoronaVeriAra coronaVeriAra;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    koronaTabloSayfa=CoronaTablo();
    koronaGrafik=KoronaGrafik();
    coronaVeriAra=CoronaVeriAra();
    tumSayfalar=[koronaTabloSayfa,koronaGrafik,coronaVeriAra];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationMenu(),
      appBar: AppBar(
        title: Text("Türkiye COVID-19 Verileri"),

      ),
      body: tumSayfalar[secilen_index],
    );
  }

  BottomNavigationBar bottomNavigationMenu() {
    return BottomNavigationBar(
      currentIndex: secilen_index,
      onTap: (secilen) {
        setState(() {
          secilen_index = secilen;
        });

        debugPrint(secilen.toString());
      },
      backgroundColor: Colors.grey.shade300,
      selectedItemColor: Colors.green.shade900,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_rounded), label: "Güncel veri", backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "İstatistikler",
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Ara",
            backgroundColor: Colors.green),
      ],

      //3ten fazla eleman varsa shitfing moda geçer gözükmesi için fixed yapabiliriz
      //eğer shifted kalacaksa hepsine background color vermeliyiz.
      type: BottomNavigationBarType.fixed,
    );
  }
}
