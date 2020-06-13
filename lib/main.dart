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

  bool isGameWon = false;

  void checkWinCondition(){
   //TODO implement winning check
  }

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
                    child: Row(
                      children: [
                        CardPlaceCell(),
                        SizedBox(width: 10,),
                        CardPlaceCell(),
                        SizedBox(width: 10,),
                        CardPlaceCell(),
                        SizedBox(width: 10,),
                        CardPlaceCell(),
                      ],
                    )
                  ),
                ],
              ),
              Flexible(
                child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4
                ),
                itemCount: _deck.cards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: PlayingCardWidget(card: _deck.cards[index],),
                      ),
                    );
                  },
                ),
              ),
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

  static const double width = 50;
  static const double height = 80;

  bool draged = false;

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
    return widget.card.faceUp? Visibility(
      visible: !draged,
      child: Draggable<PlayingCardWidget>(
        data: widget,
        childWhenDragging: Container(),
        feedback: _faceUpWidget(),
        child: _faceUpWidget(),
        onDragEnd: (details) {
        },
        onDragCompleted: () {
          setState(() {
            draged = true;            
          });
        },
      ),
    ): _faceDownWidget();
  }
}

class CardPlaceCell extends StatefulWidget {
  @override
  _CardPlaceCellState createState() => _CardPlaceCellState();
}

class _CardPlaceCellState extends State<CardPlaceCell> {
  PlayingCardWidget _playingCard = null;
  CardSuit _cardSuit = null;

  CardType _getNextCard(){
    if(lastCard()){
      return null;
    }
    return CardType.values[CardType.values.indexOf(_playingCard.card.type) + 1];
  }

  bool lastCard(){
    return _playingCard.card.type == CardType.king;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<PlayingCardWidget>(
      onWillAccept: (data) {
        if(_playingCard == null){
          return data.card.type == CardType.ace;
        }
        else{
          if(_cardSuit != data.card.suit){
            return false;
          }
          else{
            CardType neededType = _getNextCard();
            if(neededType == null){
              return false;
            }
            else{
              return data.card.type == neededType;
            }
          }
        }
      },
      onAccept: (data) {
        if(_cardSuit == null){
          _cardSuit = data.card.suit;
        }
        _playingCard = data;
      },
      builder: (context, candidateData, rejectedData) {
        return _playingCard??  Container(
          width: _PlayingCardWidgetState.width,
          height: _PlayingCardWidgetState.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      },
    );
  }
}