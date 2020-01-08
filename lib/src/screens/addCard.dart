import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ticknote/src/bloc/cardBloc.dart';
import 'package:ticknote/src/bloc/provider.dart';
import 'package:ticknote/src/widgets/rectangleOrange.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> with RectangleOrange{

  final _numberController = TextEditingController();
  final _maskedNumber     = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {'#' : RegExp(r'[0-9]')});
  final _dateController   = TextEditingController();
  final _maskedDate       = MaskTextInputFormatter(mask: '##/##');
  final _cvvController    = TextEditingController();
  final _maskCvv          = MaskTextInputFormatter(mask: '###', filter: {'#' : RegExp(r'[0-9]')});

  //CardBloc cardBloc;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    super.dispose();
    CardBloc().changeNumber('');
    CardBloc().dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final cardBloc  = Provider.card(context);
    final size      = MediaQuery.of(context).size;

    final _formAddCard = Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _cardWidget(context, size, cardBloc),
            SizedBox(height: size.height * 0.05),
            TextField(
              controller: _numberController,
              inputFormatters: [_maskedNumber],
              keyboardType: TextInputType.number,//WithOptions(decimal: false, signed: false),
              decoration: InputDecoration(
                labelText: 'Numero',
                hintText: 'Numero'
              ),
              onChanged: (number) => cardBloc.changeNumber(number),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    inputFormatters: [_maskedDate],
                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                    decoration: InputDecoration(
                      labelText: 'Fecha',
                      hintText: 'Fecha'
                    ),
                    onChanged: (date) => cardBloc.changeDate(date),
                  ),
                ),
                SizedBox(width: size.width * 0.1,),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    inputFormatters: [_maskCvv],
                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: 'CVV',
                    ),
                    onChanged: (cvv) => cardBloc.changeCvv(cvv),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Agregar Tarjeta', style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
      ),
      body: Stack(
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
            _formAddCard
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.check, color: Colors.white),
          onPressed: () => print('Agregar tarjeta'),
        ),
    );
  }

  Widget _cardWidget(BuildContext context, Size size, CardBloc cardBloc){

    return StreamBuilder<String>(
      stream: cardBloc.numberStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        print(snapshot.data);
        return Card(
          elevation: 4.0,
          color: !snapshot.hasData ? Colors.grey : snapshot.data.startsWith('4') ? Colors.blue : snapshot.data.startsWith('5') ? Colors.black87 : Colors.grey ,
          child: Container(
            height: size.height * 0.2,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: size.width * 0.045,
                  top: size.height * 0.075,
                  child: Text(
                    !snapshot.hasData ? '' : snapshot.data, 
                    style: TextStyle(color: Colors.white, fontSize: 25 ),
                  )//_textNumber(context, size, cardBloc)
                ),
                Positioned(
                  left: size.width * 0.1,
                  bottom: size.height * 0.03,
                  child: _cardDate(context, size, cardBloc)//Text('03/27', style: TextStyle(color: Colors.white, fontSize: 20 )),
                ),
                Positioned(
                  left: size.width * 0.3,
                  bottom: size.height * 0.03,
                  child: _cardCvv(context, size, cardBloc)//Text('03/27', style: TextStyle(color: Colors.white, fontSize: 20 )),
                ),
                Positioned(
                  right: size.width * 0.1,
                  bottom: size.height * 0.03,
                  child: Icon( 
                    !snapshot.hasData ? FontAwesomeIcons.creditCard : snapshot.data.startsWith('4') ? FontAwesomeIcons.ccVisa :  snapshot.data.startsWith('5')  ? FontAwesomeIcons.ccMastercard : FontAwesomeIcons.creditCard, 
                    size: 30,
                    color: Colors.white,),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _cardDate(BuildContext context, Size size, CardBloc cardBloc){

    return StreamBuilder<String>(
      stream: cardBloc.dateStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot ) {
        return snapshot.hasData ? Text( snapshot.hasData == null ? '' : snapshot.data, style: TextStyle(color: Colors.white, fontSize: 20 )) : Text('');
      },
    );
    
  }

  Widget _cardCvv(BuildContext context, Size size, CardBloc cardBloc){

    return StreamBuilder<String>(
      stream: cardBloc.cvvStream,
      builder: ( BuildContext context, AsyncSnapshot<String> snapshot ) {
        print(snapshot.hasData);
        return  snapshot.hasData ? Text(snapshot.data, style: TextStyle(color: Colors.white, fontSize: 20 )) : Text('');
      },
    );

  }

}