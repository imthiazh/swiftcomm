import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:touchngo/screens/attendance/reminder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'dart:convert';
import 'dart:math';
import 'attendance_class.dart';
import 'package:date_format/date_format.dart';

class AttendanceMain extends StatefulWidget {
  static const routeName = '/attendance';

  @override
  _AttendanceMainState createState() => _AttendanceMainState();
}

class _AttendanceMainState extends State<AttendanceMain> {
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return image;
  }

  //var now = new DateTime.now();
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  var d1 = Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);

  bool isNull = true;
  List<Attendance> students = [];
  String fac_name;
  String course;
  List<String> recipients = [
    "8015267555",
    "6379421142",
    "9840212940",
    "6382881228",
    "9962222991"
  ];

  String task_type;
  String task;
  String img;

  @override
  initState() {
    super.initState();

    // Stream<NDEFMessage> stream = NFC.readNDEF();

// stream.listen((NDEFMessage message) {
//     //print("records: ${message.records.length}");
// });
    // writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);

      String raw_json = onData.content;

      dynamic json_content = raw_json.substring(7);

      print(json.decode(json_content));

      json_content = json.decode(json_content) as Map<String, dynamic>;

      setState(() {
        // isNull = false;
        if (json_content["c"] == "flight") {
          isNull = false;
          fac_name = json_content["n"];
          course = json_content["co"];
        } else if (json_content["c"] == "passenger") {
          students.add(Attendance(
            name: json_content["n"],
            rollNo: json_content["r"],
            phoneNo: json_content["p"],
            imageName: json_content["i"],
            // color:
          ));
          img = json_content["i"];
          recipients.remove(json_content["p"]);
          print(img);
        }
        // print(user_cards[0])
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void _sendSMS(String message, List<String> recipents) async {
      String _result = await sendSMS(message: message, recipients: recipients)
          .catchError((onError) {
        print(onError);
      });
      print('success');
    }

    // List<String> sendd = recipents

    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Boarding'),
      ),
      body: isNull //if true  //if false
          ? Center(
              child: Text(
                '''   Authorized Gate Administrator
                Please tap your tag
            ''',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.book,
                    size: 40,
                  ),
                  title: Text('Flight Details',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                ),
                SizedBox(height: 20),
                Card(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //     side: BorderSide(width: 5, color: Colors.grey)),
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Image(image: AssetImage('Images/airplane2.png')),
                        radius: 60.0),
                    title: Text(
                      'Flight Number : ' + fac_name, //AX234
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Route : ' + course, //Chennai to Delhi
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    // title: Text('Sonu Nigam'),
                    // subtitle: Text('Best of Sonu Nigam Song'),
                  ),
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: Icon(
                    Icons.school,
                    size: 40,
                  ),
                  title: Text('On Boarding Flight',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                ),
                SizedBox(height: 20),
                Container(
                  child: students.length == 0
                      ? Center(
                          child: Text(
                            'Gates are open. Request passengers to board.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: students.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(20)),
                              //     side: BorderSide(
                              //         width: 5, color: Colors.green)),
                              child: ListTile(
                                leading: CircleAvatar(
                                    child: Image(
                                        image:
                                            AssetImage('Images/passenger.png')),
                                    radius: 20.0),
                                title:
                                    Text('Name: ' + '${students[index].name}'),
                                subtitle: Text('Seat No: ' +
                                    '${students[index].rollNo}'), //A3,B3,C3
                              ),
                            );
                          }),
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,

                      child: Text(
                        'Gate Closing',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.brown),
                          ),
                        ),
                      ),
                      onPressed: () {
                        String message = 'Gates of Flight Number ' +
                            fac_name +
                            ' is closing at ${format(d1)}' +
                            '. Please proceed to the gates immediately !';
                        // List<String> recipents = [
                        //   "8015267555",
                        //   "8838794840",
                        //   "9941625323"
                        // ];

                        _sendSMS(message, recipients);
                      },
                    ),
                    ElevatedButton(
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,

                      child: Text(
                        'Announcement',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.brown),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Reminder.routeName);
                      },
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

// CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
//                                     radius: 20.0),
