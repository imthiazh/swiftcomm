import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class Reminder extends StatelessWidget {
  static const routeName = '/reminder';

  @override
  Widget build(BuildContext context) {
    String task_type;
    String task;
    List<String> contacts = [
      "8015267555",
      "6379421142",
      "9840212940",
      "6382881228",
      "9962222991"
    ];

    void _sendReminder(String message, List<String> recipents) async {
      String _result = await sendSMS(message: message, recipients: recipents)
          .catchError((onError) {
        print(onError);
      });
      print('success');
    }

    return Scaffold(
      body: DecoratedBox(
        child: Container(
          color: Color.fromRGBO(177, 32, 64, 0.3),
          height: double.infinity,
          width: double.infinity,
          child: new Column(
            children: <Widget>[
              SizedBox(height: 230),
              Text(
                'ANNOUNCEMENT',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const Divider(
                height: 5.0,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              new ListTile(
                leading: const Icon(Icons.work),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Title",
                  ),
                  onChanged: (_val) {
                    task_type = _val;
                  },
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.description),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Description",
                  ),
                  onChanged: (_val) {
                    task = _val;
                  },
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    String message = task_type + ' : ' + task;
                    // List<String> recipents = [
                    //   "8015267555",
                    //   "8838794840",
                    //   "9941625323"
                    // ];

                    _sendReminder(message, contacts);
                  },
                  child: new Text('Send Announcement')),
              const Divider(
                height: 1.0,
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
    );
  }
}
