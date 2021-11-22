import 'package:alco_tracer_app/beverage_class.dart';
import 'package:flutter/material.dart';

class AdvancedCalculator extends StatefulWidget {
  const AdvancedCalculator({Key? key}) : super(key: key);

  @override
  _AdvancedCalculatorState createState() => _AdvancedCalculatorState();
}

class _AdvancedCalculatorState extends State<AdvancedCalculator> {
  double _bacResult = 0;
  List<bool> isSelected = [false, false];
  List<Beverage> beverages = <Beverage>[];
  TextEditingController _weight = TextEditingController();
  TextEditingController _hours = TextEditingController();
  TextEditingController _minutes = TextEditingController();

  double _convertLbsToGm(weight) {
    return weight * 453.592;
  }

  double _getGramsOfAlcohol() {
    double gramsOfAlcohol = 0;
    for (int i = 0; i < beverages.length; i++) {
      gramsOfAlcohol += (beverages[i].oz *
              29.5735 *
              (beverages[i].abv / 100) *
              0.789) *
          beverages[i]
              .totalDrinks; // 29.5735 = US fluid oz, 0.789 = Ethanol Density
    }
    return gramsOfAlcohol;
  }

  double _subtractTotalTime(double hours, double minutes, double BAC) {
    return (BAC - (hours * 0.015) - ((minutes / 60) * 0.015));
  }

  void _calculateBAC(double weight, double hours, double minutes) {
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
        else if (isSelected[1]) R = 0.55; // Female constant
        double gramsOfAlcohol = _getGramsOfAlcohol();
        double weightInGrams = _convertLbsToGm(weight);
        _bacResult = gramsOfAlcohol / (weightInGrams * R) * 100;
        _bacResult = _subtractTotalTime(hours, minutes, _bacResult);
        if (_bacResult < 0)
          _bacResult = 0;
        else
          _bacResult = double.parse((_bacResult).toStringAsFixed(2));
        print('$_bacResult');
      }
    });
  }

  void addBeverage(index) {
    setState(() {
      beverages[index].totalDrinks++;
    });
  }

  void subtractBeverage(index) {
    setState(() {
      if (beverages[index].totalDrinks != 0) beverages[index].totalDrinks--;
    });
  }

  void addItemToBeverages(name, oz, abv, totalDrinks) {
    setState(() {
      beverages.insert(beverages.length, Beverage(name, oz, abv, totalDrinks));
    });
  }

  void deleteBeverage(BuildContext context) {
    setState(() {
      beverages.remove(context);
    });
  }

  void displayBACResult(){
    Text(
      'Your BAC is approximately $_bacResult%',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.orange,
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addBeveragePrompt(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _beverageName = TextEditingController();
        final TextEditingController _beverageOz = TextEditingController();
        final TextEditingController _beverageABV = TextEditingController();
        final TextEditingController _totalDrinks = TextEditingController();
        return AlertDialog(
          content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Beverage name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? "Invalid field" : null;
                      },
                      controller: _beverageName,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      maxLength: 19,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Text('Total Oz',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )),
                        ),
                        Expanded(
                          flex: 50,
                          child: Text('ABV',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: TextFormField(
                            validator: (value) {
                              return value!.isEmpty ? "Invalid field" : null;
                            },
                            controller: _beverageOz,
                            decoration: InputDecoration(
                              hintText: "Oz",
                              border: OutlineInputBorder(),
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 50,
                          child: TextFormField(
                            validator: (value) {
                              return value!.isEmpty ? "Invalid field" : null;
                            },
                            controller: _beverageABV,
                            decoration: InputDecoration(
                              hintText: "ABV",
                              border: OutlineInputBorder(),
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Drinks consumed',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? "Invalid field" : null;
                      },
                      controller: _totalDrinks,
                      decoration: InputDecoration(
                        hintText: "0",
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                  ],
                ),
              )),
          actions: <Widget>[
            TextButton(
              child: Text("Add beverage"),
              onPressed: () {
                final form = _formKey.currentState;
                if (form != null && !form.validate()) {
                  // Invalid!
                  return;
                }
                addItemToBeverages(
                    _beverageName.text,
                    double.parse(_beverageOz.text),
                    double.parse(_beverageABV.text),
                    int.parse(_totalDrinks.text));
                form?.save();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> deleteBeveragePrompt(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _beverageName = TextEditingController();
          final TextEditingController _beverageOz = TextEditingController();
          final TextEditingController _beverageABV = TextEditingController();
          final TextEditingController _totalDrinks = TextEditingController();
          return AlertDialog(
              content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Delete Beverage?"),
                Row(
                  children: [
                    Expanded(
                      flex: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Deny button pressed');
                          Navigator.of(context).pop();
                        },
                        child: const Text('Deny'),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Pressed Confirm');
                          deleteBeverage(context);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirm'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            SizedBox(height: 15),
            Row(
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
            SizedBox(height: 15),
            Column(
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Alcoholic Beverages',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  )),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: beverages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 40,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text('${beverages[index].name}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                          child: Text('${beverages[index].oz}oz',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                          child: Text('${beverages[index].abv}% ABV',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.red,
                        onPressed: () async {
                          if (beverages[index].totalDrinks == 0) {
                            print('Tried subtracting from 0, Delete prompt');
                            //await deleteBeveragePrompt(context);
                          } else
                            subtractBeverage(index);
                        },
                      ),
                      Text('${beverages[index].totalDrinks}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          )),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.green,
                        onPressed: () {
                          addBeverage(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                print('Clicked on add beverage button');
                await addBeveragePrompt(context);
              },
              child: const Text('Add Alcoholic Beverage'),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Time Since First Drink',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: _hours,
                    decoration: InputDecoration(
                      hintText: 'Hour(s)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight_rounded),
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: TextField(
                    controller: _minutes,
                    decoration: InputDecoration(
                      hintText: 'Minute(s)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight_rounded),
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Pressed Calculate BAC');
                    print(_weight.text);
                    print(_hours.text);
                    print(_minutes.text);
                    if (_weight.text.isEmpty) _weight.text = '0';
                    if (_hours.text.isEmpty) _hours.text = '0';
                    if (_minutes.text.isEmpty) _minutes.text = '0';
                    _calculateBAC(double.parse(_weight.text),
                        double.parse(_hours.text), double.parse(_minutes.text));
                  },
                  child: const Text('Calculate BAC'),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Your BAC is approximately $_bacResult%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),

              ],
            ),
          ]),
        ),
      );
}
