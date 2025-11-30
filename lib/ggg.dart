import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: dataConverter(),
  ));
}

class dataConverter extends StatefulWidget {
  const dataConverter({Key? key}) : super(key: key);

  @override
  State<dataConverter> createState() => _dataConverterState();
}

class _dataConverterState extends State<dataConverter> {
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
    'Bit (b)': 1.0,
    'Byte (B)': 0.125,
    'Kilobit (Kb)': 0.001,
    'Kilobyte (KB)': 0.000125,
    'Megabit (Mb)': 1e-6,
    'Megabyte (MB)': 1.25e-7,
    'Gigabit (Gb)': 1e-9,
    'Gigabyte (GB)': 1.25e-10,
    'Terabit (Tb)': 1e-12,
    'Terabyte (TB)': 1.25e-13,
    'Petabit (Pb)': 1e-15,
    'Petabyte (PB)': 1.25e-16,
    'Exabit (Eb)': 1e-18,
    'Exabyte (EB)': 1.25e-19,
    'Zettabit (Zb)': 1e-21,
    'Zettabyte (ZB)': 1.25e-22,
    'Yottabit (Yb)': 1e-24,
    'Yottabyte (YB)': 1.25e-25,
  };

  void convert() {
    if (selectedItem1.isNotEmpty &&
        selectedItem2.isNotEmpty &&
        _textController1.text.isNotEmpty) {
      try {
        double inputValue = double.parse(_textController1.text);
        double baseValue = inputValue / conversionFactors[selectedItem1]!;
        double result = baseValue * conversionFactors[selectedItem2]!;
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
          'Data Converter',
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
                  buildPowerConverterCard(
                    title: 'select and enter digit here',
                    selectedItem: selectedItem1,
                    isExpanded: isExpanded1,
                    toggleExpansion: _toggleExpansion1,
                    buildListTile: _buildListTile1,
                    textController: _textController1,
                    showConvertCard: true,
                  ),
                  const SizedBox(height: 16.0),
                  buildPowerConverterCard(
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

  Widget buildPowerConverterCard({
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
                buildListTile('Bit (b)'),
                buildListTile('Byte (B)'),
                buildListTile('Kilobit (Kb)'),
                buildListTile('Kilobyte (KB)'),
                buildListTile('Megabit (Mb)'),
                buildListTile('Megabyte (MB)'),
                buildListTile('Gigabit (Gb)'),
                buildListTile('Gigabyte (GB)'),
                buildListTile('Terabit (Tb)'),
                buildListTile('Terabyte (TB)'),
                buildListTile('Petabit (Pb)'),
                buildListTile('Petabyte (PB)'),
                buildListTile('Exabit (Eb)'),
                buildListTile('Exabyte (EB)'),
                buildListTile('Zettabit (Zb)'),
                buildListTile('Zettabyte (ZB)'),
                buildListTile('Yottabit (Yb)'),
                buildListTile('Yottabyte (YB)'),
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