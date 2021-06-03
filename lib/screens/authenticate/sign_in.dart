import 'dart:ui';

import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:touchngo/services/auth.dart';
import 'package:touchngo/shared/constants.dart';
import 'package:touchngo/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
      decoration: boxDecor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar( 
            backgroundColorStart: Colors.blue[600], backgroundColorEnd: Colors.cyan,
            title: Text(
              'Sign In',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                    )),
            actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Register', style: TextStyle(color: Colors.white),),
            onPressed: () => widget.toggleView(),
          ),
        ],
        ),
        body: SingleChildScrollView(
                  child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150.0),
                  Text("Touch 'n' Go", style: TextStyle(fontSize: 30, fontFamily: 'OpenSans', color:Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 80.0),
                  Text("Sign in", style: TextStyle(fontSize: 20, fontFamily: 'OpenSans', color:Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                    color: Colors.transparent,
                  highlightColor: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
                    //color: Colors.pink[400],
                    child: Text(
                      'Let''s Go',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Could not sign in with those credentials';
                          });
                        }
                      }
                    }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}