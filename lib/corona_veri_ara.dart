import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_corona_app/veri_islemleri.dart';
import 'models/corona_data.dart';

class CoronaVeriAra extends StatefulWidget {
  @override
  _CoronaVeriAraState createState() => _CoronaVeriAraState();
}

class _CoronaVeriAraState extends State<CoronaVeriAra> {

  @override
  String secilenTarih="";

  @override
  Widget build(BuildContext context) {
    return KoronaTablo();
  }

  Widget KoronaTablo() {
    return FutureBuilder(
      future: VeriIslemleri.tumVeriListesi,
      builder: (context, AsyncSnapshot<List<CoronaData>> gelenListe) {
        if (gelenListe.hasData) {
          //jsondan gelen stringi parçalayı datetime formatına uygun hale getirdik "/" formatında
          String gelenTarih=gelenListe.data.last.date;
          List<String> tarihParcala=gelenTarih.split("/");
          DateTime sonTarih=new DateTime(int.parse(tarihParcala[2]),int.parse(tarihParcala[1]),int.parse(tarihParcala[0]));
          int gelenIndex;

          //bu sayede secilen tarihe göre doğru verileri getireceğiz bu index ile
          for(int i=0;i<gelenListe.data.length;i++){
            if(gelenListe.data[i].date==secilenTarih){
              gelenIndex=i;
            }
          }




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
                        secilenTarih,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  tabloEleman(context, "TEST SAYISI",
                      gelenIndex!=null?gelenListe.data[gelenIndex].tests : " "),
                  tabloEleman(context, "HASTA SAYISI",
                      gelenIndex!=null?gelenListe.data[gelenIndex].patients:" "),
                  tabloEleman(context, "VEFAT SAYISI",
                      gelenIndex!=null?gelenListe.data[gelenIndex].deaths:" "),
                  tabloEleman(context, "İYİLEŞEN HASTA SAYISI",
                      gelenIndex!=null?gelenListe.data[gelenIndex].recovered:" "),

                  SizedBox(height: 10,),
                  FlatButton(
                      onPressed: (){
                         return
                           showDatePicker
                             (context: context, initialDate: sonTarih, firstDate: new DateTime(2020,3,11), lastDate:sonTarih).
                           then((value) {
                             setState(() {
                               secilenTarih=formatDate(value, [dd, '/', mm, '/', yyyy]);
                               debugPrint(secilenTarih.toString());
                             });
                           } );

                      },
                      child: Text("Tarihe göre ara",style: TextStyle(color: Colors.white),),
                    color: Colors.purple.shade400,

                  )

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
