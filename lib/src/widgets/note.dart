import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticknote/src/model/User.dart';
import 'package:ticknote/src/preferences/userPreferences.dart';
import 'package:ticknote/src/widgets/cardNote.dart';

class Note extends StatelessWidget {
  
  final _preferences = UserPreferences();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final user = User.fromJson(jsonDecode(_preferences.profile));

    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('users').document(user.email).snapshots(),
      builder: ( BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot ){
        
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container(
              height: size.height,
              width: size.width,
              child: Center(
                child: Text('No hay conexión a internet')
              )
            );
            break;
          case ConnectionState.waiting:
            return Container(
              height: size.height,
              width: size.width,
              child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.orange)))
            );
            break;
          case ConnectionState.active:
            // ? Hay que investigar para que es el active.
            return Container(
              height: size.height,
              width: size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data['notes'].length,
                itemBuilder: (BuildContext context, int index){
                  return CardNote(
                    email: user.email,
                    title: snapshot.data['notes'][index]['title'],
                    description: snapshot.data['notes'][index]['description'],
                    color: snapshot.data['notes'][index]['color'],
                  );
                }
              ),
            );
            break;
          case ConnectionState.done:
            return Container(
              height: size.height,
              width: size.width,
              child: ListView.builder(
              itemCount: snapshot.data['notes'].length,
                itemBuilder: (BuildContext context, int index){
                  return CardNote(
                    email: user.email,
                    title: snapshot.data['notes'][index]['title'],
                    description: snapshot.data['notes'][index]['description'],
                    color: snapshot.data['notes'][index]['color'],
                  );
                },
              ),
            );
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}