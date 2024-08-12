import 'package:clean_cycle/pages/gemini_pages/carbon_calculator.dart';
import 'package:flutter/material.dart';

class CarbonTrackerPage extends StatefulWidget {
  const CarbonTrackerPage({super.key});
  
  @override
  CarbonTrackerPageState createState() => CarbonTrackerPageState();
}

class CarbonTrackerPageState extends State<CarbonTrackerPage> {

  void _openCalculatorSurvey() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CarbonCalculatorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Tracker'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Calculate your Carbon Footprint',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 75,  // Set the width here
                      height: 75,  // Set the height here
                      child: Image.asset("assets/logo1.png")
                    ),
                    const Text("Travel")
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 75,  // Set the width here
                      height: 75,  // Set the height here
                      child: Image.asset("assets/logo1.png")
                    ),
                    const Text("Food")
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 75,  // Set the width here
                      height: 75,  // Set the height here
                      child: Image.asset("assets/logo1.png")
                    ),
                    const Text("Electricity")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set the background color
                foregroundColor: Colors.white, // Set the text color
              ),
              onPressed: () {
                _openCalculatorSurvey();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const CarbonCalculatorPage()));
              },
              child: const Text('Calculate Your Footprint'),
            ),
          ],
        ),
      ),
    );
  }
}
