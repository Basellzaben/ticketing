import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing/UI/DailyWork.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'package:arabic_font/arabic_font.dart';
import 'package:http/http.dart' as http;

import 'LoginScreen.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
var Terms='';
  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
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
                  label: LanguageProvider.Llanguage('Home')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: LanguageProvider.Llanguage('dailywork')
              ),
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
            title: Widgets.Appbar(context, LanguageProvider.Llanguage('settings'), unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
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
            child: Directionality(
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
                    child: Container(
                      padding: EdgeInsets.only(left: 11, right: 11),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                    alignment: LanguageProvider.Align(),
                                    child: Text(
                                      LanguageProvider.Llanguage("general"),
                                      style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          fontSize: 17.5 * unitHeightValue,
                                          color: HexColor(Globalvireables.grey),
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {

                                    setState(() {
                                      if (LanguageProvider.getLanguage() ==
                                          'AR') {
                                        LanguageProvider.setLanguage('EN');
                                      } else {
                                        LanguageProvider.setLanguage('AR');
                                      }
                                    });
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setString(
                                        'language', LanguageProvider.langg);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color:
                                            HexColor(ThemP.getcolor()),
                                        size: 35 * unitHeightValue,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage('language'),
                                        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color:
                                                HexColor(Globalvireables.black),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        LanguageProvider.getLanguage(),
                                        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          fontSize: 15.5 * unitHeightValue,
                                          color: HexColor(Globalvireables.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 6,
                                ),

                                SizedBox(
                                  height: 6,
                                ),
                                Divider(thickness: 1.0, color: Colors.black),

                                GestureDetector(
                                    onTap: () async {

                                      showLoaderDialog( context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.color_lens_outlined,
                                          color: HexColor(
                                              ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage('theme'),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color: HexColor(
                                                  Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )),

                                SizedBox(
                                  height: 6,
                                ),
                                Divider(
                                    thickness: 1.0, color: Colors.black
                                ),

                                GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: Text(
                                                  LanguageProvider.Llanguage('Logout'),
                                                  style: ArabicTextStyle(
                                                      arabicFont: ArabicFont.tajawal,
                                                      fontSize: 22 *
                                                          unitHeightValue)),
                                              content: Text(
                                                LanguageProvider.Llanguage("txxt"),
                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    fontSize:
                                                    14 * unitHeightValue),
                                              ),
                                              actions: [
                                                TextButton(
                                                  //  textColor: Colors.black,
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen(),
                                                        ),
                                                            (Route<dynamic>
                                                        route) =>
                                                        false);
                                                  },
                                                  child: Text(
                                                    LanguageProvider.Llanguage('Logout'),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        color: Colors.redAccent,
                                                        fontSize: 15 *
                                                            unitHeightValue),
                                                  ),
                                                ),
                                                TextButton(
                                                  // textColor: Colors.black,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();


                                                  },
                                                  child: Text(
                                                    LanguageProvider.Llanguage('cancel'),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        color: Colors.black87,
                                                        fontSize: 15 *
                                                            unitHeightValue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      //Widgets.ShowLoaderDialog(context, "Logout","");
                                      /*Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
              (Route<dynamic> route) => false);*/
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout_outlined,
                                          color: HexColor(
                                              ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage('Logout'),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color: HexColor(
                                                  Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )),

                                SizedBox(
                                  height: 40,
                                ),
                                Align(
                                    alignment: LanguageProvider.Align(),
                                    child: Text(
                                      LanguageProvider.Llanguage("Feedback"),
                                      style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          fontSize: 17.5 * unitHeightValue,
                                          color:
                                              HexColor(Globalvireables.black),
                                          fontWeight: FontWeight.w400),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                onTap: ()  {

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Expanded(
                                          child: AlertDialog(
                                            title: Center(
                                              child: Text(
                                                  textAlign: TextAlign.center,

                                                  LanguageProvider.Llanguage("Feedback"),
                                                  style: ArabicTextStyle(
                                                      arabicFont: ArabicFont.tajawal,
                                                      fontSize: 22 *
                                                          unitHeightValue)),
                                            ),
                                            content: Text(
                                              textAlign: TextAlign.center,

                                              LanguageProvider.Llanguage("descapp"),
                                              style: ArabicTextStyle(
                                                  arabicFont: ArabicFont.tajawal,
                                                  fontSize:
                                                  16 * unitHeightValue),
                                            ),
                                            actions: [



                                            ],
                                          ),
                                        );
                                      },
                                    );








    },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.report_gmailerrorred,
                                        color:
                                            HexColor(ThemP.getcolor()),
                                        size: 35 * unitHeightValue,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage("Feedback"),
                                        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color:
                                                HexColor(Globalvireables.black),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),







                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              textDirection: LanguageProvider.getDirection(),
            ),
          )),
    ]);
  }
  _onItemTapped(int index) {
    if(index != 0){
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




  showLoaderDialog(BuildContext context) {


    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        builder: (context) {
          return SizedBox(
            height: 320,
            child: Column(
              children: <Widget>
              [
SizedBox(height: 15,),
                Row(children: [


                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(Provider.of<Language>(context, listen: false).Llanguage('selectcolor'),

                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                fontSize: 18.5 * (MediaQuery.of(context).size.height * 0.00122),
                                color: HexColor(Globalvireables.black),
                                fontWeight: FontWeight.w500)
                        )
                    ),
                  ),

                ],),
                Spacer(),

                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.basecolor);

                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.basecolor);
                          Navigator.pop(context);

                          setState(() {   });
                          setState(() {

                          });

                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.basecolor),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them1);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them1);

                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:HexColor(Globalvireables.them1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them2);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them2);

                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them2),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                  ],
                ),
                Spacer(),

                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them3);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them3);

                          Navigator.pop(context);
                          setState(() {

                          });

                        }, child:Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them4);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them4);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them5);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them5);

                          Navigator.pop(context);
                          setState(() {

                          });
                        },  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them5),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer()
                  ],
                ),
                Spacer(),

              ]

              ,
            ),
          );
        });


  }



}
