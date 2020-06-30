import 'package:Brew_Crew/models/user.dart';
import 'package:Brew_Crew/services/database.dart';
import 'package:Brew_Crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Brew_Crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(
                      hintText: "Enter your name..."),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                  value: _currentSugars ?? userData.sugars,
                ),
                SizedBox(height: 20.0),
                // slider
                Slider(
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (value) => setState(() {
                    _currentStrength = value.round();
                  }),
                  // value:
                  //     _currentStrength != null ? _currentStrength.toDouble() : 100.00,
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  // onChangeStart: (value) => setState(() {
                  //   _currentStrength = value.toInt();
                  // }),
                  // onChangeEnd: (value) => setState(() {
                  //   _currentStrength = value.toInt();
                  // }),
                ),
                // submit button
                RaisedButton(
                  onPressed: () async {
                    // print(_currentName);
                    // print(_currentSugars);
                    // print(_currentStrength);
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
