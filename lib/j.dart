import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: mass(),
  ));
}

class mass extends StatefulWidget {
  const mass({Key? key}) : super(key: key);

  @override
  State<mass> createState() => _massState();
}

class _massState extends State<mass> {
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
    'Carats': 5000.0,
    'Milligrams': 1000.0,
    'Centigrams': 100.0,
    'Decigram': 10.0,
    'Gram': 1.0,
    'Dekagram': 0.1,
    'Hectogram': 0.01,
    'Kilogram': 0.001,
    'Metric Tonnes': 0.000001,
    'Ounces': 0.035274,
    'Pounds': 0.00220462,
    'Stones': 0.000157473,
    'Short Tons (US)': 0.00000110231,
    'Long Tons (UK)': 0.000000984207,
  };

  void convert() {
    if (selectedItem1.isNotEmpty &&
        selectedItem2.isNotEmpty &&
        _textController1.text.isNotEmpty) {
      try {
        double inputValue = double.parse(_textController1.text);
        double baseValue = inputValue / conversionFactors[selectedItem1]!;
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
          'Mass Converter',
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
                  buildMassConverterCard(
                    title: 'select and enter digit here',
                    selectedItem: selectedItem1,
                    isExpanded: isExpanded1,
                    toggleExpansion: _toggleExpansion1,
                    buildListTile: _buildListTile1,
                    textController: _textController1,
                    showConvertCard: true,
                  ),
                  const SizedBox(height: 16.0),
                  buildMassConverterCard(
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
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return 12; 
                        }
                        return 8; 
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.lightBlueAccent; 
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

  Widget buildMassConverterCard({
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
                buildListTile('Carats'),
                buildListTile('Milligrams'),
                buildListTile('Centigrams'),
                buildListTile('Decigram'),
                buildListTile('Gram'),
                buildListTile('Dekagram'),
                buildListTile('Hectogram'),
                buildListTile('Kilogram'),
                buildListTile('Metric Tonnes'),
                buildListTile('Ounces'),
                buildListTile('Pounds'),
                buildListTile('Stones'),
                buildListTile('Short Tons (US)'),
                buildListTile('Long Tons (UK)'),
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