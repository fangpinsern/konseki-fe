import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/pages/history.dart';
import 'package:konseki_app/pages/home.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final historyInfo = [
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event(
          "History Project",
          5,
          DateTime.now(),
        ),
        Event(
          "Lunch @ Poke Theory",
          2,
          DateTime.now(),
        ),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event(
          "History Project",
          5,
          DateTime.now(),
        ),
        Event(
          "Lunch @ Poke Theory",
          2,
          DateTime.now(),
        ),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event(
          "History Project",
          5,
          DateTime.now(),
        ),
        Event(
          "Lunch @ Poke Theory",
          2,
          DateTime.now(),
        ),
      ],
    ),
    HistoryInfo(
      date: DateTime.now(),
      events: [
        Event(
          "History Project",
          5,
          DateTime.now(),
        ),
        Event(
          "Lunch @ Poke Theory",
          2,
          DateTime.now(),
        ),
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
      Icon(
        Icons.code,
        size: 150,
      ),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: History(historyInfo),
      ),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
