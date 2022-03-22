import 'package:flutter/material.dart';
import 'package:konseki_app/pages/auth.dart';
import 'package:konseki_app/pages/history.dart';
import 'package:konseki_app/pages/home.dart';
import 'package:konseki_app/pages/qr_scanner.dart';
import 'package:konseki_app/pages/splash_screen.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.landscapeRight
  // ]);
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
        ),
        ChangeNotifierProxyProvider<Auth, Events>(
          create: (context) => Events("", []),
          update: (ctx, auth, previousEvents) => Events(auth.token,
              previousEvents == null ? [] : previousEvents.historyInfo),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins',
              textTheme: ThemeData.light().textTheme.copyWith(
                    bodyText1: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    caption: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                    headline1: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                      color: Colors.black,
                    ),
                    headline2: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    headline3: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    headline4: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    button: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    subtitle1: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
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
                            ? const SplashScreen()
                            : const AuthScreen(),
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
          horizontal: MediaQuery.of(context).size.width * 0.08,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
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
        height: MediaQuery.of(context).size.height -
            kBottomNavigationBarHeight -
            280,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: const History(),
      ),
    ];

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
