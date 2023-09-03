import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:ticketing/UI/OpenTickets.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Models/AllCustomersModel.dart';
import '../Models/AllusersModel.dart';
import '../Models/systemsModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'DailyWork.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'Settings.dart';
import 'package:intl/intl.dart';

class OpenTicket extends StatefulWidget {
  @override
  State<OpenTicket> createState() => _OpenTicketState();
}

class _OpenTicketState extends State<OpenTicket> {
  @override
  void initState() {
    gatMaxId(context);
   // callMehtod(context);
    super.initState();

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  TextEditingController selectCustomerController = TextEditingController();
  TextEditingController selectsystemController = TextEditingController();
  TextEditingController searchsystemcontroller = TextEditingController();
  TextEditingController searchscustomerscontroller = TextEditingController();


  TextEditingController sourceController = TextEditingController();
  TextEditingController searchsourceontroller = TextEditingController();


  TextEditingController seartypeceontroller = TextEditingController();
  TextEditingController typeController = TextEditingController();

  TextEditingController searpropceontroller = TextEditingController();
  TextEditingController prpartyController = TextEditingController();

  TextEditingController clasificationController = TextEditingController();
  TextEditingController searclasifiontroller = TextEditingController();

  TextEditingController departmentController = TextEditingController();
  TextEditingController searchdepartcontroller = TextEditingController();

  TextEditingController usersController = TextEditingController();
  TextEditingController searchusercontroller = TextEditingController();

  ////texts
  TextEditingController date = TextEditingController();
  TextEditingController expexteddate = TextEditingController();
  TextEditingController expextedtime = TextEditingController();
  TextEditingController explanerror = TextEditingController();
  TextEditingController notes = TextEditingController();

  TextEditingController requestbycontroller = TextEditingController();


  var systemVar='null';
  var dateVar='null';
  var depVar='null';
  var userVar='null';
  var source='null';
var typeVar='null';
  var selectidcustomer='null';
var classVar='null';
var prpartyVar='null';

var maxid='';
  var timer;

  Future<void> callMehtod(BuildContext c) async {
    timer.periodic(Duration(seconds: 20), (timer) {
      gatMaxId(c);
      //place you code for calling after,every 60 seconds.
    });
  }

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);





    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);

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
                icon: Icon(Icons.settings),
                label: LanguageProvider.Llanguage('settings'),
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('addTicket'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Container(
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
                    height: MediaQuery.of(context).size.height / 1.24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20,bottom: 10),
                    child: SingleChildScrollView(

                        //   padding: EdgeInsets.all(30.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),


                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                      textAlign: TextAlign
                                          .right,
                                      maxid+' ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight
                                              .w600,
                                          height: 1)),
                                  Text(
                                      textAlign: TextAlign
                                          .right,
                                      LanguageProvider.Llanguage('ticketnum'),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight
                                              .w600,
                                          height: 1)),
                                ],
                              ),

                          Card(
                            child: ExpansionTile(
                              shape: Border.all(color: Colors.transparent),
                              title: Text(LanguageProvider.Llanguage('customerinfo')),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: selectCustomerController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.format_align_justify,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                              "customer"),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.2,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider
                                                                      .Llanguage(
                                                                          'openTicket'),
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searchscustomerscontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searchscustomerscontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searchscustomerscontroller.text.isEmpty || searchscustomerscontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  getcustomers(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              AllCustomersModel>>
                                                                      snapshot) {
                                                                if (snapshot.hasData) {
                                                                  List<AllCustomersModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<AllCustomersModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searchscustomerscontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((AllCustomersModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    selectCustomerController.text = v.namea.toString();

                                                                                    selectidcustomer = v.id.toString();
                                                                                    Navigator.pop(context);

                                                                                    setState(() {

});
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: SizedBox(
                                                                                        child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width / 2.2,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.right,
                                                                                            v.namea.toString(),
                                                                                            style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                          ),
                                                                                        ),
                                                                                        Spacer(),
                                                                                        Container(
                                                                                          width: 100,
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: selectidcustomer.toString()!='null'?SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: selectsystemController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.format_align_justify,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                              "system"),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider
                                                                      .Llanguage(
                                                                          'system'),

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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searchsystemcontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searchsystemcontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searchsystemcontroller.text.isEmpty || searchsystemcontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future: getsystems(
                                                                  context,
                                                                  selectidcustomer),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searchsystemcontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return Center(
                                                                    child: ListView(
                                                                      children: search!
                                                                          .map((systemsModel v) => Column(
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      selectsystemController.text = v.namea.toString();
systemVar=v.id.toString();
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
                                                                    ),
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ):null,
                                ),
                              ],
                            ),
                          ),

                          Card(
                            child: ExpansionTile(
                              shape: Border.all(color: Colors.transparent),
                              title: Text(LanguageProvider.Llanguage('ticketinfo')),
                              children: [
                                //source
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: sourceController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                          hintText: LanguageProvider.Llanguage('sourceController'),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider.Llanguage('sourceController'),
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searchsourceontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searchsourceontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searchsourceontroller.text.isEmpty || searchsourceontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  getsourceController(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searchsourceontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((systemsModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    sourceController.text = v.namea.toString();

                                                                                     source=v.id.toString();
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(14.0),
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //clasification
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: clasificationController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                          hintText: LanguageProvider.Llanguage('clasificationController'),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider.Llanguage('clasificationController'),
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searclasifiontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searclasifiontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searclasifiontroller.text.isEmpty || searclasifiontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  getclasificationController(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searclasifiontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((systemsModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    clasificationController.text = v.namea.toString();
classVar=v.id.toString();
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //type
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: typeController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                          hintText:LanguageProvider.Llanguage('gettypeController') ,
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider.Llanguage('gettypeController') ,
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  seartypeceontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            seartypeceontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            seartypeceontroller.text.isEmpty || seartypeceontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  gettypeController(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(seartypeceontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((systemsModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    typeController.text = v.namea.toString();
                                               typeVar=v.id.toString();
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //department
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: departmentController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                          hintText: LanguageProvider.Llanguage('departmentController'),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider.Llanguage('departmentController'),
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searchdepartcontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searchdepartcontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searchdepartcontroller.text.isEmpty || searclasifiontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  getdepartment(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searchdepartcontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((systemsModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    departmentController.text = v.namea.toString();
depVar=v.id.toString();
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //prparty
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: SizedBox(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: prpartyController,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: HexColor(ThemP.getcolor()),
                                            size: 27 * unitHeightValue,
                                          ),
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
                                          hintText: LanguageProvider.Llanguage('prpartyController'),
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          // _showTextInputDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              child: Text(
                                                                  LanguageProvider.Llanguage('prpartyController'),
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
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            child: TextField(
                                                              onChanged:
                                                                  (content) {
                                                                setState(() {});
                                                              },
                                                              controller:
                                                                  searpropceontroller,
                                                              //editing controller of this TextField
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  size: 27 *
                                                                      unitHeightValue,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            searpropceontroller.text =
                                                                                '';
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                            color: Colors
                                                                                .redAccent,
                                                                            searpropceontroller.text.isEmpty || searpropceontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                                ? null
                                                                                : Icons.cancel)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        width:
                                                                            2.0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 18,
                                                                        bottom:
                                                                            18,
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                fillColor: HexColor(
                                                                    Globalvireables
                                                                        .white),
                                                                filled: true,
                                                                hintText: LanguageProvider
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.8,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1,
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  getpropController(
                                                                      context),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              systemsModel>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<systemsModel>?
                                                                      Visits =
                                                                      snapshot
                                                                          .data;

                                                                  List<systemsModel>? search = Visits!
                                                                      .where((element) => element
                                                                          .namea
                                                                          .toString()
                                                                          .contains(searpropceontroller
                                                                              .text
                                                                              .toString()))
                                                                      .toList();

                                                                  return ListView(
                                                                    children: search!
                                                                        .map((systemsModel v) => Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    prpartyController.text = v.namea.toString();
                                                                                    prpartyVar=v.id.toString();
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
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
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
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
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
                                        },
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
//time and dat
                          Card(
                            child: ExpansionTile(
                              shape: Border.all(color: Colors.transparent),
                              title: Text(LanguageProvider.Llanguage('dateandtimeinfo')),
                              children: [

//expected date
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: TextField(
                                      controller: expexteddate, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.date_range,color: HexColor(
                                            ThemP.getcolor()),size: 27*unitHeightValue,),
                                        suffixIcon: GestureDetector(
                                            onTap: (){
                                              expexteddate.text=LanguageProvider.Llanguage('expecteddate');

                                              setState(() {
                                              });
                                            },
                                            child: Icon(color: Colors.redAccent,expexteddate.text.isEmpty||expexteddate.text.toString()==LanguageProvider.Llanguage('expecteddate')
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
                                            "expecteddate"),
                                      ),
                                      readOnly: true,  //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context, initialDate: DateTime.now(),
                                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101)
                                        );

                                        if(pickedDate != null ){
                                          String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                                          print(formattedDate +"formattedDate");
                                          setState(() {
                                            expexteddate.text = formattedDate.toString(); //set output date to TextField value.
                                          });
                                        }else{
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
SizedBox(height: 10,),

                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: TextField(
                                      controller: date, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.date_range,color: HexColor(
                                            ThemP.getcolor()),size: 27*unitHeightValue,),
                                        suffixIcon: GestureDetector(
                                            onTap: (){
                                              date.text=LanguageProvider.Llanguage('date');

                                              setState(() {
                                              });
                                            },
                                            child: Icon(color: Colors.redAccent,date.text.isEmpty||date.text.toString()==LanguageProvider.Llanguage('date')
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
                                            "date"),
                                      ),
                                      readOnly: true,  //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context, initialDate: DateTime.now(),
                                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101)
                                        );

                                        if(pickedDate != null ){
                                          String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                                          print(formattedDate +"formattedDate");
                                          setState(() {
                                            date.text = formattedDate.toString(); //set output date to TextField value.
dateVar=formattedDate.toString();
                                          });
                                        }else{
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),



                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    child: TextField(
                                      controller: expextedtime, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.timelapse_outlined,color: HexColor(
                                            ThemP.getcolor()),size: 27*unitHeightValue,),
                                        suffixIcon: GestureDetector(
                                            onTap: (){

                                            },
                                            child: Icon( null
                                               )),
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
                                            "expextedtime"),
                                      ),
                                      readOnly: false,  //set it true, so that user will not able to edit text
                                      onTap: () async {

                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
//request by
                              Padding(
                                padding: const EdgeInsets.only(top:12.0,),
                                child: SizedBox(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: requestbycontroller, //editing controller of this TextField
                                    decoration: InputDecoration(

                                      suffixIcon: GestureDetector(
                                          onTap: (){

                                          },
                                          child: Icon( null
                                          )),
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
                                      hintText:
                                         LanguageProvider.Llanguage('requestbycontroller'),
                                    ),
                                    readOnly: false,  //set it true, so that user will not able to edit text
                                    onTap: () async {

                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                          //emplyee
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: SizedBox(
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: usersController,
                                //editing controller of this TextField
                                decoration: InputDecoration(




                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  contentPadding: EdgeInsets.only(
                                      top: 18, bottom: 18, right: 20, left: 20),
                                  fillColor: HexColor(Globalvireables.white),
                                  filled: true,
                                  hintText: LanguageProvider.Llanguage('usersController'),
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  // _showTextInputDialog(context);
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
                                                          LanguageProvider.Llanguage('usersController'),
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
                                                          getallusers(context),
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
                                                                                usersController.text = v.namea.toString();
userVar=v.id.toString();
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
                                },
                              ),
                            ),
                          ),

                              SizedBox(
                                height: 20,
                              ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    textAlign: TextAlign
                                        .right,
    LanguageProvider.Llanguage(
    "explanerror"),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight
                                            .w600,
                                        height: 1)),
                              ),
                              SizedBox(
                                height: 150,
                                child: TextField(
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  controller: explanerror, //editing controller of this TextField
                                  decoration: InputDecoration(

                                    suffixIcon: GestureDetector(
                                        onTap: (){

                                        },
                                        child: Icon( null
                                        )),
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

                                  ),
                                  readOnly: false,  //set it true, so that user will not able to edit text
                                  onTap: () async {

                                  },
                                ),
                              ),
                              SizedBox(height: 20,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    textAlign: TextAlign
                                        .right,
                                    LanguageProvider.Llanguage(
                                        "notes2"),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight
                                            .w600,
                                        height: 1)),
                              ),
                              SizedBox(
                                height: 100,
                                child: TextField(
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  controller: notes, //editing controller of this TextField
                                  decoration: InputDecoration(

                                    suffixIcon: GestureDetector(
                                        onTap: (){

                                        },
                                        child: Icon( null
                                        )),
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

                                  ),
                                  readOnly: false,  //set it true, so that user will not able to edit text
                                  onTap: () async {

                                  },
                                ),
                              ),

                              SizedBox(height: 50,),

                              SizedBox(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width:
                                    MediaQuery.of(context).size.width / 1.2,
                                    margin: EdgeInsets.only(top: 10, bottom: 30),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                          HexColor(ThemP.getcolor()),
                                        ),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              LanguageProvider.Llanguage(
                                                  'save'),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  color: Colors.white,
                                                  fontSize: 14 * unitHeightValue),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                        onPressed: () async {
                                          gatMaxId(context);



                                          if(date.text.toString()!=null && selectidcustomer.toString()!='null'&&source.toString()!='null' &&
    typeVar.toString()!='null' && depVar.toString()!='null'&&expexteddate.text.toString()!=null &&
    userVar.toString()!='null'&&systemVar.toString()!='null'&&explanerror.text.toString()!=null) {
  OpenTicket(context);
}else{
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(LanguageProvider.Llanguage('openTicket')),
        content: Text(LanguageProvider.Llanguage('anerror')),
      ));
}
                                        }),
                                  ),
                                ),
                              )

                        ]))),
              ),
            ),
          )),
    ]);
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    DailyWork(),
  ];

  Future<List<AllCustomersModel>> getcustomers(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.customers);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<AllCustomersModel> Doctors = body
            .map(
              (dynamic item) => AllCustomersModel.fromJson(item),
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

  Future<List<systemsModel>> getsystems(
      BuildContext context, String customerid) async {
    Uri postsURL = Uri.parse(Globalvireables.getsystems);
    try {
      var map = new Map<String, dynamic>();
      map['customerid'] = customerid;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<systemsModel>> getsourceController(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.infoTsource);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<systemsModel>> gettypeController(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.infoTtype);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<systemsModel>> getpropController(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.infoTpriority);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<systemsModel>> getclasificationController(
      BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.classification);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<systemsModel>> getdepartment(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.department);
    try {
      http.Response res = await http.post(
        postsURL,
        body: null,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<systemsModel> Doctors = body
            .map(
              (dynamic item) => systemsModel.fromJson(item),
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

  Future<List<AllusersModel>> getallusers(BuildContext context) async {
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



  Future<List<AllusersModel>> gatMaxId(BuildContext context) async {
    Uri postsURL = Uri.parse(Globalvireables.infoTmax);
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

        maxid=Doctors[0].id.toString();
setState(() {

});
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



  OpenTicket(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('ClosTicket')),
          content: Text(l.getLanguage() == "AR"
              ? 'جار فتح التذكره ...'
              : 'open ticket..'),
        ));

    var map = new Map<String, dynamic>();


    map['TicketDate']= date.text.toString();
   map['CustomerIdT']=selectidcustomer.toString();
    map['TicketSource']=source.toString();

     map['TicketType']=typeVar.toString();
    map['Department']=depVar.toString();
    map['DueDate']=expexteddate.text.toString(); // contr

   map['AssignToT']=userVar.toString();
  map['SystemId']=systemVar.toString();

       map['IssueDescr']= explanerror.text.toString(); // contr

    map['EstimateTimeT']=expextedtime.text.toString();  // contr
 map['TicketClass']=classVar.toString().toString();
    map['RequestedBy']=requestbycontroller.text.toString();// contr

    map['Delivered']='0';
    map['CreatedBy']=Loginprovider.getuserId().toString();
    map['PriorityLevel']=prpartyVar.toString();
    map['InternalNotesT']=notes.text.toString();
    map['userid']=Loginprovider.getuserId().toString();
    map['ticketid']=maxid;




    print("INPUT  : "+map.toString() );
    try {
      Uri apiUrl = Uri.parse(Globalvireables.OpenTicketURL);

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => Navigator.pop(context));

      var jsonResponse = jsonDecode(response.body);

      print("OUTPUT  : "+ jsonResponse.toString());

      if (jsonResponse.toString().contains('1S')) {


        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OpenTickets()),
        );

        setState(() {

        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('openTicket')),
              content: Text(l.getLanguage() == "AR"
                  ? 'تم فتح التذكره بنجاح'
                  : 'close ticketing is done..'),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('openTicket')),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('openTicket')),
          content: Text(l.Llanguage('anerror')),
          actions: <Widget>[],
        ),
      );
    }
  }





















}







