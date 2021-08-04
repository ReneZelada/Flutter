import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: Settings(),
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<Settings> {
  String dropdownValue = 'Imperial';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Super Hero'),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[

        ],
      ),
      body: Container(
          padding: new EdgeInsets.all(50.0),
      child: Column(
      children: <Widget>[
        Row(children: [
          Text("Units"),
          Spacer(),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.red),
            underline: Container(
              height: 2,
              color: Colors.red,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Imperial', 'Metric']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],),

      ]
      )
      )
     );
  }
}
