import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';

class OdaiModel extends ChangeNotifier {
  int _funnyNumber = 0;
  int get funnyNumber => _funnyNumber;
  int _currentIndex = 0;
  String _odai;
  String get odai => _odai;
  String _answer;
  String get answer => _answer;
  // List<String> _list = [];
  // //mapも初期設定すればいける説
  // List<String> get list => _list;
  //mapもしくはlistに変えて値そ出力
  Map<String, String> _odaiMap = Map<String, String>();
  Map get odaiMap => _odaiMap;
  List<Odai> _odaies = [];
  List<Answer> _answers = [];

  void funnyIncrement() {
    _funnyNumber++;
    notifyListeners();
  }

  void funnyIncrementReset() {
    _funnyNumber = 0;
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
    _odai = _answers[_currentIndex].odai;
    // _answer = _answers[_currentIndex].answer;
    // _list.add(_odai);
    // _list.add(_answer);
    _odaiMap['odai'] = _answers[_currentIndex].odai;
    _odaiMap['answer'] = _answers[_currentIndex].answer;
    _odaiMap['id'] = _answers[_currentIndex].id;
    //id,odai,answerを保存
    // title;
    // odai = title;
    print(_odai);
    // print(_list);
    print(_odaiMap);
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