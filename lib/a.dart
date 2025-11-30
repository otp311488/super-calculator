import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statistics Calculator',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      
       
      ),
      home: const MyHomeP(),
    );
  }
}

class MyHomeP extends StatefulWidget {
  const MyHomeP({Key? key}) : super(key: key);

  @override
  State<MyHomeP> createState() => _MyHomePState();
}

class _MyHomePState extends State<MyHomeP> {
  TextEditingController dataController = TextEditingController();
  List<double> dataList = [];
  double mean = 0.0;
  double median = 0.0;
  double variance = 0.0;
  double stdDeviation = 0.0;
  List<double> mode = [];
  double range = 0.0;

  void calculateStatistics(String input) {
    dataList.clear();
    List<String> parts = input.split('+').map((e) => e.trim()).toList();

    parts.forEach((part) {
      try {
        double value = double.parse(part);
        dataList.add(value);
      } catch (e) {
        print('Error parsing: $e');
      }
    });

    if (dataList.isNotEmpty) {
      dataList.sort();

      double sum = dataList.reduce((value, element) => value + element);
      mean = sum / dataList.length;

      if (dataList.length % 2 == 0) {
        median = (dataList[dataList.length ~/ 2 - 1] + dataList[dataList.length ~/ 2]) / 2;
      } else {
        median = dataList[dataList.length ~/ 2];
      }

      Map<double, int> frequencyMap = {};
      dataList.forEach((element) {
        frequencyMap.update(element, (value) => value + 1, ifAbsent: () => 1);
      });

      int maxFrequency = frequencyMap.values.fold(0, (previousValue, element) => max(previousValue, element));
      mode = frequencyMap.entries.where((entry) => entry.value == maxFrequency).map((e) => e.key).toList();

      variance = dataList.map((e) => pow(e - mean, 2)).reduce((value, element) => value + element) / dataList.length;
      stdDeviation = sqrt(variance);

      range = dataList.last - dataList.first;

      setState(() {});
    } else {
      print('Data list is empty');
    }
  }

  void clearData() {
    dataController.clear();
    dataList.clear();
    mean = 0.0;
    median = 0.0;
    variance = 0.0;
    stdDeviation = 0.0;
    range = 0.0;
    mode.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics Calculator',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: dataController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Enter Data (e.g., 10+30)',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orangeAccent, Colors.orange],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              calculateStatistics(dataController.text);
                            },
                            child: const Text(
                              'Calculate',
                              style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.redAccent, Colors.red],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: clearData,
                            child: const Text(
                              'Clear',
                              style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildStatisticCard('Mean', mean.toStringAsFixed(2)),
                        _buildStatisticCard('Median', median.toStringAsFixed(2)),
                        _buildStatisticCard('Variance', variance.toStringAsFixed(2)),
                        _buildStatisticCard('Standard Deviation', stdDeviation.toStringAsFixed(2)),
                        _buildStatisticCard('Range', range.toStringAsFixed(2)),
                        _buildStatisticCard('Mode', mode.join(', ')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}