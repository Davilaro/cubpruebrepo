import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothScanner extends StatefulWidget {
  @override
  _BluetoothScannerState createState() => _BluetoothScannerState();
}

class _BluetoothScannerState extends State<BluetoothScanner> {
   final FlutterBluePlus _flutterBlue = FlutterBluePlus();
  // BluetoothDevice? connectedDevice;
  // List<BluetoothService> services = [];
  // List<ScanResult> scanResults = [];
   String _scannedBarcode = '';

  StreamSubscription<bool>? _scanningSubscription;
  bool _isScanning = false;
  String scannedData = ''; // Variable para almacenar los datos escaneados

  @override
  void initState() {
    super.initState();
    checkPermissions(); // Verificar y solicitar permisos

    //Escuchar los cambios en el estado de escaneo
    _scanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
      setState(() {
        _isScanning = isScanning;
      });
    });
  }

  @override
  void dispose() {
    _scanningSubscription?.cancel();
    super.dispose();
  }

  // Solicitar permisos en tiempo de ejecución
  Future<void> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetooth]!.isGranted &&
        statuses[Permission.location]!.isGranted) {
      // scanForDevices();
    } else {
      // Muestra un mensaje si los permisos no están otorgados
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permisos requeridos'),
          content: Text(
              'Por favor, otorga permisos de Bluetooth y ubicación para continuar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Escucha los resultados del escaneo
  // void listenForScanResults() {
  //   FlutterBluePlus.scanResults.listen((results) {
  //     for (ScanResult result in results) {
  //       // print(
  //       //     'Dispositivo encontrado: ${result.device.platformName} - ${result.device.remoteId}');
  //     }
  //   });
  // }

  // Conecta al dispositivo seleccionado
  // void connectToDevice(BluetoothDevice device) async {
  //   try {
  //     await device.connect();
  //     setState(() {
  //       connectedDevice = device;
  //     });

  //     services = await device.discoverServices();
  //     setState(() {});
  //   } catch (e) {
  //     print('Error al conectar: $e');
  //   }
  // }

  // Desconecta el dispositivo
  // void disconnectDevice() async {
  //   await connectedDevice?.disconnect();
  //   setState(() {
  //     connectedDevice = null;
  //     services = [];
  //   });
  // }

  // Lee los datos del escáner
  // void readFromScanner(BluetoothCharacteristic characteristic) {
  //   characteristic.value.listen((value) {
  //     // Procesar los datos recibidos
  //     String scannedData = String.fromCharCodes(value);
  //     //  print('Datos escaneados: $scannedData');
  //   });
  // }

  // Función para manejar la entrada del teclado
  // void _handleKey(RawKeyEvent event) {
  //   if (event is RawKeyDownEvent) {
  //     if (event.logicalKey == LogicalKeyboardKey.enter) {
  //       print('escaneo acaca******');
  //       // Muestra los datos cuando se presiona la tecla Enter
  //       setState(() {
  //         //  print('Código de barras escaneado: $scannedData');
  //         scannedData = ''; 
  //         print('escaneo acaca******');// Limpia la variable después de mostrar los datos
  //       });
  //     } else {
  //       // Acumula los caracteres en scannedData
  //       setState(() {
  //         scannedData += event.character ?? '';
  //         print('escaneo acaca******');
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner Bluetooth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Muestra los datos escaneados en la interfaz
          Text(
            'Código de barrassssssss: $_scannedBarcode',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: (KeyEvent event) {
              if (event is KeyDownEvent) {
                setState(() {
                  _scannedBarcode += event.character ?? '';
                     print('************${event.character}'); // Concatenar si no es nulo
                });
              }
            }, // Maneja el evento del teclado
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
