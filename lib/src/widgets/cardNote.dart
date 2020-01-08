import 'package:flutter/material.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/firebase/firestoredb.dart';

class CardNote extends StatelessWidget {

  final String email;
  final String title;
  final String description;
  final int color;

  CardNote({ @required this.title, @required this.description, @required this.color, @required this.email });

  @override
  Widget build(BuildContext context) {

    final uiBloc = Provider.ui(context);
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      child: Card(
        elevation: 3.0,
        color: Color(color).withOpacity(0.9),
        child: Container(
          height: size.height * 0.15,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 25 )),
              Container(
                height: size.height * 0.11,
                width: size.width,
                child: Text(description, style: TextStyle(fontSize: 20), textAlign: TextAlign.justify ,overflow: TextOverflow.clip,)
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.visibility, color: Colors.black54,),
                    onPressed: () => print('ver'),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.black54),
                    onPressed: (){
                      // uiBloc.noteChange({
                      //   'title' : title,
                      //   'color' : color,
                      //   'description' : description
                      // });
                      // print(uiBloc.note);
                      // FirestoreDB().deleteNote(email, uiBloc.note);
                      _settingModal(context, size);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _settingModal(BuildContext context, Size size){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          height: size.height * 0.1,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Esta nota sera eliminada'),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      }
    );
  }

}