import 'package:flutter/material.dart';
import 'package:touchngo/screens/sos.dart';
import 'package:touchngo/screens/verify.dart';
import 'package:touchngo/services/auth.dart';
import 'package:touchngo/widgets/main_drawer.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  bool verified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Navigator.of(context).pushNamed(Verify.routeName);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Sos()),
    // );
    new Future.delayed(Duration.zero, () {
    showDialog(context: context, 
    builder: (BuildContext context) {
      verified = true;
      return Verify();
    });
  });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: GradientAppBar( 
            backgroundColorStart: Colors.blue[600], backgroundColorEnd: Colors.cyan,
            title: Text(
              'Home',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                    )),
            actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        // appBar: AppBar(
        //   title: Text('Home'),
        //   backgroundColor: Colors.purple[400],
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     FlatButton.icon(
        //       icon: Icon(
        //         Icons.person,
        //         color: Colors.white,
        //       ),
        //       label: Text('Logout', style: TextStyle(color: Colors.white)),
        //       onPressed: () async {
        //         await _auth.signOut();
        //       },
        //     ),
        //   ],
        // ),
        drawer: MainDrawer(),
        body: DecoratedBox(
          child: Container(
            // color: Color.fromRGBO(177, 32, 64, 0.3), 	173, 216, 230
            color: Color.fromRGBO(0, 128 , 255, 0.3
            ),
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 216, bottom: 8),
                  child: Center(
                    child: Text(
                      '  Your NFC\n Destination',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 64),
                  child: Center(
                    child: Text(
                      'Check out our features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
