import 'package:Brew_Crew/models/user.dart';
import 'package:Brew_Crew/services/auth.dart';
import 'package:Brew_Crew/shared/constants.dart';
import 'package:Brew_Crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign in to Brew Crew"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Register"),
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
                    RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          setState(() {
                            isLoading = false;
                          });
                          print("Error sign in");
                        } else {
                          print("Signed in");
                          print(result);
                          print(result.uid);
                          // print(result.uid);
                          // print(result.isAnonymous);
                          // print(result.providerData);
                          // print(result.providerId);
                          // print(result.isEmailVerified);
                        }
                      },
                      child: Text("Sign in Anonymously"),
                      color: Colors.blue[200],
                    ),
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
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      isLoading = false;
                                      error =
                                          "Could not sign in with those credentials!";
                                    });
                                  }
                                }
                              },
                              color: Colors.pink[400],
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
