import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing/Models/LoginModel.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Models/TicketPermisionModel.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import  'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'Home.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _ipControler = TextEditingController();


  var isMackOs=false;
  var check = false;


  @override
  void initState() {
    Getrememper();
    super.initState();
  }

var Terms;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
var prefs;
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  var Loginprovider;
  @override
  Widget build(BuildContext context) {
_ipControler.text='10.0.1.65:9999';
double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
 isMackOs = Theme.of(context).platform == TargetPlatform.macOS;


var ThemP = Provider.of<Them>(context, listen: false);
var LanguageProvider = Provider.of<Language>(context, listen: false);




     Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: EdgeInsets.only(top: isMackOs?10: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: isMackOs?10:30),
                          width: MediaQuery.of(context).size.width / 1,
                          child: Column(
                            children: [
                              Center(
                                child: Container(

                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: isMackOs?MediaQuery.of(context).size.width/9:MediaQuery.of(context).size.width/2,


                                    child: Image(
                                        image: new AssetImage(
                                         "assets/logo.png"))),
                              ),
          Container(
              alignment:Alignment.center,
margin: EdgeInsets.only(top: 0),
              child: Text(
    textAlign: TextAlign.center,
                  LanguageProvider.Llanguage("AlEsraaHospital"),
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      color: HexColor(Globalvireables.black2),
                      fontSize: 25 * unitHeightValue,
                      fontWeight: FontWeight.w700)
              )),
                              SizedBox(
                                height: isMackOs?10:17,

                              ),
                              Container(
                                 width: isMackOs?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/1.3,
                                  margin: EdgeInsets.only(
                                      left: 25, right: 25, top: isMackOs?MediaQuery.of(context).size.width/10:10),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email,color: HexColor(ThemP.getcolor())),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  Globalvireables.black),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
                                              width: 1.0),
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
                                          "username"),
                                    ),
                                  )),
                              Container(
                                  width: isMackOs?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width/1.3,

                                  margin: EdgeInsets.only(
                                      left:  25, right: 25, top: 44),
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _obscured,
                                    controller: _passController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.admin_panel_settings_sharp,color: HexColor(ThemP.getcolor()),),
                                      suffixIcon: GestureDetector(
                                          onTap: _toggleObscured,
                                          child: Icon(_obscured
                                              ? Icons.remove_red_eye_rounded
                                              : Icons.lens_blur_outlined)),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
                                              width: 1.0),
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
                                          'password'),
                                    ),
                                  )),
                             /* Container(
                                  margin: EdgeInsets.only(
                                      left: 25, right: 25, top: 44),
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: _ipControler,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.add_circle),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  ThemP.getcolor()),
                                              width: 1.0),
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
                                      hintText: 'IP Address',
                                    ),
                                  )),*/
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                    width:  isMackOs? MediaQuery.of(context).size.width / 2:
                                      MediaQuery.of(context).size.width / 1.2,
                                  margin: EdgeInsets.only(top: 40, bottom: 5),
                                  color: HexColor(Globalvireables.white),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          HexColor(ThemP.getcolor()),
                                    ),
                                    child: Text(
                                      LanguageProvider.Llanguage('login'),
                                      style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          color:
                                              HexColor(Globalvireables.white),
                                          fontSize: 13 * unitHeightValue),
                                    ),
                                    onPressed: () async {

                                     Login(_emailController.text.toString(),_passController.text.toString(),context);

                                    /*  Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                          (Route<dynamic> route) => false);
                        */            },
                                  ),
                                ),
                              ),
                              if (LanguageProvider.langg == "AR")
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 25, right: 25, top: 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: check,
                                            //set variable for value
                                            onChanged: (bool? value) async {
                                              setState(()  {
                                                check = !check;

                                                if(!check){
                                                  prefs.setString('username','');
                                                  prefs.setString('password','');
                                                }

                                                //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                                //   saveREstate(check.toString());
                                              });
                                            }),
                                        Text(
                                            LanguageProvider.Llanguage(
                                                "RememberMe"),
                                            style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    12 * unitHeightValue)),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left:isMackOs? MediaQuery.of(context).size.width / 4: 10, right: isMackOs? MediaQuery.of(context).size.width / 4: 10, top: 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: check,
                                            //set variable for value
                                            onChanged: (bool? value) async {
                                              setState(() {
                                                check = !check;
                                                cleanRemember(check);
                                                //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                                //   saveREstate(check.toString());
                                              });
                                            }),
                                        Text(
                                            LanguageProvider.Llanguage(
                                                "RememberMe"),
                                            style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    12 * unitHeightValue)),
                                      ],
                                    ),
                                  ),
                                ),




                              SizedBox(

                               child:   isMackOs?null:Align(
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
                                                  'finger'),
                                              style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                  color: Colors.white,
                                                  fontSize: 12 * unitHeightValue),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.fingerprint,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        onPressed: () async {


                                          try {
                                            final bool didAuthenticate = await auth.authenticate(

                                              localizedReason: 'Please authenticate to show account balance',
                                              options: const AuthenticationOptions(useErrorDialogs: true,
                                                  stickyAuth: false,
                                                  sensitiveTransaction: true
                                              ),
                                            );
                                           if(didAuthenticate && check){
                                             prefs = await SharedPreferences.getInstance();
                                             Login(
                                             prefs.getString('username'),
                                             prefs.getString('password'),context
                                             );
                                          }else{
                                             showDialog(
                                                 context: context,
                                                 builder: (_) => AlertDialog(
                                                   title: Text(LanguageProvider.Llanguage('login')),
                                                   content: Text(LanguageProvider.Llanguage('loginerrorfinget')),
                                                 ));
                                           }
                                          } on PlatformException catch (e) {
                                            print("errorlogiin "+ e.message.toString());
                                           /* if (e.code == auth_error.notEnrolled) {
                                              // Add handling of no hardware here.
                                            } else if (e.code == auth_error.lockedOut ||
                                                e.code == auth_error.permanentlyLockedOut) {
                                            } else {
                                             print("errorlogiin "+ e.message.toString());
                                            }*/
                                          }

                                        }),
                                  ),
                                ),
                             ),

                              SizedBox(height: 14),
                              LanguageProvider.getLanguage()!='AR'?
                              Center(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Powered By",
                                      style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                          color: HexColor(Globalvireables.black)),
                                    ),
                                    SizedBox(width: 5,),
                                    Image.asset(
                                      "assets/logo.png",
                                      height: 25,
                                    ),
                                    Spacer()



                                  ],
                                ),
                              ):
                              Center(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Image.asset(
                                      "assets/logo.png",
                                      height: 25,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Powered By",
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(Globalvireables.black)),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              )


                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }


  cleanRemember(bool r) async {
    prefs = await SharedPreferences.getInstance();

    if(!r){
      prefs.setString('username','');
      prefs.setString('password','');
    }

  }
  final LocalAuthentication auth = LocalAuthentication();
  Getrememper() async {
    prefs = await SharedPreferences.getInstance();
   try{
    if(prefs.getString('them')!=null && prefs.getString('them').toString().length>4){
      Provider.of<Them>(context, listen: false).setcolor(prefs.getString('them').toString());
    }}catch(_){

   }

    setState(() {

      Future<void> authinticate() async {

      }

      if(prefs.getString('password').toString().length>1 && prefs.getString('password').toString()!='null'
      && prefs.getString('password').toString()!=null){
        _passController.text= prefs.getString('password').toString();
        _emailController.text= prefs.getString('username').toString();

        check=true;
      }else{
        _passController.text='';
        _emailController.text='';
      }
    });



  }


  Future<List<TicketPermisionModel>> getpermisionTicket(BuildContext context,String id) async {
    Uri postsURL = Uri.parse(Globalvireables.permTicket);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var map = new Map<String, dynamic>();
    map['userid'] =id.toString();

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


        Loginprovider.setshowAllDaily(Doctors[0].showAllDaily.toString());
        Loginprovider.setshowAllTicket(Doctors[0].showAllTicket.toString());


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



  Login(String username, String password, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var l = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title:  Text(l.Llanguage('login')),
          content: Text(l.getLanguage()=="AR"?'جار تسجيل الدخول ...':'Logging in...'),
        ));


    print("UUSER" + username.toString());
    print("PPass" + password.toString());

    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;


  //  try {

      Uri apiUrl = Uri.parse(Globalvireables.loginAPI);

      http.Response response = await http
          .post(apiUrl, body:map,)
          .whenComplete(() => Navigator.pop(context));


      if (response.statusCode == 200) {


      List<dynamic> body = jsonDecode(response.body);

      List<LoginModel> Appoiments = body
          .map(
            (dynamic item) => LoginModel.fromJson(item),
      )
          .toList();

try {
  Loginprovider.settel(Appoiments[0].tel.toString());
  Loginprovider.setemail(Appoiments[0].email.toString());
  Loginprovider.setmangerNameA(Appoiments[0].mangerNameA.toString());
  Loginprovider.setmangerNameE(Appoiments[0].mangerNameE.toString());
  Loginprovider.setdepnameA(Appoiments[0].depnameA.toString());
  Loginprovider.setdepnameE(Appoiments[0].depnameE.toString());
  Loginprovider.setuserId(Appoiments[0].userId.toString());
  Loginprovider.setpassword(password.toString());
  Loginprovider.setuserName(Appoiments[0].userName.toString());
  Loginprovider.setnameA(Appoiments[0].nameA.toString());
  Loginprovider.setnameE(Appoiments[0].nameE.toString());

       prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', Appoiments[0].userId.toString());




      print(Appoiments[0].userName.toString()+ "  ggg");


      getpermisionTicket(context,Appoiments[0].userId.toString());


      }catch(_){}
        if (Appoiments[0].userName.toString().trim() == username) {

          prefs = await SharedPreferences.getInstance();

          if(check){
            prefs.setString('username',username.toString());
            prefs.setString('password',password.toString());
          }


            Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                          (Route<dynamic> route) => false);


        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(l.Llanguage('login')),
                content: Text(l.Llanguage('loginerror')),
              ));
        }}else{

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(l.Llanguage('login')),
              content: Text('errrrrrroooor  '+response.statusCode.toString()),
            ));

      }
 /*   } catch (e) {
      //Navigator.pop(context);
print(e.toString() +"   trtrtrtr");
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(l.Llanguage('login')),
          content: Text(e.toString() ),
          actions: <Widget>[],
        ),
      );

    }*/
  }







}
