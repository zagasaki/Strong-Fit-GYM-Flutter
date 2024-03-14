import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String namasuplemen;
  String jenissuplemen;
  int hargasuplemen;
  String gambarsuplemen;
  String deskripsi;

  EventModel(
      {required this.id,
      required this.namasuplemen,
      required this.jenissuplemen,
      required this.hargasuplemen,
      required this.gambarsuplemen,
      required this.deskripsi});

  Map<String, dynamic> toMap() {
    return {
      'namasuplemen': namasuplemen,
      'jenissuplemen': jenissuplemen,
      'hargasuplemen': hargasuplemen,
      'gambarsuplemen': gambarsuplemen,
      'deskripsi': deskripsi
    };
  }

  EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        namasuplemen = doc.data()?['namasuplemen'],
        jenissuplemen = doc.data()?['jenissuplemen'],
        hargasuplemen = doc.data()?['hargasuplemen'],
        gambarsuplemen = doc.data()?['gambarsuplemen'],
        deskripsi = doc.data()?['deskripsi'];
}
