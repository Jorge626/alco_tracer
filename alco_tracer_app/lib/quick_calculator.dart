import 'package:alco_tracer_app/info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class QuickCalculator extends StatefulWidget {
  const QuickCalculator({Key? key}) : super(key: key);

  @override
  _QuickCalculatorState createState() => _QuickCalculatorState();
}

class _QuickCalculatorState extends State<QuickCalculator> {
  double _bacResult = 0;
  List<bool> isSelected = [false, false];
  TextEditingController _weight = TextEditingController();
  TextEditingController _beers = TextEditingController();
  TextEditingController _shots = TextEditingController();
  TextEditingController _wines = TextEditingController();

  double _convertLbsToGm(weight) {
    return weight * 453.592;
  }

  int _getGramsOfAlcohol(int numOfBeers, int numOfShots, int numOfWines) {
    return (numOfBeers + numOfShots + numOfWines) * 14;
  }

  void _calculateBAC(weight, numOfBeers, numOfShots, numOfWines) {
    setState(() {
      if(!isSelected[0] & !isSelected[1]){
        _bacResult = 0.0;
      }
      else if(weight <= 0){
        _bacResult = 0.0;
      }
      else {
        double R = 0;
        if (isSelected[0])
          R = 0.68; // Male constant
        else if (isSelected[1])
          R = 0.55; // Female constant
        int gramsOfAlcohol =
        _getGramsOfAlcohol(numOfBeers, numOfShots, numOfWines);
        double weightInGrams = _convertLbsToGm(weight);
        _bacResult = gramsOfAlcohol / (weightInGrams * R) * 100;
        _bacResult = double.parse((_bacResult).toStringAsFixed(2));
        print('$_bacResult');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Expanded(
          flex: 11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButtons(
                isSelected: isSelected,
                fillColor: Colors.black26,
                splashColor: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                borderWidth: 2,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.male,
                      color: Colors.blue,
                      size: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.female,
                      color: Colors.pink,
                      size: 80,
                    ),
                  ),
                ],
                onPressed: (int newIndex) {
                  setState(() {
                    for (int index = 0; index < isSelected.length; index++) {
                      if (index == newIndex)
                        isSelected[index] = true;
                      else
                        isSelected[index] = false;
                    }
                  });
                },
              )
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Body Weight in Pounds',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _weight,
                decoration: InputDecoration(
                  hintText: 'Enter Weight',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight_rounded),
                  counterText: "",
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Flexible(
                child: Image(
                  image: AssetImage('assets/beer.png'),
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Image(
                  image: AssetImage('assets/shot.png'),
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Image(
                  image: AssetImage('assets/wine.png'),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Beer 12oz',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Liquor 1.5oz',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Wine 5oz',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 5,
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _beers,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: '0',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_cafe_sharp),
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: TextField(
                    controller: _shots,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: '0',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_drink_sharp),
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: TextField(
                    controller: _wines,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: '0',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_bar),
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                ),
              ],
            )),
        Expanded(
            flex: 5,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Pressed Calculate BAC');
                    print(_weight.text);
                    print(_beers.text);
                    print(_shots.text);
                    print(_wines.text);
                    if (_weight.text.isEmpty) _weight.text = '0';
                    if (_beers.text.isEmpty) _beers.text = '0';
                    if (_shots.text.isEmpty) _shots.text = '0';
                    if (_wines.text.isEmpty) _wines.text = '0';
                    _calculateBAC(
                        double.parse(_weight.text),
                        int.parse(_beers.text),
                        int.parse(_shots.text),
                        int.parse(_wines.text));
                  },
                  child: const Text('Calculate BAC'),
                )
              ],
            )),
        Expanded(
            flex: 10,
            child: Column(
              children: [
                Text(
                  'Your BAC is approximately $_bacResult%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                )
              ],
            )),
      ]),
    );
  }
}
