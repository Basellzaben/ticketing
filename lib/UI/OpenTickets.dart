import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu_new/flutter_boom_menu_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Models/AllusersModel.dart';
import '../Models/TicketsModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'DailyWork.dart';
import 'Home.dart';
import 'package:intl/intl.dart';

import 'OpenTicket.dart';
import 'Settings.dart';

class OpenTickets extends StatefulWidget {
  @override
  State<OpenTickets> createState() => _OpenTicketsState();
}

class _OpenTicketsState extends State<OpenTickets> {
  @override
  void initState() {
    //setsearch(context);
    SELECTContrtiome.text='0';
    enablesend=Provider.of<LoginProvider>(context, listen: false).getassignticketP().toString();
    enabladdticket=Provider.of<LoginProvider>(context, listen: false).getopenticketP().toString();
    super.initState();
  }
  var enablesend='';
  var enabladdticket='';
  final _NotetextFieldController = TextEditingController();
  final SELECTContrtiome = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }
  var idselected='';
  var ticketidselect='';


  int selectedIndex = 1;
  bool scrollVisible = true;

  final List<Widget> nav = [
    Settings(),
    Home(),
    DailyWork(),
  ];


  var userselected='';
  TextEditingController dateinputC = TextEditingController();
  TextEditingController searchusercontroller = TextEditingController();

  var state = false;
  final key = GlobalKey();

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }
  TextEditingController SELECTContr = TextEditingController();
  TextEditingController noteContrtiome = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    print("  TTT "+enablesend + "  TTT");

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
          floatingActionButton: enabladdticket=='true'?SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: FloatingActionButton(
              backgroundColor: HexColor(ThemP.color),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpenTicket()));
              },
            ),
          ):null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            key: key,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: LanguageProvider.Llanguage(
                  'settings',
                ),
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
                LanguageProvider.Llanguage('openTicket'),
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
                    height: MediaQuery.of(context).size.height / 1.22,
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
                                setState(() {});
                              },
                              controller: dateinputC,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: HexColor(ThemP.getcolor()),
                                  size: 27 * unitHeightValue,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                        dateinputC.text = '';
                                      userselected='';

