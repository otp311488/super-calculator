import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectedItem1 = '';
  String selectedItem2 = '';
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  void _toggleExpansion1() {
    setState(() {
      isExpanded1 = !isExpanded1;
    });
  }

  void _toggleExpansion2() {
    setState(() {
      isExpanded2 = !isExpanded2;
    });
  }

  Map<String, double> conversionFactors = {
    'Milliliters': 1.0,
    'Cubic Centimeters': 1.0,
    'Liters': 0.001,
    'Cubic Meters': 0.000001,
    'Teaspoon (US)': 4.92892,
    'Tablespoon (US)': 14.7868,
    'Cups (US)': 236.588,
    'Pints (US)': 473.176,
    'Quarts (US)': 946.353,
    'Gallons (US)': 3785.41,
    'Cubic Inches': 16.3871,
    'Cubic Feet': 28316.8,
    'Cubic Yards': 764554.0,
    'Teaspoon (UK)': 5.91939,
    'Tablespoon (UK)': 17.7582,
    'Fluid Ounce (UK)': 28.4131,
    'Pints (UK)': 568.261,
    'Quarts (UK)': 1136.52,
    'Gallons (UK)': 4546.09,
  };

  void convert() {
    if (selectedItem1.isNotEmpty &&
        selectedItem2.isNotEmpty &&
        _textController1.text.isNotEmpty) {
      try {
        double inputValue = double.parse(_textController1.text);
        double baseValue =
            inputValue / conversionFactors[selectedItem1]!;
        double result = baseValue * conversionFactors[selectedItem2]!;
        _textController2.text = result.toStringAsFixed(4);
      } catch (e) {
        print('Error converting: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volume Converter',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pencils-926078.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildVolumeConverterCard(
                    title: 'select and enter digit here',
                    selectedItem: selectedItem1,
                    isExpanded: isExpanded1,
                    toggleExpansion: _toggleExpansion1,
                    buildListTile: _buildListTile1,
                    textController: _textController1,
                    showConvertCard: true,
                  ),
                  const SizedBox(height: 16.0),
                  buildVolumeConverterCard(
                    title: 'select unit donot enter digits here',
                    selectedItem: selectedItem2,
                    isExpanded: isExpanded2,
                    toggleExpansion: _toggleExpansion2,
                    buildListTile: _buildListTile2,
                    textController: _textController2,
                    showConvertCard: false,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      convert();
                      // Implement scale transition effect here if needed
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return 12; // Elevation when pressed
                        }
                        return 8; // Default elevation
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.lightBlueAccent; // Gradient color when pressed
                        }
                        return Colors.blue; // Default color
                      }),
                      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.4)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('Convert'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVolumeConverterCard({
    required String title,
    required String selectedItem,
    required bool isExpanded,
    required VoidCallback toggleExpansion,
    required Widget Function(String) buildListTile,
    required TextEditingController textController,
    required bool showConvertCard,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(title),
            leading: const Icon(Icons.arrow_drop_down),
            onTap: toggleExpansion,
          ),
          if (isExpanded)
            Column(
              children: [
                buildListTile('Milliliters'),
                buildListTile('Cubic Centimeters'),
                buildListTile('Liters'),
                buildListTile('Cubic Meters'),
                buildListTile('Teaspoon (US)'),
                buildListTile('Tablespoon (US)'),
                buildListTile('Cups (US)'),
                buildListTile('Pints (US)'),
                buildListTile('Quarts (US)'),
                buildListTile('Gallons (US)'),
                buildListTile('Cubic Inches'),
                buildListTile('Cubic Feet'),
                buildListTile('Cubic Yards'),
                buildListTile('Teaspoon (UK)'),
                buildListTile('Tablespoon (UK)'),
                buildListTile('Fluid Ounce (UK)'),
                buildListTile('Pints (UK)'),
                buildListTile('Quarts (UK)'),
                buildListTile('Gallons (UK)'),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedItem.isEmpty ? 'No item selected' : 'Selected Item: $selectedItem',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: textController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile1(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: () {
        setState(() {
          selectedItem1 = title;
          _textController1.clear();
          isExpanded1 = false;
        });
      },
    );
  }

  Widget _buildListTile2(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: () {
        setState(() {
          selectedItem2 = title;
          _textController2.clear();
          isExpanded2 = false;
        });
      },
    );
  }
}
