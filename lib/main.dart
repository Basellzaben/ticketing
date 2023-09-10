import 'dart:convert';
import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arabic_font/arabic_font.dart';
import 'package:ticketing/provider/LoginProvider.dart';
import 'package:ticketing/provider/Them.dart';
import 'package:ticketing/provider/languageProvider.dart';
import 'GlobalVar.dart';
import 'HexaColor.dart';
import 'Models/TicketsModel.dart';
import 'UI/LoginScreen.dart';
import 'NotificationService.dart';
import 'package:http/http.dart' as http;

String language = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Language>(create: (_) => Language()),
        ChangeNotifierProvider<Them>(create: (_) => Them()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      )));
  initializeService();
  NotificationService().initNotification();
}

const notificationChannelId = 'background_test';
const notificationId = 424;
var ticketId = '';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUNDSERVICE',
    description: 'hello world',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
    ),
  );
  service.startService();
}

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  /* if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });*/

  var initcount = 0;
  Timer.periodic(const Duration(seconds: 2), (timer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("EXUCUTE");

    // try{
    if (prefs.getString('userid') != 'null') {
      var count =
          int.parse(await getOpenTickets(prefs.getString('userid').toString()));

      var tiketid = await prefs.getString('ticketId');
      var tiketdesc = await prefs.getString('ticketDesc');

      try {





        if (initcount < count) {
          NotificationService().showNotification(
              id: count,
              title: ' التذكره رقم $tiketid  تم تحويلها لك ',
              body: tiketdesc);
        }
        initcount = int.parse(
            await getOpenTickets(prefs.getString('userid').toString()));
      } catch (E) {
        print("ERROR WHEN GET DATA    $E");
      }
    }

    /* if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "App in background...",
        content: "Update ${DateTime.now()}",
      );
    }
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );*/
  });
}

final globalNavigatorKey = GlobalKey<NavigatorState>();

getOpenTickets(String useris) async {
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

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ticketId', Doctors.last.Id.toString());
      await prefs.setString('ticketDesc', Doctors.last.IssueDescr.toString());
      await prefs.setString('ticketDate', Doctors.last.TicketDate.toString().substring(5,10));

    //  print("this is datee   " + Doctors.last.TicketDate.toString().substring(5,7));

      return Doctors.length.toString();
    } else {
      throw "Unable to retrieve Profile.";
    }
  } catch (e) {}

  throw "Unable to retrieve Profile.";
}

var x;

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    x = context;
    return MaterialApp(
      key: globalNavigatorKey,
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'F'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var isMackOs;

class _MyHomePageState extends State<MyHomePage> {
  SetLanguage(BuildContext context) async {
    var language;
    SharedPreferences pref = await SharedPreferences.getInstance();
    language = pref.get('language') ?? 'AR';
    if (language == null || language.isEmpty) {
      language = 'AR';
    } else {
      language = 'AR';
    }
    pref.setString('language', language);
    Provider.of<Language>(context, listen: false).setLanguage(language);
    print(language + " laaan");
  }

  @override
  Widget build(BuildContext context) {
    isMackOs = Theme.of(context).platform == TargetPlatform.macOS;

    SetLanguage(context);
    return EasySplashScreen(
      backgroundImage: Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ).image,
      logoWidth: isMackOs
          ? MediaQuery.of(context).size.width / 10
          : MediaQuery.of(context).size.width / 2.5,
      loaderColor: HexColor(Globalvireables.basecolor),
      logo: Image.asset(
        "assets/logo.png",
      ),
      showLoader: true,
      title: Text(
        textAlign: TextAlign.center,
        'شريكك الاستراتيجي للنجاح\n' + 'Your Strategic partner to success',
        style: ArabicTextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 22,
          arabicFont: ArabicFont.tajawal,
        ),
      ),
      loadingText: Text(
        '',
        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(Globalvireables.basecolor)),
      ),
      navigator: LoginScreen(),
      durationInSeconds: 5,
    );
  }
}
