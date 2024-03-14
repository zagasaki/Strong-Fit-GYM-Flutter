import 'dart:io';
import 'package:basic/Page/TrainerPage/TrainerModel.dart';
import 'package:basic/Provider/MyProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class TrainerRegister extends StatefulWidget {
  const TrainerRegister({super.key});

  @override
  State<TrainerRegister> createState() => _TrainerRegisterState();
}

class _TrainerRegisterState extends State<TrainerRegister> {
  File? _image;
  final TextEditingController _namatrainer = TextEditingController();
  final TextEditingController _jenistrainer = TextEditingController();
  final TextEditingController _pengalaman = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  List<EventModel> details = [];

  Future<void> _checkPermission(ImageSource source) async {
    PermissionStatus status;

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      return;
    }
    if (status != PermissionStatus.granted) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Izin akses ditolak'),
            content: Column(
              children: [
                const Text(
                    'Untuk menggunakan fitur ini, aktifkan akses kamera di pengaturan perangkat Anda.'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Buka Pengaturan'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      await _checkPermission(source);

      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('User canceled image picking');
      }
    } on PlatformException catch (e) {
      print('Error picking image: $e');
      // ignore: use_build_context_synchronously
    }
  }

  Future<void> _uploadData() async {
    if (_image == null) return;

    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('gambartrainer/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(_image!);

      final String downloadURL = await storageReference.getDownloadURL();

      await Firebase.initializeApp();
      FirebaseFirestore db = FirebaseFirestore.instance;

      String namatrainer = _namatrainer.text;
      String jenistrainer = _jenistrainer.text;
      String pengalaman = _pengalaman.text;
      String contact = _contact.text;

      EventModel insertData = EventModel(
        namatrainer: namatrainer,
        jenistrainer: jenistrainer,
        pengalaman: pengalaman,
        gambartrainer: downloadURL,
        id: '',
        contact: contact,
      );

      await db.collection("trainer_data").add(insertData.toMap());
      setState(() {
        details.add(insertData);
      });

      final uid = context.read<DataProfileProvider>().uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({"Trainer": true});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image uploaded successfully'),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Trainer"),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namatrainer,
              decoration: const InputDecoration(label: Text("Nama Trainer")),
            ),
            TextField(
              controller: _jenistrainer,
              decoration: const InputDecoration(label: Text("Jenis Trainer")),
            ),
            TextField(
              controller: _pengalaman,
              decoration: const InputDecoration(label: Text("Pengalaman")),
            ),
            TextField(
              controller: _contact,
              decoration: const InputDecoration(label: Text("Contact")),
            ),
            if (_image != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Selected Image: ${_image!.path.split('/').last}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            if (_image == null)
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    tooltip: "Pick Image From Camera",
                    icon: const Icon(Icons.camera_front),
                  ),
                  const Text("Pick Image From Camera"),
                ],
              ),
            if (_image == null)
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    tooltip: "Pick Image From Gallery",
                    icon: const Icon(Icons.photo_album),
                  ),
                  const Text("Pick Image From Gallery"),
                ],
              ),
            ElevatedButton(
              onPressed: () async {
                await _uploadData();
                _namatrainer.clear();
                _jenistrainer.clear();
                _pengalaman.clear();
                _contact.clear();
                setState(() {
                  _image = null;
                });
              },
              child: const Text("Daftar"),
            )
          ],
        ),
      ),
    );
  }
}
