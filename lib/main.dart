import 'package:Math_helper_app/a.dart';
import 'package:Math_helper_app/b.dart';
import 'package:Math_helper_app/c.dart';
import 'package:Math_helper_app/d.dart';
import 'package:Math_helper_app/e.dart';
import 'package:Math_helper_app/f.dart';
import 'package:Math_helper_app/g.dart';
import 'package:Math_helper_app/ggg.dart';
import 'package:Math_helper_app/j.dart';
import 'package:Math_helper_app/jjj.dart';
import 'package:Math_helper_app/k.dart';
import 'package:Math_helper_app/m.dart';
import 'package:Math_helper_app/n.dart';
import 'package:Math_helper_app/p.dart';
import 'package:Math_helper_app/vol.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToPage(Widget destinationPage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Professional Calculator',
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
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _AnimatedButton(
                  text: 'Scientific Calculator',
                  destinationPage: MyHomePage(),
                  icon: Icons.calculate,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Statistics Calculator',
                  destinationPage: MyHomeP(),
                  icon: Icons.bar_chart,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Volume',
                  destinationPage: MyWidget(),
                  icon: Icons.inbox,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Length',
                  destinationPage: length(),
                  icon: Icons.linear_scale,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Mass & Weight',
                  destinationPage: mass(),
                  icon: Icons.scale,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Temperature',
                  destinationPage: TemperatureConverter(),
                  icon: Icons.thermostat,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Energy',
                  destinationPage: EnergyConverter(),
                  icon: Icons.power,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Area',
                  destinationPage: area(),
                  icon: Icons.grid_on,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Time',
                  destinationPage: TimeConverter(),
                  icon: Icons.timer,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Speed',
                  destinationPage: speedConverter(),
                  icon: Icons.speed,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Power',
                  destinationPage: powerConverter(),
                  icon: Icons.bolt,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Data',
                  destinationPage: dataConverter(),
                  icon: Icons.data_usage,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Pressure',
                  destinationPage: pressureConverter(),
                  icon: Icons.compress,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Angle',
                  destinationPage: AngleConverter(),
                  icon: Icons.circle,
                  navigateToPage: _navigateToPage,
                ),
                _AnimatedButton(
                  text: 'Date Calculator',
                  destinationPage: DateConverter(),
                  icon: Icons.calendar_today,
                  navigateToPage: _navigateToPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final String text;
  final Widget destinationPage;
  final IconData icon;
  final Function(Widget) navigateToPage;

  const _AnimatedButton({
    Key? key,
    required this.text,
    required this.destinationPage,
    required this.icon,
    required this.navigateToPage,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onTap() {
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        widget.navigateToPage(widget.destinationPage);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 25),
              const SizedBox(height: 8),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}