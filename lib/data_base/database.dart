import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addCollegTask(Map<String, dynamic> userPersonelMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("College")
        .doc(id)
        .set(userPersonelMap);
  }

  Future addPersonelTask(
      Map<String, dynamic> userPersonelMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Personal")
        .doc(id)
        .set(userPersonelMap);
  }

  Future addOfficeTask(Map<String, dynamic> userPersonelMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Office")
        .doc(id)
        .set(userPersonelMap);
  }

  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }

  tickMethod(String id, String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .update({"Yes": true});
  }

  removeMethod(String id, String task) async {
    return await FirebaseFirestore.instance.collection(task).doc(id).delete();
  }
}
