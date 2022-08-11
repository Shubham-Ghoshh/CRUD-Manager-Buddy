import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String id, String dept, String uid) async {
    return await profileList
        .doc(uid)
        .set({'name': name, 'id': id, 'dept': dept});
  }

  Future updateUserList(String name, String id, String dept, String uid) async {
    return await profileList
        .doc(uid)
        .update({'name': name, 'id': id, 'dept': dept});
  }

  Future deleteUser(String uid) async {
    return await profileList.doc(uid).delete();
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
