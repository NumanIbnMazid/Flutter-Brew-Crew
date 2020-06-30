import 'package:Brew_Crew/services/auth.dart';
import 'package:Brew_Crew/shared/constants.dart';
import 'package:Brew_Crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign up to to Brew Crew"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"),
                    color: Colors.green,
                  ),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Container(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          TextFormField(
                            validator: (value) =>
                                value.isEmpty ? "Enter an email" : null,
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                            decoration: textInputDecoration.copyWith(
                                hintText: "Enter email..."),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            validator: (value) => value.length < 6
                                ? "Enter a password 6+ chars long"
                                : null,
                            onChanged: (value) {
                              setState(() => password = value);
                            },
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Enter password..."),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "Please provide valid email!";
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            color: Colors.pink[400],
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
