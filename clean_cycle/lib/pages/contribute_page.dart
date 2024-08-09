import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContributePage extends StatefulWidget {
  const ContributePage({super.key});

  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  bool recycleSelected = false;
  bool reuseSelected = false;
  File? _image;

  final ImagePicker _picker = ImagePicker();

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
        scaffoldBackgroundColor: Color.fromARGB(255, 78, 77, 77),
      ),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row with Backward Arrow and Title
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText:
                        'Enter item name (e.g: bottles, plastic, cans, TV)',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description (optional)',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter item description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tags',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                CheckboxListTile(
                  title: const Text('Recycle'),
                  value: recycleSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      recycleSelected = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Re-Use'),
                  value: reuseSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      reuseSelected = value ?? false;
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
                          icon: Icon(Icons.camera_alt),
                          label: Text(
                            'Take Photo',
                            style:
                                TextStyle(fontSize: 20), // Increase font size
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
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
                          icon: Icon(Icons.photo_library),
                          label: Text(
                            'Select photo',
                            style:
                                TextStyle(fontSize: 20), // Increase font size
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
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
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
