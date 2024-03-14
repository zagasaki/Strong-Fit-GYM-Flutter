import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String namatrainer;
  String jenistrainer;
  String contact;
  String gambartrainer;
  String pengalaman;

  EventModel(
      {this.id,
      required this.namatrainer,
      required this.jenistrainer,
      required this.contact,
      required this.gambartrainer,
      required this.pengalaman});

  Map<String, dynamic> toMap() {
    return {
      'namatrainer': namatrainer,
      'jenistrainer': jenistrainer,
      'contact': contact,
      'gambartrainer': gambartrainer,
      'pengalaman': pengalaman
    };
  }

  EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        namatrainer = doc.data()?['namatrainer'],
        jenistrainer = doc.data()?['jenistrainer'],
        contact = doc.data()?['contact'],
        gambartrainer = doc.data()?['gambartrainer'],
        pengalaman = doc.data()?['pengalaman'];
}