setState(() {

});

                                    },
                                    child: Icon(
                                        color: Colors.redAccent,
                                        dateinputC.text.isEmpty ||
                                                dateinputC.text.toString() ==
                                                    LanguageProvider.Llanguage(
                                                        'Search')
                                            ? null
                                            : Icons.cancel)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18, bottom: 18, right: 20, left: 20),
                                fillColor: HexColor(Globalvireables.white),
                                filled: true,
                                hintText: LanguageProvider.Llanguage("Search"),
                              ),
                              //a  readOnly: true,  //set it true, so that user will not able to edit text
                              onTap: () async {
                                setState(() {});

                                if(Loginprovider.getshowAllTicket().toString()=='true'){


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



                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.11,
                            height: MediaQuery.of(context).size.height / 1.55,
                            child: FutureBuilder(
                              future: getOpenTickets(context,
                                  Loginprovider.getuserId().toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<TicketsModel>> snapshot) {
                                if (snapshot.hasData) {
                                  List<TicketsModel>? OpenTickets =
                                      snapshot.data;



    List<TicketsModel>? search = Loginprovider.getshowAllTicket().toString()!='true'?OpenTickets!
                                      .where((element) => element
                                      .custNameA
                                      .toString()
                                      .contains(dateinputC
                                      .text
                                      .toString()) ||
                                      element
                                          .custNameE
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString()) ||
                                      element
                                          .Id
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString())
                                      ||
                                      element
                                          .IssueDescr
                                          .toString()
                                          .contains(dateinputC
                                          .text
                                          .toString())

                                  )
                                      .toList():
    OpenTickets!
        .where((element) =>
    element
        .assignto
        .toString()
        .contains(userselected
        .toString())
 ||   userselected==''

    )
        .toList();





                                  if (search!.isNotEmpty) {
                                    return ListView(
                                      children: search!
                                          .map((TicketsModel inv) => Card(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        width: 0.5,
                                                        //  color: Colors.black12.withOpacity(0.1),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    inv.custNameA
                                                                        .toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        color: HexColor(Globalvireables
                                                                            .black2),
                                                                        fontSize:
                                                                            16 *
                                                                                unitHeightValue,
                                                                        fontWeight:
                                                                            FontWeight.w700)),
                                                                Spacer(),
                                                                Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        _showTextInputDialog(
                                                                            context,
                                                                            inv.Id
                                                                                .toString());
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        color: HexColor(
                                                                            ThemP
                                                                                .color),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 10,),



                                                                   GestureDetector(
                                                                      onTap: () {
                                                                        ////////////////////////////////
                                                                        setState(() {
                                                                          ticketidselect=inv.Id.toString();

                                                                        });
                                                                        showModalBottomSheet(
                                                                          isScrollControlled: true,
                                                                          context: context,
                                                                          builder: (context) {
                                                                            return Padding(
                                                                                padding: const EdgeInsets.all(9.0),
                                                                                child: Container(
                                                                                    height: MediaQuery
                                                                                        .of(context)
                                                                                        .size
                                                                                        .height / 1.1,

                                                                                    child: SizedBox(
                                                                                        height:  MediaQuery
                                                                                            .of(context)
                                                                                            .size
                                                                                            .height / 2,
                                                                                        child: Column(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets
                                                                                                    .all(8.0),
                                                                                                child: SizedBox(
                                                                                                  child: Text(
                                                                                                      LanguageProvider.Llanguage('transTicket'),

                                                                                                      style: ArabicTextStyle(
                                                                                                          arabicFont: ArabicFont.tajawal,
                                                                                                          color: HexColor(Globalvireables.black2),
                                                                                                          fontSize: 18 * unitHeightValue,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w700
                                                                                                      )

                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Divider(thickness: 1.0, color: Colors.grey),


                                                                                              SizedBox(
                                                                                                child: TextField(
                                                                                                  textAlign: TextAlign.center,
                                                                                                  controller:  SELECTContr
                                                                                                  ,
                                                                                                  //editing controller of this TextField
                                                                                                  decoration: InputDecoration(



                                                                                                    prefixIcon: Icon(
                                                                                                      Icons.format_align_justify, color: HexColor(
                                                                                                        ThemP.getcolor()),
                                                                                                      size: 27 * unitHeightValue,),

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
                                                                                                        "selectuser"),
                                                                                                  ),
                                                                                                  readOnly: true,
                                                                                                  //set it true, so that user will not able to edit text
                                                                                                  onTap: () async {
                                                                                                    showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        return Center(
                                                                                                          child: Card(
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsets.all(9.0),
                                                                                                              child: Container(
                                                                                                                height: MediaQuery
                                                                                                                    .of(context)
                                                                                                                    .size
                                                                                                                    .height / 2,
                                                                                                                width: MediaQuery
                                                                                                                    .of(context)
                                                                                                                    .size
                                                                                                                    .width / 1.5,
                                                                                                                child: SizedBox(
                                                                                                                  height:  MediaQuery
                                                                                                                      .of(context)
                                                                                                                      .size
                                                                                                                      .height / 2,
                                                                                                                  child: Column(
                                                                                                                    children: [
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets
                                                                                                                            .all(8.0),
                                                                                                                        child: SizedBox(
                                                                                                                          child: Text(
                                                                                                                              LanguageProvider.Llanguage('selectuser'),

                                                                                                                              style: ArabicTextStyle(
                                                                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                                                                  color: HexColor(Globalvireables.black2),
                                                                                                                                  fontSize: 18 * unitHeightValue,
                                                                                                                                  fontWeight: FontWeight
                                                                                                                                      .w700
                                                                                                                              )

                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Divider(thickness: 1.0, color: Colors.grey),

                                                                                                                      SizedBox(

                                                                                                                        height: MediaQuery
                                                                                                                            .of(context)
                                                                                                                            .size
                                                                                                                            .height / 4,
                                                                                                                        width: MediaQuery
                                                                                                                            .of(context)
                                                                                                                            .size
                                                                                                                            .width / 2,
                                                                                                                        child: FutureBuilder(
                                                                                                                          future: getallusers(context,
                                                                                                                              Loginprovider.getuserId().toString()),
                                                                                                                          builder: (
                                                                                                                              BuildContext context,
                                                                                                                              AsyncSnapshot<List<
                                                                                                                                  AllusersModel>> snapshot) {
                                                                                                                            if (snapshot.hasData) {
                                                                                                                              List<AllusersModel>? Visits = snapshot
                                                                                                                                  .data;
                                                                                                                              return
                                                                                                                                ListView(
                                                                                                                                  children: Visits!
                                                                                                                                      .map((
                                                                                                                                      AllusersModel v) =>
                                                                                                                                      Column(
                                                                                                                                        children: [
                                                                                                                                          GestureDetector(
                                                                                                                                            onTap: () {

                                                                                                                                              SELECTContr.text= v.namea.toString();
                                                                                                                                              setState(() {
                                                                                                                                                idselected=v.id.toString();

                                                                                                                                              });
                                                                                                                                              Navigator.pop(context);
                                                                                                                                            },
                                                                                                                                            child: Padding(
                                                                                                                                              padding: const EdgeInsets.all(
                                                                                                                                                  8.0),
                                                                                                                                              child: Center(
                                                                                                                                                child: SizedBox(
                                                                                                                                                    child: Row(
                                                                                                                                                      children: [
                                                                                                                                                        Container(
                                                                                                                                                          child: Text(
                                                                                                                                                            v.namea.toString(),
                                                                                                                                                            style: ArabicTextStyle(
                                                                                                                                                                arabicFont: ArabicFont.tajawal,
                                                                                                                                                                color: Colors
                                                                                                                                                                    .black,
                                                                                                                                                                fontSize: 14 *
                                                                                                                                                                    unitHeightValue,
                                                                                                                                                                fontWeight: FontWeight
                                                                                                                                                                    .w400),),
                                                                                                                                                        ),
                                                                                                                                                        Spacer(),
                                                                                                                                                        Container(
                                                                                                                                                          child: Text(
                                                                                                                                                            v.id.toString(),
                                                                                                                                                            style: ArabicTextStyle(
                                                                                                                                                                arabicFont: ArabicFont.tajawal,
                                                                                                                                                                color: Colors
                                                                                                                                                                    .black,
                                                                                                                                                                fontSize: 14 *
                                                                                                                                                                    unitHeightValue,
                                                                                                                                                                fontWeight: FontWeight
                                                                                                                                                                    .w400),),
                                                                                                                                                        ),




                                                                                                                                                      ],)

                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                                                                        ],
                                                                                                                                      )

                                                                                                                                  )
                                                                                                                                      .toList(),
                                                                                                                                )

                                                                                                                              //   wef

                                                                                                                                  ;
                                                                                                                            } else {
                                                                                                                              return Center(
                                                                                                                                  child: CircularProgressIndicator());
                                                                                                                            }
                                                                                                                          },
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Spacer(),
                                                                                                                      Align(
                                                                                                                        alignment: Alignment.bottomCenter,
                                                                                                                        child: SizedBox(
                                                                                                                          width: MediaQuery.of(context).size.width / 4,
                                                                                                                          child: ElevatedButton(
                                                                                                                            style: ElevatedButton.styleFrom(
                                                                                                                              primary:
                                                                                                                              HexColor(ThemP.getcolor()),
                                                                                                                            ),
                                                                                                                            child: Text(
                                                                                                                              LanguageProvider.Llanguage('cancel'),
                                                                                                                              style: ArabicTextStyle(
                                                                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                                                                  color:
                                                                                                                                  HexColor(Globalvireables.white),
                                                                                                                                  fontSize: 14 * unitHeightValue),
                                                                                                                            ),
                                                                                                                            onPressed: () async {
                                                                                                                              Navigator.of(context).pop();

                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),

                                                                                                                    ],
                                                                                                                  ),
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
                                                                                              SizedBox(height: 20,),

                                                                                              SizedBox(

                                                                                                  child:Row(children: [
                                                                                                    Spacer(),
                                                                                                    Spacer(),
                                                                                                    SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width/2,
                                                                                                      height: 50,
                                                                                                      child: TextField(
                                                                                                        textAlign: TextAlign.center,
                                                                                                        controller:  SELECTContrtiome,
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        //editing controller of this TextField
                                                                                                        decoration: InputDecoration(

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
                                                                                                          hintText:'',
                                                                                                        ),
                                                                                                        //set it true, so that user will not able to edit text

                                                                                                      ),
                                                                                                    ),

                                                                                                    Spacer(),
                                                                                                    SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width/3,

                                                                                                      child:  Text(
                                                                                                        textAlign: TextAlign.center,
                                                                                                        LanguageProvider.Llanguage('Timework'),
                                                                                                        style: ArabicTextStyle(
                                                                                                            arabicFont: ArabicFont.tajawal,
                                                                                                            color:
                                                                                                            HexColor(Globalvireables.black),
                                                                                                            fontWeight: FontWeight
                                                                                                                .w500,
                                                                                                            fontSize: 18 * unitHeightValue),
                                                                                                      ),
                                                                                                    ),],)


                                                                                              ),

                                                                                              SizedBox(height: 20,),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Spacer()
                                                                                                  ,
                                                                                                  SizedBox(
                                                                                                    width: MediaQuery.of(context).size.width/3,

                                                                                                    child:  Text(
                                                                                                      textAlign: TextAlign.center,
                                                                                                      LanguageProvider.Llanguage('notes'),
                                                                                                      style: ArabicTextStyle(
                                                                                                          arabicFont: ArabicFont.tajawal,
                                                                                                          color:
                                                                                                          HexColor(Globalvireables.black),
                                                                                                          fontWeight: FontWeight
                                                                                                              .w500,
                                                                                                          fontSize: 18 * unitHeightValue),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),


                                                                                              SizedBox(
                                                                                                width: MediaQuery.of(context).size.width/1.2,
                                                                                                child: TextField(
                                                                                                  textAlign: TextAlign.center,
                                                                                                  controller:  noteContrtiome,
                                                                                                  style: TextStyle(height: 2 // controls the height on main text
                                                                                                  ),
                                                                                                  decoration: InputDecoration(

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
                                                                                                    hintText:'',
                                                                                                  ),
                                                                                                  //set it true, so that user will not able to edit text

                                                                                                ),
                                                                                              ),


                                                                                            SizedBox(height: 100,),
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
                                                                                                                  'transTicket'),
                                                                                                              style: ArabicTextStyle(
                                                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                                                  color: Colors.white,
                                                                                                                  fontSize: 14 * unitHeightValue),
                                                                                                            ),
                                                                                                            Spacer(),
                                                                                                          ],
                                                                                                        ),
                                                                                                        onPressed: () async {

                                                                                                          if(SELECTContr.text.isNotEmpty) {

                                                                                                            TransTicket(context);

                                                                                                          }else{
                                                                                                            showDialog(
                                                                                                                context: context,
                                                                                                                builder: (_) => AlertDialog(
                                                                                                                  title: Text(LanguageProvider.Llanguage('dailywork')),
                                                                                                                  content: Text(LanguageProvider.Llanguage('anerror')),
                                                                                                                ));
                                                                                                          }


                                                                                                        }),
                                                                                                  ),
                                                                                                ),
                                                                                              ),

                                                                                              Spacer(),






                                                                                            ]))));
                                                                          },
                                                                        );

   /* showDialog(
    context: context,
    builder: (BuildContext context) {
    return Center(
    child: Card(
    child: Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
    height: MediaQuery
        .of(context)
        .size
        .height / 2,
    width: MediaQuery
        .of(context)
        .size
        .width / 1.1,
    child: SizedBox(
    height:  MediaQuery
        .of(context)
        .size
        .height / 2,
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets
        .all(8.0),
    child: SizedBox(
    child: Text(
    LanguageProvider.Llanguage('transTicket'),

    style: ArabicTextStyle(
    arabicFont: ArabicFont.tajawal,
    color: HexColor(Globalvireables.black2),
    fontSize: 18 * unitHeightValue,
    fontWeight: FontWeight
        .w700
    )

    ),
    ),
    ),
    Divider(thickness: 1.0, color: Colors.grey),


      SizedBox(
        child: TextField(
          textAlign: TextAlign.center,
          controller:  SELECTContr
          ,
          //editing controller of this TextField
          decoration: InputDecoration(



            prefixIcon: Icon(
              Icons.arrow_drop_down, color: HexColor(
                ThemP.getcolor()),
              size: 27 * unitHeightValue,),

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
                "selectuser"),
          ),
          readOnly: true,
          //set it true, so that user will not able to edit text
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: SizedBox(
                          height:  MediaQuery
                              .of(context)
                              .size
                              .height / 4,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .all(8.0),
                                child: SizedBox(
                                  child: Text(
                                      LanguageProvider.Llanguage('openTicket'),

                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(Globalvireables.black2),
                                          fontSize: 18 * unitHeightValue,
                                          fontWeight: FontWeight
                                              .w700
                                      )

                                  ),
                                ),
                              ),
                              Divider(thickness: 1.0, color: Colors.grey),

                              SizedBox(

                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 5.5,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: FutureBuilder(
                                  future: getallusers(context,
                                      Loginprovider.getuserId().toString()),
                                  builder: (
                                      BuildContext context,
                                      AsyncSnapshot<List<
                                          AllusersModel>> snapshot) {
                                    if (snapshot.hasData) {
                                      List<AllusersModel>? Visits = snapshot
                                          .data;
                                      return
                                        ListView(
                                          children: Visits!
                                              .map((
                                              AllusersModel v) =>
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {

                                                      SELECTContr.text= v.namea.toString();
                                                      setState(() {
                                                        idselected=v.id.toString();

                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(
                                                          8.0),
                                                      child: Center(
                                                        child: SizedBox(
                                                            child: Row(
                                                              children: [
                                                                Spacer(),
                                                                Container(
                                                                  width: 50,
                                                                  child: Text(
                                                                    v.id.toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont: ArabicFont.tajawal,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 14 *
                                                                            unitHeightValue,
                                                                        fontWeight: FontWeight
                                                                            .w400),),
                                                                ),

                                                                SizedBox(width: 5,),

                                                                Container(
                                                                  width: 100,
                                                                  child: Text(
                                                                    v.namea.toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont: ArabicFont.tajawal,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 14 *
                                                                            unitHeightValue,
                                                                        fontWeight: FontWeight
                                                                            .w400),),
                                                                ),


                                                              ],)

                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )

                                          )
                                              .toList(),
                                        )

                                      //   wef

                                          ;
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                              Divider(thickness: 1.0, color: Colors.grey),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                      HexColor(ThemP.getcolor()),
                                    ),
                                    child: Text(
                                      LanguageProvider.Llanguage('cancel'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color:
                                          HexColor(Globalvireables.white),
                                          fontSize: 14 * unitHeightValue),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();

                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
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
SizedBox(height: 20,),

      SizedBox(

          child:Row(children: [
            Spacer(),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              child: TextField(
                textAlign: TextAlign.center,
                controller:  SELECTContrtiome,
                keyboardType: TextInputType.number,
                //editing controller of this TextField
                decoration: InputDecoration(

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
                  hintText:'',
                ),
                //set it true, so that user will not able to edit text

              ),
            ),

            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width/3,

              child:  Text(
                textAlign: TextAlign.center,
                LanguageProvider.Llanguage('Timework'),
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color:
                    HexColor(Globalvireables.black),
                    fontWeight: FontWeight
                        .w500,
                    fontSize: 18 * unitHeightValue),
              ),
            ),],)


      ),

      SizedBox(height: 20,),
      Row(
        children: [
          Spacer()
          ,
          SizedBox(
            width: MediaQuery.of(context).size.width/3,

            child:  Text(
              textAlign: TextAlign.center,
              LanguageProvider.Llanguage('notes'),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color:
                  HexColor(Globalvireables.black),
                  fontWeight: FontWeight
                      .w500,
                  fontSize: 18 * unitHeightValue),
            ),
          ),
        ],
      ),


      SizedBox(
        width: MediaQuery.of(context).size.width/1.2,
        child: TextField(
          textAlign: TextAlign.center,
          controller:  noteContrtiome,
          style: TextStyle(height: 2 // controls the height on main text
          ),
          decoration: InputDecoration(

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
            hintText:'',
          ),
          //set it true, so that user will not able to edit text

        ),
      ),


      SizedBox(height: 10,),
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
                          fontSize: 12 * unitHeightValue),
                    ),
                    Spacer(),
                  ],
                ),
                onPressed: () async {

                  if(SELECTContr.text.isNotEmpty) {



                  }else{
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(LanguageProvider.Llanguage('dailywork')),
                          content: Text(LanguageProvider.Llanguage('anerror')),
                        ));
                  }


                }),
          ),
        ),
      ),







    ]))))));});*/



                                                                      },
                                                                      child: Icon(
                                                                        enablesend=="true"?  Icons.send:null,
                                                                        color: HexColor(
                                                                            ThemP
                                                                                .color),
                                                                      ),
                                                                    )

                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width / 1.4,
                                                                  child: Text(
                                                                      maxLines: 13,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      inv.Id.toString(),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont: ArabicFont.tajawal,
                                                                          color: HexColor(Globalvireables.black2),
                                                                          fontSize: 12 * unitHeightValue,
                                                                          fontWeight: FontWeight.w500)),
                                                                ),
                                                                Spacer()
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 7,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.4,
                                                                  child: Text(
                                                                      maxLines:
                                                                          10,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      inv.IssueDescr
                                                                          .toString(),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont: ArabicFont
                                                                              .tajawal,
                                                                          color: HexColor(Globalvireables
                                                                              .black2),
                                                                          fontSize: 12 *
                                                                              unitHeightValue,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                ),
                                                                Spacer()
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.4,
                                                                  child: Text(
                                                                      maxLines:
                                                                          10,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      inv.TicketDate
                                                                              .toString()
                                                                          .substring(
                                                                              0,
                                                                              12),
                                                                      style: ArabicTextStyle(
                                                                          arabicFont: ArabicFont
                                                                              .tajawal,
                                                                          color: HexColor(Globalvireables
                                                                              .black2),
                                                                          fontSize: 12 *
                                                                              unitHeightValue,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                                Spacer()






                                                              ],
                                                            ),





                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )

                                              /*      Card(
                                            child: SizedBox(
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
                                                        width: 80,
                                                        height: MediaQuery.of(context).size.height/4.4,
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
                                                              Text(inv.TicketDate.toString().substring(4,6),
                                                                  style: ArabicTextStyle(
                                                                      arabicFont: ArabicFont.tajawal,
                                                                      color: HexColor(Globalvireables.white),
                                                                      fontSize: 25 * unitHeightValue,
                                                                      fontWeight: FontWeight.w900)),
                                                              Text(inv.TicketDate.toString().substring(0,3).toUpperCase(),
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
                                                      child: Text(inv.custNameA.toString(),
                                                          maxLines: 20,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color: HexColor(Globalvireables.black),
                                                              fontSize: 15 * unitHeightValue,
                                                              fontWeight: FontWeight.w700)),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      child: Text(inv.IssueDescr.toString(),
                                                          maxLines: 20,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color: HexColor(Globalvireables.black),
                                                              fontSize: 14 * unitHeightValue,
                                                              fontWeight: FontWeight.w500)),
                                                    ),
                                                  ],)


                                                ],)),
                                          )
*/
                                              )
                                          .toList(),
                                    );
                                  } else {
                                    return Image.asset(
                                      "assets/null.png",
                                      height: 100,
                                      width: 100,
                                    );
                                  }
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

  Future<List<TicketsModel>> getOpenTickets(
      BuildContext context, String useris) async {
    Uri postsURL = Uri.parse(Globalvireables.ticketURL);
    try {
      var map = new Map<String, dynamic>();

      var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

      if(Loginprovider.getshowAllTicket().toString()=='true')
        map['userid'] = 'all';
else
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
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });
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

  /*BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        elevation: 10,
        overlayOpacity: 0.7,
        children: [
          MenuItemModel(
//          child: Icon(Icons.accessibility, color: Colors.black, size: 40,),
            child:
                Image.asset('assets/logout_icon.png', color: Colors.grey[850]),
            title: "Logout",
            titleColor: Colors.grey[850]!,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => print('THIRD CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/schemes_icon.png', color: Colors.white),
            title: "List",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/customers_icon.png',
                color: Colors.grey[850]),
            title: "Team",
            titleColor: Colors.grey[850]!,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.grey[850]!,
            backgroundColor: Colors.grey[50]!,
            onTap: () => print('THIRD CHILD'),
            elevation: 10,
          ),
          MenuItemModel(
            child: Image.asset('assets/profile_icon.png', color: Colors.white),
            title: "Profile",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () => print('FOURTH CHILD'),
            elevation: 10,
          )
        ]);
  }
*/
  Future<String?> _showTextInputDialog(
      BuildContext context, String ticketid) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageProvider.Llanguage('ClosTicket')),
            content: TextField(
              controller: _NotetextFieldController,
              decoration: InputDecoration(hintText: ""),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('cancel')),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text(LanguageProvider.Llanguage('Close')),
                onPressed: () => CloseTicket(
                    context, _NotetextFieldController.text, ticketid),
              ),
            ],
          );
        });
  }

  CloseTicket(BuildContext context, String note, String ticketid) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l.Llanguage('ClosTicket')),
              content: Text(l.getLanguage() == "AR"
                  ? 'جار اغلاق التذكره ...'
                  : 'close ticket..'),
            ));

    var map = new Map<String, dynamic>();
    map['userid'] = Loginprovider.getuserId();
    map['ClosedDate'] = now.toString().substring(0, 19);
    map['CloseNote'] = note;
    map['ticketid'] = ticketid;

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse(Globalvireables.CloseTicketURL);

      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));

      var jsonResponse = jsonDecode(response.body);

      print("wheeen" + jsonResponse.toString());

      if (jsonResponse.toString().contains('1S')) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('ClosTicket')),
                  content: Text(l.getLanguage() == "AR"
                      ? 'تم اغلاق التذكره بنجاح'
                      : 'close ticketing is done..'),
                ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('ClosTicket')),
                  content: Text(l.Llanguage('anerror')),
                ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('ClosTicket')),
          content: Text(l.Llanguage('anerror')),
          actions: <Widget>[],
        ),
      );
    }
  }


  TransTicket(BuildContext context) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.Llanguage('transTicket')),
          content: Text(l.getLanguage() == "AR"
              ? 'جار تحويل التذكره ...'
              : 'Trans Ticket..'),
        ));

    var map = new Map<String, dynamic>();
    map['userid'] = Loginprovider.getuserId();
    map['EstimateTime'] = SELECTContrtiome.text;
    map['InternalNotes'] = noteContrtiome.text;
    map['AssignTo'] = idselected.toString();

    map['CloseDate'] = now.toString().substring(0,19);
    map['ticketid'] = ticketidselect.toString();

    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse(Globalvireables.TransTicket);

      http.Response response = await http
          .post(
        apiUrl,
        body: map,
      )
          .whenComplete(() => Navigator.pop(context));

      var jsonResponse = jsonDecode(response.body);

      print("wheeen" + jsonResponse.toString());

      if (jsonResponse.toString().contains('1S')) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('transTicket')),
              content: Text(l.getLanguage() == "AR"
                  ? 'تم التذكره التذكره بنجاح'
                  : 'trans ticketing is done..'),
            ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('transTicket')),
              content: Text(l.Llanguage('anerror')),
            ));
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('transTicket')),
          content: Text(l.Llanguage('anerror')),
          actions: <Widget>[],
        ),
      );
    }
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
  /*Future<List<AllusersModel>> getallusers(BuildContext context) async {
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
*/
}
