import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/pages/auth.dart';
import 'package:konseki_app/pages/history.dart';
import 'package:konseki_app/pages/home.dart';
import 'package:konseki_app/pages/qr_scanner.dart';
import 'package:konseki_app/pages/splash_screen.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.isAuth
                ? MyHomePage(
                    index: 0,
                  )
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              '/home': (context) => MyHomePage(index: 0),
              '/qr-scan': (context) => MyHomePage(index: 1),
              '/history': (context) => MyHomePage(index: 2),
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.index}) : super(key: key);

  int index = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var firstBuild = true;

  final historyInfo = [
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event("History Project", 5, DateTime.now(), "https://google.com"),
        Event("Lunch @ Poke Theory", 2, DateTime.now(), "https://google.com"),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event("History Project", 5, DateTime.now(), "https://google.com"),
        Event("Lunch @ Poke Theory", 2, DateTime.now(), "https://google.com"),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event("History Project", 5, DateTime.now(), "https://google.com"),
        Event("Lunch @ Poke Theory", 2, DateTime.now(), "https://google.com"),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event("History Project", 5, DateTime.now(), "https://google.com"),
        Event("Lunch @ Poke Theory", 2, DateTime.now(), "https://google.com"),
      ],
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstBuild) {
      _selectedIndex = widget.index;
      firstBuild = false;
    }

    var bottomNavBar = BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      elevation: 20,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.code),
        //   label: 'Scan',
        // ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/qr-icon.png")),
          label: 'Scan',
        ),
        // BottomNavigationBarItem(
        //   icon: Container(child: SvgPicture.asset("assets/icons/qr-icon.svg")),
        //   label: 'Scan',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );

    List<Widget> _pages = <Widget>[
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Home(),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        child: QRScanner(
          height: (MediaQuery.of(context).size.height -
                  kBottomNavigationBarHeight -
                  280) /
              2,
          width: (MediaQuery.of(context).size.width - 280) / 2,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: History(historyInfo),
      ),
    ];

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
