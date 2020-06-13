import 'package:flutter/cupertino.dart';

enum CardType {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jeck,
  queen,
  king,  
}

enum CardSuit{
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardColor{
  red, black,
}

class PlayingCard{
  final CardType type;
  final CardSuit suit;
  bool faceUp;

  PlayingCard({@required this.type, @required this.suit, this.faceUp = false});

  CardColor get color{
    if(suit == CardSuit.hearts || suit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }
  
  @override
  String toString(){
    return '$type of $suit';
  }

  String getCardTypeSigh(){
    String sigh = '';

    switch(type){
      case CardType.ace:
        sigh = 'A';
        break;
      case CardType.two:
        sigh = '2';
        break;
      case CardType.three:
        sigh = '3';
        break;
      case CardType.four:
        sigh = '4';
        break;
      case CardType.five:
        sigh = '5';
        break;
      case CardType.six:
        sigh = '6';
        break;
      case CardType.seven:
        sigh = '7';
        break;
      case CardType.eight:
        sigh = '8';
        break;
      case CardType.nine:
        sigh = '9';
        break;
      case CardType.ten:
        sigh = '10';
        break;
      case CardType.jeck:
        sigh = 'J';
        break;
      case CardType.queen:
        sigh = 'Q';
        break;
      case CardType.king:
        sigh = 'K';
        break;
    }
    return sigh;
  }

  Image getSuitImage(){
    Image suitImg = null;
    switch (suit){
      case CardSuit.spades:
        suitImg = Image(image: AssetImage('assets/logo_suits/spades.png'), width: 20, height: 20,);
        break;
      case CardSuit.hearts:
        suitImg = Image(image: AssetImage('assets/logo_suits/hearts.png'), width: 17, height: 17,);
        break;
      case CardSuit.diamonds:
        suitImg = Image(image: AssetImage('assets/logo_suits/diamonds.png'), width: 20, height: 20,);
        break;
      case CardSuit.clubs:
        suitImg = Image(image: AssetImage('assets/logo_suits/clubs.png'), width: 20, height: 20,);
        break;
    }
    return suitImg;
  }
  
}

class Deck{
  List<PlayingCard> cards = List<PlayingCard>();

  Deck(){
    _initDeck();
    // shuffleDeck();
  }

  void _initDeck(){
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        cards.add(PlayingCard(type: type, suit: suit, faceUp: true));
      });
    });
  }

  void shuffleDeck(){
    cards.shuffle();
  }

  PlayingCard drowCard(){
    if(cards.isNotEmpty){
      return cards.removeLast();
    }
    else{
      print('cards is empty');
      return null;
    }
  }

  void printCards(){
    for (PlayingCard card in cards) {
      print(card);
    }
  }
}