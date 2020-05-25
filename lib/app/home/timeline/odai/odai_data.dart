import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';

class OdaiModel extends ChangeNotifier {
  int _funnyNumber = 0;
  int get funnyNumber => _funnyNumber;
  int _currentIndex = 0;
  Odai _odai;
  Odai get odai => _odai;
  List<Odai> _odaies = [];
  List<Answer> _answers = [];
  List<String> _odaiIds = [];
  String _odaiId;
  String get odaiId => _odaiId;

  void funnyIncrement() {
    _funnyNumber++;
    notifyListeners();
  }

  void getOdaiId(int index) {
    _currentIndex = index;
    // if (_odaies != null) {
    //   getOdai(_odaies);
    // }
    print('currentindex:${_currentIndex}');
    notifyListeners();
  }

  void getOdai() {
    getOdaiId(_currentIndex);
    _odai = _odaies[_currentIndex];
    // title;
    // odai = title;
    print(_odai);
    notifyListeners();
  }

  void setOdaiIds(int odaiLength) {
    for (int i = 0; i < odaiLength; i++) {
      if (_odaiIds.contains(_odaies[i].id)) {
        print('already have odaiId');
      } else {
        _odaiIds.add(_odaies[i].id);
        print(_odaiIds);
      }
    }
  }

  void getOdaiIdInIds() {
    _odaiId = _odaiIds.first;
    print(_odaiId);
    notifyListeners();
  }

  void getOdaies(List<Odai> odaies) {
    _odaies = odaies;
    print(_odaies);
    notifyListeners();
  }

  void getAnswers(List<Answer> answers) {
    _answers = answers;
    print(_answers);
    notifyListeners();
  }
  // increment()が呼ばれると、Listenerたちに変更を通知する
}
