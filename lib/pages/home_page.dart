import 'package:flutter/material.dart';


class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key,});

  
  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'CUBETAS TRANSPORTADOR',
      style: optionStyle,
    ),
    Text(
      'CUBETAS AUXILIAR DE BODEGA',
      style: optionStyle,
    ),
    Text(
      'CUBETAS AUXILIAR DE DEVOLUCIONES',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GESTION INVENTARIO CUBETAS'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        
        child: ListView(
         
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('USUARIOS'),
            ),
            ListTile(
              title: const Text('TRANSPORTADOR '),
              selected: _selectedIndex == 0,
              onTap: () {
                
                _onItemTapped(0);
                
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('AUXILIAR DE BODEGA'),
              selected: _selectedIndex == 1,
              onTap: () {
                
                _onItemTapped(1);
                
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('AUXILIAR DE DEVOLUCIONES'),
              selected: _selectedIndex == 2,
              onTap: () {
               
                _onItemTapped(2);
                
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
