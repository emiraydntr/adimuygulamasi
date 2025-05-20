import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HEALTH',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EASağlık'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int steps = 2578;
  int calories = 198;
  int exercise = 5;
  int activity = 3;

  void _resetMetrics() {
    setState(() {
      steps = 0;
      calories = 0;
      exercise = 0;
      activity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.red),
            onPressed: _resetMetrics,
            tooltip: 'Adım ve Kalori Sayaçlarını Sıfırla',
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person_outline, color: Colors.black54),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDailyActivityCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildHealthCard(
                  'Kalp Atış Hızı',
                  'Veri yok',
                  Icons.favorite,
                  Colors.red,
                )),
                const SizedBox(width: 16),
                Expanded(child: _buildHealthCard(
                  'Uyku',
                  'Veri yok',
                  Icons.nightlight_round,
                  Colors.indigo,
                )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildHealthCard(
                  'Sıhhat',
                  'Veri yok',
                  Icons.health_and_safety,
                  Colors.green,
                )),
                const SizedBox(width: 16),
                Expanded(child: _buildHealthCard(
                  'SpO2',
                  'Veri yok',
                  Icons.air,
                  Colors.blue,
                )),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Sağlık'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: 'Egzersiz'),
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: 'Cihaz'),
        ],
      ),
    );
  }

  Widget _buildDailyActivityCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue[400]!, Colors.blue[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.directions_walk, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Text(
                      'Günlük Aktivite',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: _resetMetrics,
                  tooltip: 'Sıfırla',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActivityMetric('Adım', steps.toString(), '10000'),
                _buildActivityMetric('Kalori', calories.toString(), '2000'),
                _buildActivityMetric('Egzersiz', exercise.toString(), '30'),
                _buildActivityMetric('Aktivite', activity.toString(), '12'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityMetric(String label, String value, String target) {
   
    double progress = 0.0;
    try {
      final currentValue = double.parse(value);
      final targetValue = double.parse(target.split(' ')[0]);
      progress = (currentValue / targetValue).clamp(0.0, 1.0);
    } catch (e) {
      progress = 0.0;
    }

    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 8,
                ),
              ),
              Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Text(
          target,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: value == 'Veri yok' ? 0.0 : 0.7, 
                      backgroundColor: color.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      strokeWidth: 8,
                    ),
                  ),
                  Center(
                    child: Icon(icon, color: color, size: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
