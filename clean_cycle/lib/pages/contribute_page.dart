import 'package:clean_cycle/controllers/collection_center_controller.dart';
import 'package:clean_cycle/models/collection_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContributePage extends StatefulWidget {
  const ContributePage({super.key});

  @override
  ContributePageState createState() => ContributePageState();
}

class ContributePageState extends State<ContributePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(CollectionCenterController());

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 78, 77, 77),
      ),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row with Backward Arrow and Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Contribute Item',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Item Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter item name (e.g: bottles, plastic, cans, TV)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your item';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description (optional)',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter item description',
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tags(select most appropriate tags)',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  CheckboxListTile(
                    title: const Text('Recycle'),
                    value: controller.isRecycle,
                    onChanged: (bool? value) {
                      setState(() {
                        controller.isRecycle = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Re-Use'),
                    value: controller.isReuse,
                    onChanged: (bool? value) {
                      setState(() {
                        controller.isReuse = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity, // Make button take full width
                          child: ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text(
                              'Take Photo',
                              style:
                                  TextStyle(fontSize: 20), // Increase font size
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0), // Increase button height
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity, // Make button take full width
                          child: ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library),
                            label: const Text(
                              'Select photo',
                              style:
                                  TextStyle(fontSize: 20), // Increase font size
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0), // Increase button height
                            ),
                          ),
                        ),
                      ),
                      if (_image != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.file(
                            _image!,
                            height: 150,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic to submit the request
                        List<String> categorylist = [];
                        if (controller.isRecycle) {categorylist.add("Recycle");}
                        if (controller.isReuse) {categorylist.add("Reuse");}

                        if (formKey.currentState!.validate()) {
                            final item = CollectionItemModel(
                              name: controller.nameController.text.trim(),
                              description: controller.descriptionController.text.trim(),
                              ownerId: FirebaseAuth.instance.currentUser!.uid,
                              category: categorylist,
                            );

                            // Save item to database
                            CollectionCenterController.instance.postItem(item, context);

                            // Navigate to homepage
                            Navigator.pushNamed(context, '/homepage');
                          }
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
