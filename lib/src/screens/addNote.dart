import 'package:flutter/material.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/bloc/uiBloc.dart';
import 'package:ticknote/src/firebase/firestoredb.dart';
import 'package:ticknote/src/widgets/rectangleOrange.dart';

class AddNote extends StatefulWidget {
  AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with RectangleOrange{

  final _scaffoldKey     = GlobalKey<ScaffoldState>();

  final _titleController = TextEditingController();
  final _descController  = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UiBloc().dispose();
  }

  @override
  Widget build(BuildContext context) {

    final uiBloc  = Provider.ui(context);
    final size    = MediaQuery.of(context).size;

    _titleController.text = uiBloc.title;
    _descController.text  = uiBloc.desc;

    final _formAddNote = Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              cursorColor: Colors.orange,
              autocorrect: true,
              enabled: true,
              decoration: InputDecoration(
                labelText: 'Titulo',
                hintText: 'Titulo'
              ),
            ),
            SizedBox(height: size.height * 0.03,),
            TextField(
              controller: _descController,
              cursorColor: Colors.orange,
              autocorrect: true,
              enabled: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Descripción',
                hintText: 'Descripción',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
            ),
            SizedBox(height: size.height * 0.03,),
            Divider(color: Colors.orange),
            Container(
              width: size.width,
              height: size.height * 0.1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _listColors(context, size, uiBloc),
                ),
              )
            ),
            SizedBox(height: size.height * 0.03,),
          ],
        ),
      ),
    );

    return StreamBuilder<Color>(
      stream: uiBloc.colorStream,
      builder: (BuildContext context, AsyncSnapshot<Color> snapshot){
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: snapshot.data == null ? Colors.white : snapshot.data,
          appBar: AppBar(
            backgroundColor: snapshot.data == null ? Colors.white : snapshot.data,
            elevation: 0.0,
            title: Text('Agregar Nota', style: TextStyle(color: Colors.black54),),
            iconTheme: IconThemeData(color: Colors.black54),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: -(size.height * 0.05),
                  right: -(size.width * 0.05),
                  child: rectangleOrange(context, size),
                ),
                Positioned(
                  bottom: -(size.height * 0.05),
                  right: (size.width * 0.4),
                  child: rectangleRed(context, size),
                ),
                _formAddNote,
                _loading ? Container(
                  height: size.height,
                  width: size.width,
                  child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.orange))),
                ) : Container()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 5.0,
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.check, color: Colors.white, size: 30,),
            onPressed: () => addNote(_titleController.text, _descController.text, uiBloc.color.value),
          ),
        );
      },
    );
  }

  List<Widget> _listColors(BuildContext context, Size size, UiBloc uiBloc){
    
    List<Color> listColors = [Color.fromRGBO(233, 234, 236, 1), Color.fromRGBO(172, 222, 213, 1), 
                              Color.fromRGBO(252, 220, 169, 1), Color.fromRGBO(217, 189, 227, 1), 
                              Color.fromRGBO(184, 191, 198, 1), Color.fromRGBO(179, 228, 199, 1),
                              Color.fromRGBO(248, 193, 186, 1), Color.fromRGBO(183, 219, 243, 1)];
  

    List<Widget> listColorItem = [];

    listColors.forEach((item){
      listColorItem.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: <Widget>[
              CircleAvatar(radius: size.height * 0.03, backgroundColor: Colors.black),
              GestureDetector(
                child: CircleAvatar(
                  radius: size.height * 0.03,
                  backgroundColor: item,
                  //child: Icon(Icons.check),
                ),
                onTap: (){
                  uiBloc.colorChange(item);
                },
              ),
            ],
          ),
        )
      );
    });

    return listColorItem;

  }

  void addNote(String title, String description, int color) async {

    if(_titleController.text != '' && _titleController.text != ''){
      
      _loading = true;
      setState(() {});

      bool noteOk = await FirestoreDB().addNote('se.israel.mc@gmail.com', title, description, color);

      if(noteOk){
        _loading = false;
        setState(() {});
        Navigator.of(context).pop();
      }
      else{
        _loading = false;
        setState(() {});
        showSnackBar();
      }
    }

  }

  void showSnackBar(){
    final snackBar = SnackBar(
      content: Text('Ups! Ha ocurrido un error'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}