import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:zupay/models/movie_model.dart';
import 'package:zupay/services/auth.dart';
import 'package:zupay/services/db_interaction.dart';
import 'package:zupay/views/signInPage.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _db = Localstore.instance;
  final _items = <String, Movie>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  void initState() {
    _subscription = _db.collection('movies').stream.listen((event) {
      setState(() {
        final item = Movie.fromMap(event);
        _items.putIfAbsent(item.id, () => item);
      });
    });
    if (kIsWeb) _db.collection('movies').stream.asBroadcastStream();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String name = '';
  String director = '';
  String posterUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Movies'),
        actions: [
          TextButton(
              onPressed: () async {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _items.keys.length,
          itemBuilder: (context, index) {
            final key = _items.keys.elementAt(index);
            final item = _items[key]!;
            return Card(
              child: Dismissible(
                key: Key(_items.toString()),
                background: Container(
                  color: Colors.red,
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    item.delete();
                    _items.remove(item.id);
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Deleted')));
                },
                child: ListTile(
                  // value: item.done,
                  title: Text('${item.name}'),
                  leading: Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                          width: 70, child: Image.network(item.poster))),
                  trailing: Text('by ${item.director}'),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Add new movie')),
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -85.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            // backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                // controller: myController,
                                onSaved: (value) {
                                  name = value.toString();
                                },
                                decoration: InputDecoration(
                                  hintText: 'Movie Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                // controller: myController,
                                decoration: InputDecoration(
                                  hintText: 'Director',
                                ),
                                onSaved: (value) {
                                  director = value.toString();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                // controller: myController,
                                decoration: InputDecoration(
                                  hintText: 'Poster Image',
                                ),
                                onSaved: (value) {
                                  posterUrl = value.toString();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                child: Text(
                                  "Submit",
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    final id = Localstore.instance
                                        .collection('movies')
                                        .doc()
                                        .id;

                                    final now = DateTime.now();
                                    final item = Movie(
                                      id: id,
                                      name: name,
                                      director: director,
                                      poster: posterUrl,
                                      time: now,
                                      done: false,
                                    );
                                    item.save();
                                    _items.putIfAbsent(item.id, () => item);

                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        tooltip: 'add',
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
    myController.dispose();
  }
}
