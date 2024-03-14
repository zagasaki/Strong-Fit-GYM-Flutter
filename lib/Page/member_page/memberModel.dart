import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String tipemember;
  int hargamember;
  String deskripsi;
  List<String> benefit; // Change 'Array' to 'List<String>'

  EventModel({
    required this.id,
    required this.tipemember,
    required this.hargamember,
    required this.deskripsi,
    required this.benefit,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipemember': tipemember,
      'hargamember': hargamember,
      'deskripsi': deskripsi,
      'benefit': benefit,
    };
  }

  EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        tipemember = doc.data()?['tipemember'],
        hargamember = doc.data()?['hargamember'],
        deskripsi = doc.data()?['deskripsi'],
        benefit = List<String>.from(doc.data()?['benefit'] ?? []);
}
