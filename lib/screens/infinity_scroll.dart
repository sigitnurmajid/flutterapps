// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// import 'package:testflu/screens/hello_word.dart';


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordsPair = <WordPair>[];
  final _savedWordsPair = Set<WordPair>();

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context,item){
        if(item.isOdd) return Divider();

        final index = item ~/ 2;

        if(index >= _randomWordsPair.length){
          _randomWordsPair.addAll(generateWordPairs().take(10));
        }

        // print (_savedWordsPair);
        return _buildRow(_randomWordsPair[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _savedWordsPair.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(alreadySaved ? Icons.favorite :
      Icons.favorite_border,
        color: alreadySaved ? Colors.red : null),
      onTap: (){
        setState(() {
          if (alreadySaved){
            _savedWordsPair.remove(pair);
          } else {
            _savedWordsPair.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved (){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = 
          _savedWordsPair.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0),),
            );
          });

          final List<Widget> divided = ListTile.divideTiles(
            context : context,
            tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Words Pair'),
            ),
            body: ListView(children : divided)
          );
          // return MaterialApp(
          //   theme: ThemeData(primaryColor: Colors.teal[400]),
          //   home: HelloWorld(),
          // );
        }
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ]
      ),
        body: _buildList(),
    );
  }
}