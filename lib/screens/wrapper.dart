import 'package:Brew_Crew/models/user.dart';
import 'package:Brew_Crew/screens/authenticate/authenticate.dart';
import 'package:Brew_Crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(user);
    // return either home or authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
