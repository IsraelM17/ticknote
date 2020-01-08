import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'picture',
            child: ClipOval( 
              child: FadeInImage(
                fit: BoxFit.contain,
                placeholder: AssetImage('assets/images/profile.png'),
                image: NetworkImage('https://jovenemprendedora.files.wordpress.com/2012/04/son-goku.jpg')
              ),
            ),
          ),
          Divider(height: 100, color: Colors.orange),
          //Text('Nombre', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: Text('Nombre', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Israel Moreno', style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
          ),
          ListTile(
            title: Text('email', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('email@email.com', style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
          ),
          SizedBox(height: size.height * 0.05,),
          MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Cerrar sesion', style: TextStyle(fontSize: 16, color: Colors.black87)),
                SizedBox(width: 10,),
                Icon(Icons.exit_to_app, size: 20, color: Colors.black87),
              ],
            ),
            onPressed: ()=> signOut(context),
          ),
        ],
      ),
    );
  }

  signOut(BuildContext context) async {
    
    Navigator.of(context).pushReplacementNamed('login');
  }


}