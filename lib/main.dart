import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();

  List<bool> _selection = [true, false, false];

  String tip;
  bool isTrueAmount = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (tip != null)
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  tip, 
                  style: TextStyle(fontSize: 30.0),
                ), 
              ), 
            Text(
              "Amount",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              width: 70.0,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "\$100.00"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[0-9.]")),],
              ),
            ),
            if (!isTrueAmount)
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Please enter a valid value!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.5,
                  ),
                ),
              ), 
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ToggleButtons(
                  children: [Text("10%"), Text("15%"), Text("20%")],
                  isSelected: _selection,
                  onPressed: updateSelection),
            ),
            // SizedBox(
            //   height: 45,
            //   width: 120,
            //   child: TextButton(
            //     onPressed: calculateTip,
            //     child: Text(
            //       "Calculate tip",
            //       style: TextStyle(color: Colors.white, fontSize: 16),
            //     ),
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.green,
            //     ),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }

  // void checkingText(){
  //   double value;
  //   setState(() {
  //     try{
  //       value = double.parse(controller.text);
  //     } catch(e) {
  //       isTrueAmount = false;
  //       return;                  
  //     }
  //   });
  // }

  void updateSelection(int selectedIndex) {

  double totalAmount;

    setState(() {
    
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    
      try{
        totalAmount = double.parse(controller.text);
      } catch(e) {
        isTrueAmount = false;
        return;                  
      }
    
      isTrueAmount = true;

      final selected = _selection.indexWhere((element) => element);
      final tipPercentage = [0.1, 0.15, 0.2][selected];
      final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

      tip = "\$$tipTotal";
    
    });
  }
}
