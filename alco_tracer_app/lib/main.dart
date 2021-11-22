import 'package:alco_tracer_app/info_page.dart';
import 'package:alco_tracer_app/quick_calculator.dart';
import 'package:alco_tracer_app/advanced_calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlcoTracer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AlcoTracer(),
    );
  }
}

class AlcoTracer extends StatefulWidget {
  @override
  _AlcoTracerState createState() => _AlcoTracerState();
}

class _AlcoTracerState extends State<AlcoTracer> {
  int _currentIndex = 0;

  List _widgets = [
    QuickCalculator(),
    AdvancedCalculator(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('AlcoTracer'),
        centerTitle: true,
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.info),
          color: Colors.white,
          onPressed: () {
            print('Clicked on Info');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => InfoPage()));
          },
        ),
      ),
      body: _widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          selectedFontSize: 15,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.flash_on,
              ),
              label: 'Quick Calculator',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.control_point,
              ),
              label: 'Advanced Calculator',
              backgroundColor: Colors.white,
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
