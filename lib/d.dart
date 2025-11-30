import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AngleConverter(),
  ));
}

class AngleConverter extends StatefulWidget {
  const AngleConverter({Key? key}) : super(key: key);

  @override
  State<AngleConverter> createState() => _AngleConverterState();
}

class _AngleConverterState extends State<AngleConverter> {
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
    'Degrees (°)': 1.0,
    'Radians (rad)': 3.141592653589793 / 180.0,
    'Gradians (grad)': 200.0 / 180.0,
  };

  double convertToDegrees(String unit, double value) {
    switch (unit) {
      case 'Degrees (°)':
        return value;
      case 'Radians (rad)':
        return value * (180.0 / 3.141592653589793);
      case 'Gradians (grad)':
        return value * (180.0 / 200.0);
      default:
        return value;
    }
  }

  double convertFromDegrees(String unit, double value) {
    switch (unit) {
      case 'Degrees (°)':
        return value;
      case 'Radians (rad)':
        return value * (3.141592653589793 / 180.0);
      case 'Gradians (grad)':
        return value * (200.0 / 180.0);
      default:
        return value;
    }
  }

  void convert() {
    if (selectedItem1.isNotEmpty &&
        selectedItem2.isNotEmpty &&
        _textController1.text.isNotEmpty) {
      try {
        double inputValue = double.parse(_textController1.text);
        double valueInDegrees = convertToDegrees(selectedItem1, inputValue);
        double result = convertFromDegrees(selectedItem2, valueInDegrees);
        _textController2.text = result.toStringAsFixed(10); // Adjust precision as needed
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
          'Angle Converter',
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
          image: const DecorationImage(
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
                  buildConverterCard(
                    title: 'select and enter digit here',
                    selectedItem: selectedItem1,
                    isExpanded: isExpanded1,
                    toggleExpansion: _toggleExpansion1,
                    buildListTile: _buildListTile1,
                    textController: _textController1,
                    showConvertCard: true,
                  ),
                  const SizedBox(height: 16.0),
                  buildConverterCard(
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
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
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

  Widget buildConverterCard({
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
                buildListTile('Degrees (°)'),
                buildListTile('Radians (rad)'),
                buildListTile('Gradians (grad)'),
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
                  keyboardType: TextInputType.number,
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