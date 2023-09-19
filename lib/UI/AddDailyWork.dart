import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:ticketing/UI/DailyWork.dart';
import 'package:ticketing/UI/Settings.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Models/TicketsModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'OpenTickets.dart';

class AddDailyWork extends StatefulWidget {
  @override
  State<AddDailyWork> createState() => _AddDailyWorkState();
}

class _AddDailyWorkState extends State<AddDailyWork> {
  var check = false;

  @override
  void initState() {
    SELECTContrtiome.text = '1';

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _selectedLocation = 'Please choose a location';
  TextEditingController SELECTContr = TextEditingController();
  TextEditingController SELECTContrtiome = TextEditingController();
  TextEditingController noteContrtiome = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    var colors = [
      HexColor((Globalvireables.secondcolor)),
      HexColor((ThemP.getcolor()))
    ];
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
                LanguageProvider.Llanguage('dailywork'),
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
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: SizedBox(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: SELECTContr,
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
                                hintText:
                                    LanguageProvider.Llanguage("selecttiket"),
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
                                                2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    child: Text(
                                                        LanguageProvider.Llanguage(
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
                                                    color: Colors.grey),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3.1,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1,
                                                  child: FutureBuilder(
                                                    future: getOpenTickets(
                                                        context,
                                                        Loginprovider
                                                                .getuserId()
                                                            .toString()),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                List<
                                                                    TicketsModel>>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<TicketsModel>?
                                                            Visits =
                                                            snapshot.data;
                                                        return ListView(
                                                          physics:
                                                              const AlwaysScrollableScrollPhysics(),
                                                          //
                                                          children: Visits!
                                                              .map(
                                                                  (TicketsModel
                                                                          v) =>
                                                                      Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              SELECTContr.text = v.Id.toString();

                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: SizedBox(
                                                                                  child: Row(
                                                                                children: [
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width / 2.2,
                                                                                    child: Text(
                                                                                      textAlign: TextAlign.right,
                                                                                      v.custNameA.toString(),
                                                                                      style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Text(
                                                                                    v.Id.toString(),
                                                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: 14 * unitHeightValue, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                  Spacer(),
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
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          child: ScrollDatePicker(
                            selectedDate: _selectedDate,
                            locale: Locale(LanguageProvider.langg),
                            maximumDate:
                                DateTime.now().add(const Duration(days: 365)),
                            minimumDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            onDateTimeChanged: (DateTime value) {
                              setState(() {
                                _selectedDate = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            child: Row(
                          children: [
                            Spacer(),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: SELECTContrtiome,
                                keyboardType: TextInputType.number,

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
                                  hintText: '',
                                ),
                                //set it true, so that user will not able to edit text
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                textAlign: TextAlign.center,
                                LanguageProvider.Llanguage('Timework'),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.black),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18 * unitHeightValue),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                textAlign: TextAlign.center,
                                LanguageProvider.Llanguage('notes'),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.black),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18 * unitHeightValue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: noteContrtiome,
                            style: TextStyle(
                                height: 2 // controls the height on main text
                                ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
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
                              hintText: '',
                            ),
                            //set it true, so that user will not able to edit text
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Checkbox(
                                value: check,
                                //set variable for value
                                onChanged: (bool? value) async {
                                  setState(() {
                                    check = !check;

                                    print(check.toString() + " vvvvv");
                                  });
                                }),
                            Text(LanguageProvider.Llanguage("ClosTicket"),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12 * unitHeightValue)),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.2,
                              margin: EdgeInsets.only(top: 10, bottom: 30),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: HexColor(ThemP.getcolor()),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        LanguageProvider.Llanguage('save'),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.tajawal,
                                            color: Colors.white,
                                            fontSize: 14 * unitHeightValue),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  onPressed: () async {
                                    print(_selectedDate.toString());
                                        if(SELECTContr.text.isNotEmpty) {
                          AddDailyWork(context, noteContrtiome.text.toString(),
                              SELECTContr.text,
                              SELECTContrtiome.text.toString());

                          if (check) {
                            CloseTicket(context, noteContrtiome.text.toString(),
                                SELECTContr.text);
                          }
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
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

/*



  DatePickerWidget(
  looping: false, // default is not looping
  firstDate: DateTime(2000, 01, 01),
  lastDate: DateTime(2050, 1, 1),
  initialDate: DateTime(int.parse(y), int.parse(M), 1),
  dateFormat: "MM-yyyy",
  locale: DatePicker.localeFromString('en'),
  onChange: (DateTime newDate, _) => _selectedDate = newDate,
  pickerTheme: DateTimePickerTheme(
  itemTextStyle: ColorMonthTask(context),
  dividerColor: ColorTheme(context),
  ),
  ),


*/

  Future<List<TicketsModel>> getOpenTickets(
      BuildContext context, String useris) async {
    Uri postsURL = Uri.parse(Globalvireables.ticketURL);
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
        builder: (context) => new AlertDialog(
          title: new Text('بيانات المريض'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Profile.";
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageProvider.Llanguage('ClosTicket')),
            content: Text("hgvj"),
            actions: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 6.5,
                child: FutureBuilder(
                  future: getOpenTickets(
                      context, Loginprovider.getuserId().toString()),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TicketsModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<TicketsModel>? OpenTickets = snapshot.data;

                      if (OpenTickets!.isNotEmpty) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: HexColor(ThemP.color)),
                                top: BorderSide(
                                    width: 0.5, color: HexColor(ThemP.color)),
                                left: BorderSide(
                                    width: 0.5, color: HexColor(ThemP.color)),
                                right: BorderSide(
                                    width: 0.5, color: HexColor(ThemP.color)),
                              ),
                            ),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(), //
                              children: OpenTickets!
                                  .map(
                                    (TicketsModel inv) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Text(inv.custNameA.toString(),
                                                style: ArabicTextStyle(
                                                    arabicFont:
                                                        ArabicFont.tajawal,
                                                    color: HexColor(
                                                        Globalvireables.black2),
                                                    fontSize:
                                                        16 * unitHeightValue,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Spacer(),
                                            Text(inv.Id.toString(),
                                                style: ArabicTextStyle(
                                                    arabicFont:
                                                        ArabicFont.tajawal,
                                                    color: HexColor(
                                                        Globalvireables.black2),
                                                    fontSize:
                                                        16 * unitHeightValue,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      } else {
                        return Image.asset(
                          "assets/null.png",
                          height: 100,
                          width: 100,
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  AddDailyWork(BuildContext context, String note, String ticketid,
      String worktime) async {
    var l = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    DateTime now = DateTime.now();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(l.Llanguage('dailywork')),
              content: Text(l.getLanguage() == "AR"
                  ? 'اضافه العمل اليومي ...'
                  : 'send daily work..'),
            ));

    var map = new Map<String, dynamic>();
    map['userid'] = Loginprovider.getuserId();
    map['ClosedDate'] = _selectedDate.toString();
    map['CloseNote'] = note;
    map['ticketid'] = ticketid;
    map['WorkTime'] = worktime;



    print(map.toString() + " inputt");
    try {
      Uri apiUrl = Uri.parse(Globalvireables.AddDailyWork);

      http.Response response = await http
          .post(
            apiUrl,
            body: map,
          )
          .whenComplete(() => Navigator.pop(context));

      var jsonResponse = jsonDecode(response.body);

      print("wheeen" + jsonResponse.toString());

      if (jsonResponse.toString().contains('1S')) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('dailywork')),
                  content: Text(l.getLanguage() == "AR"
                      ? 'تم اضافه العمل اليومي'
                      : 'send daily work is done..'),
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(l.Llanguage('dailywork')),
                  content: Text(l.Llanguage('anerror')),
                ));
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('dailywork')),
          content: Text(l.Llanguage('anerror')),
          actions: <Widget>[],
        ),
      );
    }
  }
}
