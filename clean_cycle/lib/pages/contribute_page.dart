import 'package:flutter/material.dart';

class ContributePage extends StatefulWidget {
  const ContributePage({super.key});

  @override
  _ContributePageState createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  bool recycleSelected = false;
  bool reuseSelected = false;

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
                const Text(
                  'Create New Requests',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                    hintText: 'Enter item name',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
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
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tags',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
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
                const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: const Center(
                    child: Text(
                      'Image Picker Placeholder',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
