import 'package:localstore/localstore.dart';
import 'package:zupay/models/movie_model.dart';

extension ExtMovies on Movie {
  Future save() async {
    final _db = Localstore.instance;
    return _db.collection('movies').doc(id).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('movies').doc(id).delete();
  }
}
