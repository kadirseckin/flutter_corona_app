import 'package:flutter/material.dart';
import 'package:flutter_corona_app/veri_islemleri.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:pie_chart/pie_chart.dart';
import 'models/corona_data.dart';

class KoronaGrafik extends StatefulWidget {
  @override
  _KoronaGrafikState createState() => _KoronaGrafikState();
}

class _KoronaGrafikState extends State<KoronaGrafik> {
  Future<List<CoronaData>> gelenVeriListe = VeriIslemleri.tumVeriListesi;

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gelenVeriListe,
      builder: (context, AsyncSnapshot<List<CoronaData>> gelenListe) {
        if (gelenListe.hasData) {
          //ölüm sayilarininin listesi line table için
          List<double> olumSayilari=[];
          for(int i=0;i<gelenListe.data.length-1;i++){
            olumSayilari.add(double.parse(gelenListe.data[i].deaths));
         }

          //pie chart için data map
          Map<String, double> dataMap = {
            "Günlük vaka":
                double.parse(gelenListe.data[gelenListe.data.length - 1].cases),
            "Günlük iyileşme": double.parse(
                gelenListe.data[gelenListe.data.length - 1].recovered),
          };
          return Container(
            child: Column(
              children: [

                Expanded(
                  child:PieChart(
                    dataMap: dataMap,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    chartValuesOptions: ChartValuesOptions(
                      decimalPlaces: 0,
                    ),
                    colorList: [Colors.red.shade400,Colors.green.shade400],


                  ),
                ),
                Expanded(
                  child:Container(
                    padding: EdgeInsets.all(10),
                    height: 50,

                    child: Sparkline(
                      data: olumSayilari,
                      pointsMode: PointsMode.all,
                      pointSize: 2,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text("Covid-19 vefat grafiği",style: TextStyle(fontSize: 18,backgroundColor: Colors.grey.shade200),),
                ),


              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
