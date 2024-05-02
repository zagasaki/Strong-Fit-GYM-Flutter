import 'dart:io';
import 'package:basic/Page/suplemen_page/SuplemenModel.dart';
import 'package:basic/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:basic/Component/notification.dart';

class Seller extends StatefulWidget {
  const Seller({
    super.key,
  });

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  File? _image;
  final TextEditingController _namasuplemen = TextEditingController();
  final TextEditingController _jenissuplemen = TextEditingController();
  final TextEditingController _hargasuplemen = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  List<EventModel> details = [];
  bool _isLoading = false;
  final notifikasi = Notifikasi();

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
            title: const Text('Access permission denied'),
            content: Column(
              children: [
                const Text(
                    'To use this feature, enable camera access in your device settings.'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Open Settings'),
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
    }
  }

  Future<void> _uploadData() async {
    if (_image == null || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (_namasuplemen.text.isEmpty ||
        _jenissuplemen.text.isEmpty ||
        _hargasuplemen.text.isEmpty ||
        _deskripsi.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('All fields must be filled'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('gambarsuplemen/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(_image!);

      final String downloadURL = await storageReference.getDownloadURL();

      await Firebase.initializeApp();
      FirebaseFirestore db = FirebaseFirestore.instance;

      String namasuplemen = _namasuplemen.text;
      String jenissuplemen = _jenissuplemen.text;
      String deskripsi = _deskripsi.text;
      int hargasuplemen = int.parse(_hargasuplemen.text);

      EventModel insertData = EventModel(
        namasuplemen: namasuplemen,
        jenissuplemen: jenissuplemen,
        hargasuplemen: hargasuplemen,
        deskripsi: deskripsi,
        gambarsuplemen: downloadURL,
        id: '',
      );

      await db.collection("suplemen_shop").add(insertData.toMap());
      setState(() {
        details.add(insertData);
      });

      setState(() {
        _image = null;
      });
      _namasuplemen.clear();
      _hargasuplemen.clear();
      _jenissuplemen.clear();
      _deskripsi.clear();

      notifikasi.showPesanNotif(
          'Item Sold', 'Your item has been sold successfully!');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image uploaded successfully'),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbase,
      appBar: AppBar(
        backgroundColor: colorbase,
        title: const Text(
          "Sell item",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namasuplemen,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text("Suplemen Name",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            TextField(
              controller: _jenissuplemen,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text("Suplemen Type",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            TextField(
              controller: _hargasuplemen,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text("Price", style: TextStyle(color: Colors.white)),
              ),
            ),
            TextField(
              controller: _deskripsi,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label:
                    Text("Description", style: TextStyle(color: Colors.white)),
              ),
            ),
            if (_image != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Selected Image: ${_image!.path.split('/').last}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
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
                    icon: const Icon(
                      Icons.camera_front,
                      color: Colors.white,
                    ),
                  ),
                  const Text("Pick Image From Camera",
                      style: TextStyle(color: Colors.white)),
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
                    icon: const Icon(
                      Icons.photo_album,
                      color: Colors.white,
                    ),
                  ),
                  const Text("Pick Image From Gallery",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      await _uploadData();
                    },
              child: const Text("Sell Item",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
