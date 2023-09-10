import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:ticketing/UI/Settings.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Models/AllusersModel.dart';
import '../Models/DailyWorkModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'AddDailyWork.dart';
import 'Home.dart';
import 'package:intl/intl.dart';

import 'OpenTicket.dart';

class DailyWork extends StatefulWidget {
  @override
  State<DailyWork> createState() => _DailyWorkState();
}

class _DailyWorkState extends State<DailyWork> {
  @override
  void initState() {
    //setsearch(context);
    enableadddaily=Provider.of<LoginProvider>(context, listen: false).getadddailyworkP().toString();

    super.initState();
  }
  var enableadddaily='';
var userselected='';
  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    DailyWork(),
  ];
  TextEditingController dateinputC = TextEditingController();
  TextEditingController searchusercontroller = TextEditingController();

  var state = false;
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          floatingActionButton: enableadddaily=='true'?SizedBox(
            width: MediaQuery.of(context).size.width/4,
            child: FloatingActionButton(

              backgroundColor: HexColor(ThemP.color),
              child: Icon(Icons.add,color: Colors.white,), onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddDailyWork()),
              );


            },
            ),
          ):null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            key: key,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: LanguageProvider.Llanguage('settings')),
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('dailywork'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Directionality(
            textDirection: LanguageProvider.getDirection(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor((Globalvireables.secondcolor)),
                    HexColor((ThemP.getcolor()))
                  ],
                  stops: stops,
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(29.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(29.0)),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(
                            child: TextField(
                              onChanged: (content) {
                                setState(() {

                                });
                              },
                              controller: dateinputC, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,color: HexColor(
                                    ThemP.getcolor()),size: 27*unitHeightValue,),
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      dateinputC.text = '';
                                      userselected='';

                                      setState(() {

                                      });

                                    },
                                    child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty||dateinputC.text.toString()==LanguageProvider.Llanguage('Search')
                                        ? null
                                        : Icons.cancel)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18,
                                    bottom: 18,
                                    right: 20,
                                    left: 20),
                                fillColor:
                                HexColor(Globalvireables.white),
                                filled: true,
                                hintText: LanguageProvider.Llanguage(
                                    "Search"),
                              ),
                              //a  readOnly: true,  //set it true, so that user will not able to edit text
                              onTap: () async {


                                if(Loginprovider.getshowAllDaily().toString()=='true'){


                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  1.4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.3,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: SizedBox(
                                                      child: Text(
                                                          LanguageProvider.Llanguage('users'),
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                              ArabicFont
                                                                  .tajawal,
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .black2),
                                                              fontSize: 18 *
                                                                  unitHeightValue,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700)),
                                                    ),
                                                  ),
                                                  Divider(
                                                      thickness: 1.0,
                                                      color: Colors.grey),
                                                  SizedBox(
                                                    child: TextField(
                                                      onChanged: (content) {
                                                        setState(() {});
                                                      },
                                                      controller:
                                                      searchusercontroller,
                                                      //editing controller of this TextField
                                                      decoration:
                                                      InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: HexColor(
                                                              ThemP.getcolor()),
                                                          size: 27 *
                                                              unitHeightValue,
                                                        ),
                                                        suffixIcon:
                                                        GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                searchusercontroller
                                                                    .text = '';
                                                              });
                                                            },
                                                            child: Icon(
                                                                null
                                                            )),
                                                        border:
                                                        OutlineInputBorder(),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width: 2.0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width: 2.0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0)),
                                                        contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 18,
                                                            right: 20,
                                                            left: 20),
                                                        fillColor: HexColor(
                                                            Globalvireables
                                                                .white),
                                                        filled: true,
                                                        hintText:
                                                        LanguageProvider
                                                            .Llanguage(
                                                            "Search"),
                                                      ),
                                                      //a  readOnly: true,  //set it true, so that user will not able to edit text
                                                      onTap: () async {
                                                        setState(() {});


                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                        2.8,
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        1,
                                                    child: FutureBuilder(
                                                      future:
                                                      getallusers(context,''),
                                                      builder: (BuildContext
                                                      context,
                                                          AsyncSnapshot<
                                                              List<
                                                                  AllusersModel>>
                                                          snapshot) {
                                                        if (snapshot.hasData) {
                                                          List<AllusersModel>?
                                                          Visits =
                                                              snapshot.data;

                                                          List<AllusersModel>? search = Visits!
                                                              .where((element) => element
                                                              .namea
                                                              .toString()
                                                              .contains(
                                                              searchusercontroller
                                                                  .text
                                                                  .toString()))
                                                              .toList();

                                                          return ListView(
                                                            children: search!
                                                                .map(
                                                                    (AllusersModel
                                                                v) =>
                                                                    Column(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {


                                                                            dateinputC.text = v.namea.toString();
                                                                            userselected=v.id.toString();
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: SizedBox(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      child: Text(
                                                                                        textAlign: TextAlign.right,
                                                                                        v.namea.toString(),
                                                                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                    ),
                                                                                    Spacer(),
                                                                                    Container(
                                                                                      child: Text(
                                                                                        textAlign: TextAlign.center,
                                                                                        v.id.toString(),
                                                                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ))
                                                                .toList(),
                                                          );
                                                        } else {
                                                          return Center(
                                                              child:
                                                              CircularProgressIndicator());
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Align(
                                                    alignment:
                                                    Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          4,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              ThemP.getcolor()),
                                                        ),
                                                        child: Text(
                                                          LanguageProvider
                                                              .Llanguage(
                                                              'cancel'),
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                              ArabicFont
                                                                  .tajawal,
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .white),
                                                              fontSize: 14 *
                                                                  unitHeightValue),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );


                                }



                                setState(() {

                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.11,
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: FutureBuilder(
                              future: getDailyWork(context,
                                  Loginprovider.getuserId().toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<DailyWorkModel>> snapshot) {
                                if (snapshot.hasData) {
                                  List<DailyWorkModel>? DailyWork =
                                      snapshot.data;



                                  List<DailyWorkModel>? search = Loginprovider.getshowAllDaily().toString()!='true'?DailyWork!
                                      .where((element) => element
                                      .TicketId
                                      .toString()
                                      .contains(dateinputC
                                      .text
                                      .toString()) ||
                                      element
                                          .Descr
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString()) ||
                                      element
                                          .ustnameA
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString())
                                      ||
                                      element
                                          .ustnameA
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString())

                                  )
                                      .toList():
                                  DailyWork!
                                      .where((element) =>
                                  element
                                      .assignto
                                      .toString()
                                      .contains(userselected
                                      .toString())
                                      ||userselected==''

                                  )
                                      .toList();






                                  return search!.isNotEmpty
                                      ? ListView(
                                    physics: const AlwaysScrollableScrollPhysics(), //
                                    children: search!
                                        .map((DailyWorkModel inv) =>

                                             Card(
                                                  child:  Theme(
                                                    data : ThemeData().copyWith(dividerColor: Colors.transparent),
                                                    child: ExpansionTile(

                                                      trailing: null,
                                                      title:Row(
                                                        children: [


                                                          SizedBox(
width: MediaQuery.of(context).size.width/4,
                                                                child: Row(
                                                                  children: [

                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            inv.TransDate.toString().substring(0,3),
                                                                            style: TextStyle(
                                                                                fontSize: 16*unitHeightValue,
                                                                                fontWeight: FontWeight
                                                                                    .w800,
                                                                                height: 1)),
                                                                        Text(
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            inv.TransDate.toString().substring(6,11),
                                                                            style: TextStyle(
                                                                                fontSize: 14*unitHeightValue,
                                                                                height: 1)),
                                                                      ],

                                                                    ),
                                                                    Text(
                                                                      inv.TransDate.toString().substring(3,6),
                                                                      style: TextStyle(
                                                                          fontSize: 32*unitHeightValue,
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          color: HexColor(
                                                                              ThemP
                                                                                  .getcolor())),
                                                                    ),
                                                                  ],
                                                                ),




                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                                color: HexColor(ThemP.getcolor()),
                                                                child: SizedBox(height: 50,width: 2,)),
                                                          ),

                                                          Align(alignment: Alignment.topCenter,child: Container(
                                                            width: MediaQuery.of(context).size.width/2.75,
                                                            child: Text(LanguageProvider.langg=='EN'?inv.ustnameE.toString():inv.ustnameA.toString(),
                                                              style: ArabicTextStyle(arabicFont: ArabicFont.tajawal,fontWeight: FontWeight.w600,fontSize: 15*unitHeightValue,color: Colors.black),),
                                                          )),
                                                          Spacer(),




                                                        ],
                                                      ),
                                                      children: [

                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(14),
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width/1.4,
                                                                child: Text(
                                                                    maxLines: 30,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    inv.Descr
                                                                        .toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont: ArabicFont.tajawal,
                                                                        color: HexColor(
                                                                            Globalvireables
                                                                                .black2),
                                                                        fontSize: 12 *
                                                                            unitHeightValue,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700)
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer()
                                                          ],
                                                        ),


                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(children: [

                                                          Icon(
                                                            Icons.timer_sharp,
                                                            color: HexColor(ThemP.color),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:4.0),
                                                            child: Text(
                                                                maxLines: 30,
                                                                overflow: TextOverflow.ellipsis,
                                                                inv.WorkTime
                                                                    .toString() + (LanguageProvider.langg=='EN'?" Hour ":" ساعة "),
                                                                style: ArabicTextStyle(
                                                                    arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                    color: HexColor(
                                                                        ThemP.getcolor()),
                                                                    fontSize: 14 *
                                                                        unitHeightValue,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ),

SizedBox(width: 10,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:7.0),
                                                            child: Text(
                                                                maxLines: 30,
                                                                overflow: TextOverflow.ellipsis,
                                                          '#',
                                                                style: ArabicTextStyle(
                                                                    arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                    color: HexColor(
                                                                        ThemP.getcolor()),
                                                                    fontSize: 23 *
                                                                        unitHeightValue,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:4.0),
                                                            child: Text(
                                                                maxLines: 30,
                                                                overflow: TextOverflow.ellipsis,
                                                                inv.TicketId
                                                                    .toString() ,
                                                                style: ArabicTextStyle(
                                                                    arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                    color: HexColor(
                                                                        ThemP.getcolor()),
                                                                    fontSize: 14 *
                                                                        unitHeightValue,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ),


                                                        ],),
                                                      ),


                                                      /*  Padding(
                                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                          child: Column(
                                                            children: [
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width/1.25,
                                                                  child: Text(
                                                                      maxLines: 30,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      inv.WorkTime
                                                                          .toString() + (LanguageProvider.langg=='EN'?" Hour ":" ساعة "),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont:
                                                                          ArabicFont
                                                                              .tajawal,
                                                                          color: HexColor(
                                                                              ThemP.getcolor()),
                                                                          fontSize: 12 *
                                                                              unitHeightValue,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                                ),
                                                              Spacer()
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context).size.width/1.25,
                                                                child: Text(
                                                                    maxLines: 30,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    "#"+
                                                                    inv.TicketId
                                                                        .toString() ,
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                        ArabicFont
                                                                            .tajawal,
                                                                        color: HexColor(
                                                                            ThemP.getcolor()),
                                                                        fontSize: 12 *
                                                                            unitHeightValue,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                              ),
                                                              Spacer()
                                                            ],
                                                          ),
                                                        ),
*/

                                                      ],
                                                    ),
                                                  )


                                              ),


                                        )
                                        .toList(),
                                  )
                                      : Image.asset(
                                    "assets/null.png",
                                    height: 100,
                                    width: 100,
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
          )),
    ]);
  }

  Future<List<DailyWorkModel>> getDailyWork(
      BuildContext context, String useris) async {
    Uri postsURL = Uri.parse(Globalvireables.DailyWorkURL);
    try {
      var map = new Map<String, dynamic>();
      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

      

print("alldailywork  "+Loginprovider.getshowAllDaily().toString());
      if(Loginprovider.getshowAllDaily().toString()!='true')
      map['userid'] = useris;
else
        map['userid'] = 'all';

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("dailyworkOUTPT" + res.body.toString());
        print("dailyworkINPUT" + map.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<DailyWorkModel> Doctors = body
            .map(
              (dynamic item) => DailyWorkModel.fromJson(item),
        )
            .toList();

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

  _onItemTapped(int index) {
    if(index != 2){
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),);
      });}
  }

  String retturndatenewformat(String DATE) {
    String newMonth = "";
    var parts = DATE.substring(0, 10).split('-');
    String y = parts[0].trim();
    int m = int.parse(parts[1].trim());
    String d = parts[2].trim();

    if (m == 1) {
      newMonth = 'January';
    } else if (m == 2) {
      newMonth = 'Februay';
    } else if (m == 3) {
      newMonth = 'March';
    } else if (m == 4) {
      newMonth = 'April';
    } else if (m == 5) {
      newMonth = 'May';
    } else if (m == 6) {
      newMonth = 'June';
    } else if (m == 7) {
      newMonth = 'July';
    } else if (m == 8) {
      newMonth = 'August';
    } else if (m == 9) {
      newMonth = 'September';
    } else if (m == 10) {
      newMonth = 'October';
    } else if (m == 11) {
      newMonth = 'November';
    } else if (m == 12) {
      newMonth = 'December';
    }

    return newMonth + " " + d + "," + y;
  }

  String retDay(String DATE) {
    var parts = DATE.split('-');
    String d = parts[2].trim().substring(0, 2);

    return d.toString();
  }

  String retYear(String DATE) {
    var parts = DATE.split('-');
    String y = parts[0].trim();

    return y.toString();
  }

  String retMonth(String DATE) {
    String newMonth = "";
    var parts = DATE.split('-');
    int m = int.parse(parts[1].trim());
    if (m == 1) {
      newMonth = 'JAN';
    } else if (m == 2) {
      newMonth = 'FEB';
    } else if (m == 3) {
      newMonth = 'MAR';
    } else if (m == 4) {
      newMonth = 'APR';
    } else if (m == 5) {
      newMonth = 'MAY';
    } else if (m == 6) {
      newMonth = 'JUN';
    } else if (m == 7) {
      newMonth = 'JUL';
    } else if (m == 8) {
      newMonth = 'AUG';
    } else if (m == 9) {
      newMonth = 'SEP';
    } else if (m == 10) {
      newMonth = 'OCT';
    } else if (m == 11) {
      newMonth = 'NOV';
    } else if (m == 12) {
      newMonth = 'DEC';
    }
    return newMonth.toString();
  }
  Future<List<AllusersModel>> getallusers(
      BuildContext context, String useris) async {
    Uri postsURL = Uri.parse(Globalvireables.allusersURL);
    try {

      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<AllusersModel> Doctors = body
            .map(
              (dynamic item) => AllusersModel.fromJson(item),
        )
            .toList();

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
}
