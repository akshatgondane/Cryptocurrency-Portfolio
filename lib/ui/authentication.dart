import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailField = new TextEditingController();
  TextEditingController passwordField = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: emailField,
                decoration: InputDecoration(
                    hintText: "something@gmail.com",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35,),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: passwordField,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35,),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await register(emailField.text, passwordField.text);
                  if(shouldNavigate)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                    }
                },
                child: new Text("Register")),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35,),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,

              ),
              child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate = await signIn(emailField.text, passwordField.text);
                    if(shouldNavigate)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                    }
                  },

                  child: new Text("Login")),
            ),

          ],
        ),

      ),
    );
  }
}
