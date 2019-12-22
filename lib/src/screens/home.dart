import 'package:flutter/material.dart';
import 'package:ticknote/src/screens/rectangleOrange.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RectangleOrange, SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final _appBar = Container(
      height: size.height * 0.12,
      width: size.width,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('TickNote', style: TextStyle(color: Colors.white),),
      ),
    );

    final _photoProfile = Positioned(
      right: size.width * 0.03,
      top:  size.height * 0.05,
      child: Container(
        height: size.height * 0.075,
        width: size.width * 0.2,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
    
    final _contentPages = Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * 0.14, bottom: size.height * 0.1),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(color: Colors.red,),
          Container(color: Colors.purple),
          _profile(context, size)
        ],
      ),
    );

    final _bottomNavBar = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        margin: EdgeInsets.only(right: size.width * 0.2),
        height: size.height * 0.09,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white70,//Color.fromRGBO(255, 137, 60, 1).withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home, color: Colors.black54,), text: 'Inicio',),
            Tab(icon: Icon(Icons.format_list_bulleted, color: Colors.black54,), text: 'Categorias',),
            Tab(icon: Icon(Icons.person_outline, color: Colors.black54), text: 'Perfil',),
          ],
        )
      ),
    );

    final _floatingButton = MaterialButton(
      elevation: 7.0,
      splashColor: Colors.yellow.withOpacity(0.5),
      color: Color.fromRGBO(252, 111, 101, 1),
      child: Container(
        height: size.height* 0.09,
        width: size.width * 0.09,
        child: Icon(Icons.add, color: Colors.white, size: 40,),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      onPressed: () => print('Add'),
    );

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(233, 233, 233, 1),
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[

            Positioned(
              left: -50,
              child: rectangleOrange(context, size)
            ),
            Positioned(
              left: size.width * 0.33,
              top: -10,
              child: rectangleRed(context, size),
            ),

            _appBar,
            _photoProfile,
            _contentPages,
            _bottomNavBar

          ],
        ),
      ),

      floatingActionButton: _floatingButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }

  Widget _profile(BuildContext context, Size size){

    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: size.height * 0.1,
          ),
          Divider(height: 100, color: Colors.orange),
          Text('Nombre', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 13,),
          Text('Israel', style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
          SizedBox(height: 25,),
          Text('email', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Israel', style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
          MaterialButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.exit_to_app),
                Text('Cerrar sesion')
              ],
            ),
            onPressed: ()=> print('Cerrar sesion'),
          )
        ],
      ),
    );

  }

}