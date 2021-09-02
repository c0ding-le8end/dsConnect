import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Login extends StatefulWidget {

  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Color backgroundColor1 = const Color(0xFF444152);
  final Color backgroundColor2 = const Color(0xFF6f6c7d);
  final Color highlightColor = const Color(0xfff65aa3);
  final Color foregroundColor = Colors.white;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authenticator;
  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "MainScreen");
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
  }
  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration:  BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment.centerLeft,
              end:  Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
              colors: [this.backgroundColor1, this.backgroundColor2], // whitish to gray
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: this.foregroundColor, width: 0.5, style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.alternate_email,
                            color: this.foregroundColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (input) {
                              if (input.isEmpty) return 'Enter Email';
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'example@dsconnect.com',
                              hintStyle: TextStyle(color: this.foregroundColor),

                            ),
                              onSaved: (input) => _email = (input+"@dsconnect.com")
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: this.foregroundColor, width: 0.5, style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.lock_open,
                            color: this.foregroundColor,

                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (input) {
                              if (input.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '*********',
                              hintStyle: TextStyle(color: this.foregroundColor),

                            ),
                              onSaved: (input) => _password = input
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    onPressed: login,
                    child: Text('Login',
                        style: TextStyle(
                          fontSize: 22.0,
                          // fontWeight: FontWeight.bold
                        )),

                  ),
                ],
              ),
            ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                child:  Row(
                  children: <Widget>[
                    Expanded(
                      child:  FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        color: Colors.transparent,
                        onPressed: () => {},
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(color: this.foregroundColor.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Divider(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
