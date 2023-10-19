import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryStatusPage extends StatefulWidget {
  const BatteryStatusPage({super.key});

  @override
  State<BatteryStatusPage> createState() => _BatteryStatusPageState();
}

class _BatteryStatusPageState extends State<BatteryStatusPage> {
  var battery = Battery();
  var nivelBateria = "";
  var statusBateria = "";

  @override
  void initState() {
    super.initState();
    initPage();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      // Handle battery state changes
      statusBateria = state.toString();

      setState(() {});
    });
  }

  initPage() async {
    nivelBateria = (await battery.batteryLevel).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status da Bateria: $nivelBateria% $statusBateria'),
      ),
      body: const Column(),
    );
  }
}
