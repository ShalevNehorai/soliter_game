import 'package:flutter/material.dart';
import 'package:soliter_game/playing_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: GameScreen()),
    );
  }
}

class GameScreen extends StatelessWidget{

  final Deck _deck = Deck();

  PlayingCardWidget _playingCardWidget = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: PlayingCardWidget(card: PlayingCard(suit: CardSuit.diamonds, type: CardType.jeck, faceUp: false),)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragTarget<PlayingCardWidget>(
                      onWillAccept: (data) {
                        print(data);
                        return true;
                      },
                      onAccept: (data) {
                        this._playingCardWidget = data;
                      },
                      builder: (context, candidateData, rejectedData) {
                        return _playingCardWidget??  Container(
                          width: 50,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: PlayingCardWidget(card: PlayingCard(type: CardType.ace, suit: CardSuit.clubs, faceUp: true),),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class PlayingCardWidget extends StatefulWidget {

  final PlayingCard card;

  const PlayingCardWidget({this.card});

  @override
  _PlayingCardWidgetState createState() => _PlayingCardWidgetState();
}

class _PlayingCardWidgetState extends State<PlayingCardWidget> {

  final double width = 50;
  final double height = 80;

  Widget _faceDownWidget(){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget _faceUpWidget(){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
            child: Row(
              children: [
                Text(widget.card.getCardTypeSigh(), style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                SizedBox(width: 2,),
                widget.card.getSuitImage()
              ],
            ),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.card.faceUp? Draggable<PlayingCardWidget>(
      data: widget,
      childWhenDragging: Container(),
      feedback: _faceUpWidget(),
      child: _faceUpWidget(),
    ): _faceDownWidget();
  }
}