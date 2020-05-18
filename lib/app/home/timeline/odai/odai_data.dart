import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';

class OdaiModel extends ChangeNotifier {
  int _currentIndex = 0;
  Odai _odai;
  Odai get odai => _odai;
  List<Odai> _odaies = [];
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
  void getOdaies(List<Odai> odaies) {
    _odaies = odaies;
    print(_odaies);
    notifyListeners();
  }
    // increment()が呼ばれると、Listenerたちに変更を通知する
}