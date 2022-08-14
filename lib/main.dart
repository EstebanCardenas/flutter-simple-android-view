import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const MaterialApp(
      home: BatteryLevel(),
    ),
  );
}

class BatteryLevel extends StatefulWidget {
  const BatteryLevel({Key? key}) : super(key: key);

  @override
  State<BatteryLevel> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {
  static const platform = MethodChannel('battery');
  int? batteryLevel;

  Future<void> getBatteryLevel() async {
    try {
      batteryLevel = await platform.invokeMethod<int>('getBatteryLevel');
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get battery level: $e'),
        ),
      );
    }
  }

  void goToBasicActivity() => platform.invokeMethod('goToBasicActivity');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Level'),
      ),
      body: Center(
        child: Text(
          batteryLevel != null
              ? 'Current battery level: $batteryLevel%'
              : 'Press the button to get the current battery level',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getBatteryLevel,
        child: const Icon(
          Icons.battery_charging_full_sharp,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: goToBasicActivity,
          child: const Text('GO TO BASIC ACTIVITY'),
        ),
      ),
    );
  }
}
