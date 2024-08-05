import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CarbonCalculatorPage extends StatefulWidget {
  const CarbonCalculatorPage({super.key});

  @override
  _CarbonCalculatorPageState createState() => _CarbonCalculatorPageState();
}

class _CarbonCalculatorPageState extends State<CarbonCalculatorPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://calculator.carbonfootprint.com/calculator.aspx'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _injectCSS();
          },
        ),
      );
  }

  void _injectCSS() {
    _controller.runJavaScript('''
      var style = document.createElement('style');
      style.type = 'text/css';
      style.innerHTML = 'body { font-size: 40px; } .rtsTxt { font-size: 30px; }';
      document.getElementsByTagName('head')[0].appendChild(style);
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: _injectCSS,
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
  // final _formKey = GlobalKey<FormState>();
  // final _transportationController = TextEditingController();
  // final _electricityController = TextEditingController();
  // final _wasteController = TextEditingController();

  // double _carbonFootprint = 0.0;

  // void _calculateCarbonFootprint() {
  //   final double transportation = double.tryParse(_transportationController.text) ?? 0.0;
  //   final double electricity = double.tryParse(_electricityController.text) ?? 0.0;
  //   final double waste = double.tryParse(_wasteController.text) ?? 0.0;

  //   setState(() {
  //     _carbonFootprint = transportation + electricity + waste;
  //   });
  // }

  // @override
  // void dispose() {
  //   _transportationController.dispose();
  //   _electricityController.dispose();
  //   _wasteController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Form(
  //       key: _formKey,
  //       child: Column(
  //         children: <Widget>[
  //           TextFormField(
  //             controller: _transportationController,
  //             decoration: const InputDecoration(
  //               labelText: 'Transportation (kg CO2)',
  //             ),
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter transportation CO2 emissions';
  //               }
  //               return null;
  //             },
  //           ),
  //           TextFormField(
  //             controller: _electricityController,
  //             decoration: const InputDecoration(
  //               labelText: 'Electricity (kg CO2)',
  //             ),
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter electricity CO2 emissions';
  //               }
  //               return null;
  //             },
  //           ),
  //           TextFormField(
  //             controller: _wasteController,
  //             decoration: const InputDecoration(
  //               labelText: 'Waste (kg CO2)',
  //             ),
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter waste CO2 emissions';
  //               }
  //               return null;
  //             },
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.blue, // Set the background color
  //               foregroundColor: Colors.white, // Set the text color
  //             ),
  //             onPressed: () {
  //               if (_formKey.currentState!.validate()) {
  //                 _calculateCarbonFootprint();
  //               }
  //             },
  //             child: const Text('Calculate'),
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             'Total Carbon Footprint: $_carbonFootprint kg CO2.',
  //             style: const TextStyle(fontSize: 18),
  //           )
  //         ]
  //       )
  //     )
  //   );
  // }
}