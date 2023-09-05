import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:ticketing/UI/DailyWork.dart';
import 'package:ticketing/UI/Settings.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Models/DailyPermisionModel.dart';
import '../Models/NumTicketsModel.dart';
import '../Models/TicketPermisionModel.dart';
import '../Models/TicketsModel.dart';
import '../Models/chartModle.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'Notifications.dart';
import 'OpenTickets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   var _chartData;
   var _tooltipBehavior;

  @override
  void initState() {

    setAllowNotification();
    getpermisionTicket(context);
    getpermisionDailyWork(context);



    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var ThemP = Provider.of<Them>(context, listen: false);
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    print(    Provider.of<LoginProvider>(context, listen: false).getshowAllTicket().toString() +"  showAllTicketprovider"
    );
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedItemColor: HexColor(Globalvireables.white),
          unselectedItemColor: Colors.white,
          backgroundColor: HexColor(ThemP.getcolor()),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,),
              label: LanguageProvider.Llanguage('settings',),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: LanguageProvider.Llanguage('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: LanguageProvider.Llanguage('dailywork')),
          ],
          iconSize: 30 * unitHeightValue,
          unselectedFontSize: 12 * unitHeightValue,
          selectedFontSize: 16 * unitHeightValue,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          selectedIconTheme:
          IconThemeData(color: HexColor(Globalvireables.white)),
          onTap: _onItemTapped,
        ),
        backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // showProfile(context);
                            },
                            child: Container(
                              width: 55 * unitHeightValue,
                              height: 55 * unitHeightValue,
                              child: Image.asset(
                                "assets/persion2.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Text(
                              LanguageProvider.getLanguage() == "AR"
                                  ? Loginprovider.getnameA()
                                  : Loginprovider.getnameE(),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 19 * unitHeightValue,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              // print("name "+Loginprovider.getnameA());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notifications()),
                                );
                            },
                            child: Icon(
                              Icons.notifications,
                              color: HexColor(ThemP.getcolor()),
                              size: 33 * unitHeightValue,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          alignment: LanguageProvider.Align(),
                          child: Text(
                              LanguageProvider.Llanguage("AlEsraaHospital"),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 22 * unitHeightValue,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),

                      SizedBox(height: 10,),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child:

    FutureBuilder(
    future: getNumTickets(
    context,
    Loginprovider.getuserId().toString()
    ),
    builder: (BuildContext context, AsyncSnapshot<List<NumTicketsModel>> snapshot) {
    if (snapshot.hasData) {
    List<NumTicketsModel>? numticketslist = snapshot.data;

    return  Row(
                              children: [
Spacer(),
                              Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: HexColor(ThemP.getcolor())),
                                          borderRadius: BorderRadius.circular(15.0),

                                        ),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4.5,
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            4.5,
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(numticketslist![0].closedTicket.toString(),
                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    color: HexColor(ThemP.getcolor()),
                                                    fontSize: 30 * unitHeightValue,
                                                    fontWeight: FontWeight.w900
                                                ))
,

                                            Text(
                                                LanguageProvider.Llanguage("ClosedTicket"),


                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    color: HexColor(ThemP.getcolor()),
                                                    fontSize: 11 * unitHeightValue,
                                                    fontWeight: FontWeight.w700
                                                ),

                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                    ],
                                  ),
                                Spacer(),
                                Spacer(),
                                Spacer(),

                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: HexColor(ThemP.getcolor())),
                                        borderRadius: BorderRadius.circular(15.0),

                                      ),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          4.5,
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          4.5,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Text(numticketslist![0].openTicket.toString(),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  color: HexColor(ThemP.getcolor()),
                                                  fontSize: 30 * unitHeightValue,
                                                  fontWeight: FontWeight.w900
                                              ))
                                          ,

                                          Text(
                                            LanguageProvider.Llanguage("openTicket"),


                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                color: HexColor(ThemP.getcolor()),
                                                fontSize: 11 * unitHeightValue,
                                                fontWeight: FontWeight.w700
                                            ),

                                          ),
                                          Spacer(),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                  ],
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),

                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: HexColor(ThemP.getcolor())),
                                        borderRadius: BorderRadius.circular(15.0),

                                      ),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          4.5,
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width /
                                          4.5,
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Text(numticketslist![0].todayTicket.toString(),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  color: HexColor(ThemP.getcolor()),
                                                  fontSize: 30 * unitHeightValue,
                                                  fontWeight: FontWeight.w900
                                              ))
                                          ,

                                          Text(
                                            LanguageProvider.Llanguage("todayTicket"),


                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                color: HexColor(ThemP.getcolor()),
                                                fontSize: 11 * unitHeightValue,
                                                fontWeight: FontWeight.w700
                                            ),

                                          ),
                                          Spacer(),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                  ],
                                ),
                                Spacer(),


                              ],
                            );}
    else return
        CircularProgressIndicator();

    }
                          ),
                        ),
                      ),


                          SizedBox(height: 20,),

                       Container(
                        alignment: LanguageProvider.Align(),
                        child: Text(
                            LanguageProvider.Llanguage("hourdailywork"),
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                color: HexColor(Globalvireables.black2),
                                fontSize: 16 * unitHeightValue,
                                fontWeight: FontWeight.w700)),
                      ),

                          FutureBuilder(
                          future: getcharTickets(
    context,
    Loginprovider.getuserId().toString()
    ),
    builder: (BuildContext context, AsyncSnapshot<List<chartModle>> snapshot) {
    if (snapshot.hasData) {
    List<chartModle>? numticketslist = snapshot.data;

    return
    SizedBox(
    height: 200,
        child: Center(
        child: Container(
        child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: ''), //Chart title.
        legend: Legend(isVisible: false), // Enables the legend.
        series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
        dataSource: [
          SalesData(DateTime.now().subtract(Duration(days:0)).toString().substring(5,10), numticketslist![0].d),
          SalesData(DateTime.now().subtract(Duration(days:1)).toString().substring(5,10), numticketslist![0].d1),
          SalesData(DateTime.now().subtract(Duration(days:2)).toString().substring(5,10), numticketslist![0].d2),
          SalesData(DateTime.now().subtract(Duration(days:3)).toString().substring(5,10), numticketslist![0].d3),
          SalesData(DateTime.now().subtract(Duration(days:4)).toString().substring(5,10), numticketslist![0].d4),
        ],
        xValueMapper: (SalesData sales, _) => sales.year,
        yValueMapper: (SalesData sales, _) => sales.sales,
        dataLabelSettings: DataLabelSettings(isVisible: false) // Enables the data label.
        )
        ]
        )
        )
        ),
    );

    }else return Container(

    );}),

                      SizedBox(height: 20,),


                    Row(children: [


                      Container(
                        alignment: LanguageProvider.Align(),
                        child: Text(
                            LanguageProvider.Llanguage("openTicket"),
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                color: HexColor(Globalvireables.black2),
                                fontSize: 16 * unitHeightValue,
                                fontWeight: FontWeight.w700)),
                      ),

                      Spacer(),
    GestureDetector(
    onTap: () {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OpenTickets()),
      );
    },
                        child: Container(
                          alignment: LanguageProvider.Align(),
                          child: Text(
                              LanguageProvider.Llanguage("SeeAll"),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 16 * unitHeightValue,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ),

                    ],),

                      SizedBox(height: 20,),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: FutureBuilder(
                          future: gettickets(context, Loginprovider.getuserId().toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TicketsModel>> snapshot) {
                            if (snapshot.hasData) {
                              List<TicketsModel>? Doctors = snapshot.data;
                              return ListView(
                                children: Doctors!
                                    .map((TicketsModel Doctor) => SizedBox(
                                    child: Row(children: [
                                      Card(

                                        color: HexColor(ThemP.getcolor()),

                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          // if you need this
                                          side: BorderSide(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height,
                                            //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                          ),
                                        ),

child: Container(

  decoration: new BoxDecoration(
      color: HexColor(ThemP.getcolor()),

      borderRadius: BorderRadius.horizontal(
          left: Radius.elliptical(
              MediaQuery.of(context).size.width, 100.0))),
    width:  MediaQuery.of(context).size.width/5,
    height:  MediaQuery.of(context).size.width/5,
    child: Card(
      color: HexColor(ThemP.getcolor()),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(10),
        // if you need this
        side: BorderSide(
          width: MediaQuery.of(context)
              .size
              .height,
          //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
        ),
      ),

      child: Column(
        children: [
          Spacer(),
          Spacer(),
          Text(Doctor.TicketDate.toString().substring(4,6),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.white),
                  fontSize: 25 * unitHeightValue,
                  fontWeight: FontWeight.w900)),
          Text(Doctor.TicketDate.toString().substring(0,3),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.white),
                  fontSize: 16 * unitHeightValue,
                  fontWeight: FontWeight.w700)),
          Spacer(),
          Spacer(),

        ],
      ),



    )
),


                                      ),

                                      Column(children: [

                                        Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                          child: Text(Doctor.custNameA.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  color: HexColor(Globalvireables.black),
                                                  fontSize: 15 * unitHeightValue,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                  Container(
                                      width: MediaQuery.of(context).size.width/1.5,
                                          child: Text(Doctor.IssueDescr.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  color: HexColor(Globalvireables.black),
                                                  fontSize: 14 * unitHeightValue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],)


                                    ],)))
                                    .toList(),
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }




  Future<List<NumTicketsModel>> getNumTickets(
      BuildContext context, String userid) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    Uri postsURL = Uri.parse(Globalvireables.NumofticketsURL);
    try {
      var LoginP = Provider.of<LoginProvider>(context, listen: false);


      var map = new Map<String, dynamic>();
      map['userid'] = userid;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);

        List<NumTicketsModel> NumTickets = body
            .map(
              (dynamic item) => NumTicketsModel.fromJson(item),
        )
            .toList();

        return NumTickets;
      } else {
        throw "Unable to retrieve Appoiments." + res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('بيانات المواعي'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Appoiments.";
  }


   Future<List<chartModle>> getcharTickets(


       BuildContext context, String userid) async {

     print( "trrttr  "+DateTime.now().weekday.toString());


     var LanguageProvider = Provider.of<Language>(context, listen: false);
     Uri postsURL = Uri.parse(Globalvireables.chartticketsURL);
     try {
       var LoginP = Provider.of<LoginProvider>(context, listen: false);


       var map = new Map<String, dynamic>();
       map['userid'] = userid;

       http.Response res = await http.post(
         postsURL,
         body: map,
       );

       if (res.statusCode == 200) {

         List<dynamic> body = jsonDecode(res.body);

         print("fff  "+body.toString());
         List<chartModle> NumTickets = body
             .map(
               (dynamic item) => chartModle.fromJson(item),
         )
             .toList();

         return NumTickets;
       } else {

         throw "Unable to retrieve Appoiments." + res.statusCode.toString();

       }
     } catch (e) {
       await showDialog(
         context: context,
         builder: (context) => new AlertDialog(
           title: new Text('بيانات المواعي'),
           content: Text(e.toString()),
           actions: <Widget>[],
         ),
       );
     }
     throw "Unable to retrieve Appoiments.";
   }



   Future<List<TicketsModel>> gettickets(BuildContext context,String useris) async {
     Uri postsURL =
     Uri.parse(Globalvireables.ticketURL);
     try {
       var map = new Map<String, dynamic>();
       map['userid'] = useris;

       http.Response res = await http.post(
         postsURL,
         body: map,

       );

       if (res.statusCode == 200) {
         print("Profile" + res.body.toString());

         List<dynamic> body = jsonDecode(res.body);

         List<TicketsModel> Doctors = body
             .map(
               (dynamic item) => TicketsModel.fromJson(item),
         )
             .toList();

         return Doctors;
       } else {
         throw "Unable to retrieve Profile.";
       }
     } catch (e) {
       await showDialog(
         context: context,
         builder: (context) =>
         new AlertDialog(
           title: new Text('بيانات المريض'),
           content: Text(e.toString()),
           actions: <Widget>[],
         ),
       );
     }

     throw "Unable to retrieve Profile.";
   }

   _onItemTapped(int index) {
     if(index != 1){
       setState(() {
         selectedIndex = index;
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => nav[index]),);
       });}
   }

   int selectedIndex = 1;

   final List<Widget> nav = [
     Settings(),
     Home(),
     DailyWork(),
   ];




   ////////////////////


   Future<List<TicketPermisionModel>> getpermisionTicket(BuildContext context) async {
     Uri postsURL = Uri.parse(Globalvireables.permTicket);
     var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
     var map = new Map<String, dynamic>();
     map['userid'] = Loginprovider.getuserId().toString();

     try {
       http.Response res = await http.post(
         postsURL,
         body: map,
       );

       print("iiiiinputtecct" + res.body.toString());


       if (res.statusCode == 200) {
         print("Profileticket" + map.toString());

         List<dynamic> body = jsonDecode(res.body);

         List<TicketPermisionModel> Doctors = body
             .map((dynamic item) => TicketPermisionModel.fromJson(item),).toList();

         Loginprovider.setopenticketP(Doctors[0].openn.toString());
         Loginprovider.setassignticketP(Doctors[0].assign.toString());

         Loginprovider.setshowAllTicket(Doctors[0].showAllTicket.toString());
         Loginprovider.setshowAllDaily(Doctors[0].showAllDaily.toString());


         return Doctors;
       } else {
         throw "Unable to retrieve Profile.";
       }
     } catch (e) {
       await showDialog(
         context: context,
         builder: (context) => new AlertDialog(
           title: new Text('بيانات المريض'),
           content: Text(e.toString()),
           actions: <Widget>[],
         ),
       );
     }

     throw "Unable to retrieve Profile.";
   }


   Future<List<DailyPermisionModel>> getpermisionDailyWork(BuildContext context) async {
     Uri postsURL = Uri.parse(Globalvireables.permDaily);
     var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

     var map = new Map<String, dynamic>();
     map['userid'] = Loginprovider.getuserId();

     try {
       http.Response res = await http.post(
         postsURL,
         body: map,
       );

       if (res.statusCode == 200) {
         print("Profileeee" + res.body.toString());

         List<dynamic> body = jsonDecode(res.body);

         List<DailyPermisionModel> Doctors = body
             .map(
               (dynamic item) => DailyPermisionModel.fromJson(item),
         )
             .toList();


         Loginprovider.setadddailyworkP(Doctors[0].addd.toString());



         return Doctors;
       } else {
         throw "Unable to retrieve Profile.";
       }
     } catch (e) {
       await showDialog(
         context: context,
         builder: (context) => new AlertDialog(
           title: new Text('بيانات المريض'),
           content: Text(e.toString()),
           actions: <Widget>[],
         ),
       );
     }




     throw "Unable to retrieve Profile.";
   }


/////////////


  setAllowNotification() async {
    var loginP = Provider.of<LoginProvider>(context, listen: false);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loginP.setAllowN((await prefs.getBool('allowN'))??false);

  }

}
   class SalesData {
   SalesData(this.year, this.sales);
   final String year;
   final double? sales;
   }




