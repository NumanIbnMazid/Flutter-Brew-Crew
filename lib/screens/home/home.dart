import 'package:Brew_Crew/models/brew.dart';
import 'package:Brew_Crew/screens/home/brew_list.dart';
import 'package:Brew_Crew/screens/home/settings_form.dart';
import 'package:Brew_Crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:Brew_Crew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 3, 10.0),
                child: FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Logout"),
                  color: Colors.pink,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 3, 10.0),
                child: FlatButton.icon(
                  onPressed: () {
                    _showSettingsPannel();
                  },
                  icon: Icon(Icons.settings),
                  label: Text("Settings"),
                  color: Colors.blue,
                ),
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList(),
          ),
        ),
      ),
    );
  }
}
