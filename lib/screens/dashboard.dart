import 'package:crud/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crud/database_manager/database_manager.dart';
import 'package:crud/services/authentication_services.dart';
import 'package:crud/constants.dart';
import 'package:crud/screens/registration_screen.dart';

class DashboardScreen extends StatefulWidget {
  static String id = "dashboard_id";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();

  List userProfilesList = [];

  String userID = "";
  // final AuthenticationServices _authUser= AuthenticationServices();
  void showDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurpleAccent.shade200,
            title: const Text(
              "Please enter your employee ID and department by clicking on the edit button.",
              style: kTextFieldStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: const Text(
                  "Ok",
                  style: kLabelTextStyle,
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: const Text(
              //     "No",
              //     style: kLabelTextStyle,
              //   ),
              // ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    User getUser = await FirebaseAuth.instance.currentUser!;
    userID = getUser.uid;
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  updateData(String name, String id, String dept, String userID) async {
    await DatabaseManager().updateUserList(name, id, dept, userID);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 14),
          child: Text(
            "DashBoard",
            style: TextStyle(fontFamily: "Spartan MB", color: Colors.black54),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        actions: [
          RaisedButton(
            color: Colors.deepPurpleAccent,
            onPressed: () {
              openDialogueBox(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 0),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await _auth.signOut().then((result) {
                Navigator.of(context).pop(true);
              });
            },
            color: Colors.deepPurpleAccent,
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: userProfilesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Card(
                elevation: 2,
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    userProfilesList[index]['name'],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: "Spartan MB",
                    ),
                  ),
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Image(
                      image: AssetImage('images/crud4.png'),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'ID: ${userProfilesList[index]["id"]}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Catamaran",
                      ),
                    ),
                  ),
                  trailing: Text(
                    '${userProfilesList[index]["dept"]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Catamaran",
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () async {
            await DatabaseManager().deleteUser(userID);
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.deepPurpleAccent.shade200,
                    title: const Text(
                      "Do you want to delete your profile info?",
                      style: kTextFieldStyle,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: const Text(
                          "Yes",
                          style: kLabelTextStyle,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "No",
                          style: kLabelTextStyle,
                        ),
                      ),
                    ],
                  );
                });
          },
          splashColor: Colors.black,
          tooltip: 'Delete Current User',
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            'Edit User Details',
            style: kTextFieldStyle,
          ),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    hintText: 'Employee ID',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    hintText: 'Department',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                )
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                submitAction(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Submit',
                style: kTextFieldStyle,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: kTextFieldStyle,
              ),
            )
          ],
        );
      },
    );
  }

  submitAction(BuildContext context) {
    updateData(_nameController.text, _idController.text,
        _departmentController.text, userID);
    _nameController.clear();
    _idController.clear();
    _departmentController.clear();
  }
}
