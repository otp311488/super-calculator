import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: EnergyConverter(),
  ));
}

class EnergyConverter extends StatefulWidget {
  const EnergyConverter({Key? key}) : super(key: key);

  @override
  State<EnergyConverter> createState() => _EnergyConverterState();
}

class _EnergyConverterState extends State<EnergyConverter> {
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

  Map<String, double> conversionFactors = {
    'Electron Volts': 6.242e+18,
    'Joules': 1.0,
    'Kilojoules': 0.001,
    'Thermal Calories': 0.239,
    'Food Calories': 0.000239,
    'Foot Pounds': 0.737562,
    'British Thermal Unit': 0.000947817,
    'Kilowatt Hour': 0.000277778,
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
      _textController2.text = 'Error';
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Energy Converter',
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
                  buildEnergyConverterCard(
                    title: 'select and enter digit here',
                    selectedItem: selectedItem1,
                    isExpanded: isExpanded1,
                    toggleExpansion: _toggleExpansion1,
                    buildListTile: _buildListTile1,
                    textController: _textController1,
                    showConvertCard: true,
                  ),
                  const SizedBox(height: 16.0),
                  buildEnergyConverterCard(
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
                      elevation: 8,backgroundColor: Colors.blue,foregroundColor: Colors.white,
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

  Widget buildEnergyConverterCard({
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
                buildListTile('Electron Volts'),
                buildListTile('Joules'),
                buildListTile('Kilojoules'),
                buildListTile('Thermal Calories'),
                buildListTile('Food Calories'),
                buildListTile('Foot Pounds'),
                buildListTile('British Thermal Unit'),
                buildListTile('Kilowatt Hour'),
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
}