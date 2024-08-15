import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScannerView extends StatefulWidget {
  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  List<String> scannedBarcodes = [];
  FocusNode _focusNode = FocusNode();
  String currentScan = ''; // Almacena el código actual en construcción

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // Solicitar enfoque inmediatamente al iniciar
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de Códigos de Barras'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KeyboardListener para capturar eventos del teclado
          Expanded(
            child: KeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: (event) {
                if (event is KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.enter) {
                    setState(() {
                      // Agregar el código actual a la lista y reiniciar currentScan
                      if (currentScan.isNotEmpty) {
                        scannedBarcodes.add(currentScan.trim());
                        currentScan = ''; // Reiniciar para el próximo código
                      }
                    });
                  } else {
                    // Añadir caracteres al código actual
                    String? character = event.character;
                    if (character != null) {
                      setState(() {
                        currentScan += character;
                      });
                    }
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: scannedBarcodes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        scannedBarcodes[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class BarcodeScannerView extends StatefulWidget {
//   const BarcodeScannerView({super.key});

//   @override
//   _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
// }

// class _BarcodeScannerViewState extends State<BarcodeScannerView> {
//   List<String> scannedBarcodes = [];
//   final FocusNode _focusNode = FocusNode();
//   String currentScan = ''; // Almacena el código actual en construcción

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.requestFocus(); // Solicitar enfoque inmediatamente al iniciar
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Códigos  cubetas'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // KeyboardListener para capturar eventos del teclado
//           KeyboardListener(
//             focusNode: _focusNode,
//             autofocus: true,
//             onKeyEvent: (event) {
//               if (event is KeyDownEvent) {
//                 if (event.logicalKey == LogicalKeyboardKey.enter) {
//                   setState(() {
//                     // Agregar el código actual a la lista y reiniciar currentScan
//                     if (currentScan.isNotEmpty) {//Tambien asegura que no se agreguen códigos vacíos a la lista. 
//                       scannedBarcodes.add(currentScan.trim());
//                       currentScan = ''; // Reiniciar para el próximo código
//                     }
//                   });
//                 } else {
//                   // Añadir caracteres al código actual
//                   String? character = event.character;
//                   if (character != null) {
//                     setState(() {
//                       currentScan += character;
//                     });
//                   }
//                 }
//               }
//             },
//             child: const SizedBox.shrink(), // Este widget actúa como contenedor del listener
//           ),
//           // Muestra los códigos de barras escaneados
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView.builder(
//                 itemCount: scannedBarcodes.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Text(
//                       scannedBarcodes[index],
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


