import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'panduan.dart'; // Import halaman Panduan
import 'info.dart';
import 'chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Sensor Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _temperature = "Loading...";
  String _humidity = "Loading...";
  String _pressure = "Loading...";
  String _co2 = "Loading...";
  final String _esp32Url = "http://192.168.4.1/"; // Ganti dengan endpoint ESP32 Anda

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchSensorData();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      fetchSensorData();
    });
  }

  Future<void> fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(_esp32Url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _temperature = '${data['temperature']} °C';
          _humidity = '${data['humidity']} %';
          _pressure = '${(data['pressure'] * 0.1).toStringAsFixed(1)} kPa'; // Ubah hPa ke kPa
          _co2 = '${data['co2']} ppm';
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          _temperature = "No data";
          _humidity = "No data";
          _pressure = "No data";
          _co2 = "No data";
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _temperature = "No data";
        _humidity = "No data";
        _pressure = "No data";
        _co2 = "No data";
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color getStatusColor(String label, double value) {
    switch (label) {
      case 'Temperature':
        if (value >= 20 && value <= 24) return Colors.green;
        if (value >= 16 && value < 20 || value > 24 && value <= 28) return Colors.orange;
        return Colors.red;
      case 'Humidity':
        if (value >= 30 && value <= 50) return Colors.green;
        if (value >= 20 && value < 30 || value > 50 && value <= 60) return Colors.orange;
        return Colors.red;
      case 'Pressure':
        if (value == 101.3) return Colors.green;
        if (value >= 100.0 && value < 101.3 || value > 101.3 && value <= 102.0) return Colors.orange;
        return Colors.red;
      case 'CO2':
        if (value < 800) return Colors.green;
        if (value >= 800 && value <= 1000) return Colors.orange;
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/gradient.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 56.0,
            left: 16.0,
            child: Text(
              'Welcome To',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            left: -175,
            right: 16.0,
            child: Image.asset(
              'assets/puriair.png',
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            top: 20.0,
            right: 16.0,
            child: Image.asset(
              'assets/logo.png',
              width: 125,
              height: 125,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.0),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: <Widget>[
                    buildGaugeWidget('Temperature', _temperature),
                    buildGaugeWidget('Humidity', _humidity),
                    buildGaugeWidget('Pressure', _pressure),
                    buildGaugeWidget('CO2', _co2),
                  ],
                ),
                SizedBox(height: 20),
                buildLegendWidget()
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/bottom_image.png',
              fit: BoxFit.contain,
              height: 150,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 26.0,
            left: 30, // Adjusted to fit screen properly
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Panduan()),
                );
              },
              child: Image.asset(
                'assets/thermostat.png',
                fit: BoxFit.contain,
                height: 65,
              ),
            ),
          ),
          Positioned(
            bottom: 26.0,
            right: 30, // Adjusted to fit screen properly
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Info()),
                );
              },
              child: Image.asset(
                'assets/info.png',
                fit: BoxFit.contain,
                height: 65,
              ),
            ),
          ),
          Positioned(
            bottom: 65.0,
            left: 163, // Adjusted to fit screen properly
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chat()),
                );
              },
              child: Image.asset(
                'assets/chat.png',
                fit: BoxFit.contain,
                height: 65,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGaugeWidget(String label, String value) {
    double? parsedValue = double.tryParse(value.split(' ')[0]);
    Color statusColor = parsedValue != null ? getStatusColor(label, parsedValue) : Colors.black;

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: statusColor)),
            SizedBox(height: 10),
            CircularProgressIndicator(
              value: parsedValue != null ? parsedValue / 100 : null,
              strokeWidth: 8.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
            SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor)),
          ],
        ),
      ),
    );
  }

  Widget buildLegendWidget() {
    return Column(
      children: <Widget>[
        buildLegendItem(Colors.green, 'Baik'),
        buildLegendItem(Colors.orange, 'Kurang Baik'),
        buildLegendItem(Colors.red, 'Tidak Baik'),
      ],
    );
  }

  Widget buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            color: color,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
