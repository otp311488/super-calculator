import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    home: DateConverter(),
  ));
}

class DateConverter extends StatefulWidget {
  const DateConverter({Key? key}) : super(key: key);

  @override
  State<DateConverter> createState() => _DateConverterState();
}

class _DateConverterState extends State<DateConverter> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;
  String? formattedDate1;
  String? formattedDate2;
  String difference = '';

  @override
  void initState() {
    super.initState();
    selectedDate1 = DateTime.now();
    selectedDate2 = DateTime.now();
    _formatDates();
  }

  void _formatDates() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formattedDate1 = formatter.format(selectedDate1!);
    formattedDate2 = formatter.format(selectedDate2!);
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        _formatDates();
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
        _formatDates();
      });
    }
  }

  void _convertDates() {
    setState(() {
      _calculateDifference();
    });
  }

  void _calculateDifference() {
    Duration diff = selectedDate2!.difference(selectedDate1!);
    int days = diff.inDays;
    int months = (days / 30).floor();
    int years = (days / 365).floor();
    double centuries = years / 100;

    difference = 'Difference:\n'
        'Days: $days\n'
        'Months: $months\n'
        'Years: $years\n'
        'Centuries: ${centuries.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Date Converter',
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
                  buildDateConverterCard(
                    title: 'Date 1',
                    selectedDate: formattedDate1,
                    onTap: () => _selectDate1(context),
                  ),
                  const SizedBox(height: 16.0),
                  buildDateConverterCard(
                    title: 'Date 2',
                    selectedDate: formattedDate2,
                    onTap: () => _selectDate2(context),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _convertDates,
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
                  const SizedBox(height: 16.0),
                  buildResultCard(difference),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateConverterCard({
    required String title,
    required String? selectedDate,
    required VoidCallback onTap,
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
            leading: const Icon(Icons.calendar_today),
            onTap: onTap,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedDate == null ? 'No date selected' : 'Selected Date: $selectedDate',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResultCard(String result) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Result',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              result,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}