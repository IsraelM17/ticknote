import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: Colors.white.withOpacity(0.9),
            child: ListTile(
              leading: Icon(Icons.credit_card, size: 30),
              title: Text('Tarjetas'),
              subtitle: Text('Credito / Debito'),
              trailing: Icon(Icons.navigate_next),
              onTap: () => Navigator.of(context).pushNamed('addCard')
            ),
          ),
          Card(
            elevation: 3.0,
            color: Colors.white.withOpacity(0.9),
            child: 
              ListTile(
                leading: Icon(Icons.pan_tool, size: 30),
                title: Text('Algo mas privado'),
                subtitle: Text('Algo para tu ex?'),
                trailing: Icon(Icons.navigate_next),
                onTap: () => print('trabajo'),
              ),
          ),
          Card(
            elevation: 3.0,
            color: Colors.white.withOpacity(0.9),
            child: ListTile(
              leading: Icon(Icons.work, size: 30),
              title: Text('Escuela / Trabajo'),
              subtitle: Text('Recuerda tus pendientes'),
              trailing: Icon(Icons.navigate_next),
              onTap: () => print('trabajo'),
            ),
          ),
          Card(
            elevation: 3.0,
            color: Colors.white.withOpacity(0.9),
            child: ListTile(
              leading: Icon(Icons.wifi_tethering, size: 30),
              title: Text('Ya se me ocurrira algo'),
              subtitle: Text('Algo X'),
              trailing: Icon(Icons.navigate_next),
              onTap: () => print('trabajo'),
            ),
          ),
        ],
      ),
    );
  }
}