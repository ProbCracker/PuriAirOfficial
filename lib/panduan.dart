import 'package:flutter/material.dart';

class Panduan extends StatelessWidget {
  const Panduan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Sensor'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Gambar latar belakang
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gradient.png'), // Gambar gradien
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              SensorInfoPage(
                title: 'Temperature',
                goodRange: '20-24°C',
                lessGoodRange: '16-28°C',
                badRange: 'Di luar 16-28°C',
                icon: Icons.thermostat,
              ),
              SensorInfoPage(
                title: 'Humidity',
                goodRange: '30-50%',
                lessGoodRange: '20-60%',
                badRange: 'Di luar 20-60%',
                icon: Icons.water_drop,
              ),
              SensorInfoPage(
                title: 'Pressure',
                goodRange: '101.3 kPa',
                lessGoodRange: '100.0-102.0 kPa',
                badRange: 'Di luar 100-102 kPa',
                icon: Icons.compress,
              ),
              SensorInfoPage(
                title: 'CO2',
                goodRange: '< 800 ppm',
                lessGoodRange: '800-1000 ppm',
                badRange: '> 1000 ppm',
                icon: Icons.air,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SensorInfoPage extends StatelessWidget {
  final String title;
  final String goodRange;
  final String lessGoodRange;
  final String badRange;
  final IconData icon;

  const SensorInfoPage({
    Key? key,
    required this.title,
    required this.goodRange,
    required this.lessGoodRange,
    required this.badRange,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 40, color: Colors.teal),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Rentang Baik:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(goodRange, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              'Rentang Kurang Baik:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(lessGoodRange, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              'Rentang Tidak Baik:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(badRange, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Panduan(),
  ));
}
