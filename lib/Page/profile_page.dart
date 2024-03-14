import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:basic/Provider/MyProvider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;

  Future<void> _uploadData() async {
    if (_imageFile == null) return;

    try {
      final data = context.read<DataProfileProvider>();
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profilephoto/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(_imageFile!);

      final downloadURL = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(data.uid)
          .update({
        'profilephoto': downloadURL,
      });

      data.updateProfilePhoto(downloadURL);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile image uploaded successfully'),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final datauser = Provider.of<DataProfileProvider>(context);
    const double topWidgetHeight = 200.0;
    const double avatarRadius = 68.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(250, 28, 23, 33),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 190,
                width: double.infinity,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 58, 10, 51)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 200,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datauser.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          datauser.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.black87),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'CITY:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                datauser.city,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width / 2) - avatarRadius - 110,
            top: topWidgetHeight - avatarRadius - 40,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Choose an option"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text("Take a picture"),
                              onTap: () async {
                                Navigator.pop(context);
                                await _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              title: const Text("Pick from gallery"),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(datauser.profilephoto ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJTyP_dN0d_ljlUG7dduuzl3la_T1LktyL3fboeTs66A&s"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
