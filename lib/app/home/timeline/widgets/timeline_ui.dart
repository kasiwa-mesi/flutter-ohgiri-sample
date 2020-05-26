import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/app/home/timeline/odai/odai_data.dart';
import 'package:ohgiri_sample/app/home/home_page.dart';
import 'package:ohgiri_sample/app/home/timeline/timeline_pages_builder.dart';
import 'package:ohgiri_sample/app/home/timeline/timeline_page.dart';
import 'package:ohgiri_sample/app/home/timeline/widgets/downscroll_icon.dart';

class TimelineUi extends StatefulWidget {
  @override
  _TimelineUiState createState() => _TimelineUiState();
}

class _TimelineUiState extends State<TimelineUi> {
  // int _currentIndex;
  // PageController _pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   _currentIndex = 0;
  //   _pageController = PageController(initialPage: _currentIndex);
  // }

  // void _nextPage(int delta) {
  //   _pageController.animateToPage(_currentIndex + delta,
  //       duration: const Duration(milliseconds: 300), curve: Curves.ease);
  // }

  // void _handlePageChanged(int page) {
  //   setState(() {
  //     _currentIndex = page;
  //   });
  // }

  // 作成過程
  //1.itemCountをとりあえず、odaies.lengthにする。
  //2.Textは適当で、お題の数だけ出力する

  @override
  Widget build(BuildContext context) {
    print('TimelinePage rebuild');
    final odaiModel = Provider.of<OdaiModel>(context, listen: false);
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final _pageController = PageController();
    _onPageViewChange(int page) {
      print("Current Page: " + page.toString());
      Future(() {
        odaiModel.getOdaiId(page);
      });
    }
    return StreamBuilder<List<Odai>>(
        stream: database.odaisStream(),
        builder: (context, snapshot) {
          // return TimelinePagesBuilder(
          // snapshot: snapshot,
          print('StreamBuilderForOdai: ${snapshot.connectionState}');
          final List<Odai> odaies = snapshot.data;
          final odaiCount = odaies.length;
          Future(() {
            odaiModel.getOdaies(odaies);
            odaiModel.setOdaiIds(odaiCount);
            odaiModel.getOdaiIdInIds();
          });
          if (odaies == null) {
            return Container();
          }
          // if (odaies != null) {
          //   return MultiProvider(
          //     providers: [
          //       Provider<List<Odai>>.value(value: odaies),
          //       ChangeNotifierProvider<OdaiModel>.value(
          //         value: ,
          //       )
          //     ],
          //   );
          // }
          //answers.countにして回答の数だけpageviewを作れるようにしたい。
          return StreamBuilder<List<Answer>>(
            stream: database.answersStream(odaiId: odaiModel.odaiId),
            builder: (context, snapshot) {
              print('StreamBuilderForAnswer: ${snapshot.connectionState}');
              final List<Answer> answers = snapshot.data;
              print(answers);
              // final answerCount = answers.length;
              Future(() {
                odaiModel.getAnswers(answers);
              });
              // if (answers = null) {
              //   return Container();
              // }
            return Expanded(
              child: PageView.builder(
                onPageChanged: _onPageViewChange,
                controller: _pageController,
                scrollDirection: Axis.vertical,
                //ここでお題のIDをanswerに渡せる仕組みにしたい。
                itemBuilder: (context, index) {
                  // print(odaies.length);
                  print(index);
                  final String title = odaies[index].name;
                  final String answer = answers[index].name;
                  // final String id = odaies[index].id;
                  //このidをページが更新されるごとにfirestoreから答えを保存する。
                  //odai/id/answersで読み込めるように
                  //でもこの処理を書くなら、確実にpageViewの外でやる必要がある。 
                  // Future(() {
                  //   Provider.of<OdaiModel>(context, listen: false).getOdai(title);
                  // });
                  return ListTile(
                    title: Text(
                        title,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    subtitle: Center(
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 30.0
                        ),
                      ),
                    ),
                  );
                },
                itemCount: odaies.length,
                // children: _buildFullPages(odaiCount, odaies),
                // children: TimelinePageTile(odaiCount: snapshot.data.length, odaies: snapshot.data,),
                //childrenでも対応できるwidgetを探す？？？
                // ),
                // print('StreamBuilder: ${snapshot.connectionState}');
                // final List<Odai> odaies = snapshot.data;
                // int odaiCount;
                // if (odaies == null) {
                //   odaiCount = 0;
                // } else {
                //   odaiCount = odaies.length;
                // }
                //Pageviewのコード(下)
                //____________________________
                // return Expanded(
                //   child: PageView.builder(
                //     controller: _pageController,
                //     scrollDirection: Axis.vertical,
                //     onPageChanged: _handlePageChanged,
                //     itemCount: odaiCount,
                //     itemBuilder: (BuildContext context, int index) {
                //      return  _buildFullPages(context, odaiCount);
                //     },
                //   ),
                // );
              ),
            );
            });
        });
  }

//   List<Container> _buildFullPages(int count, List<Odai> odaies) {
//     // for (var odai in odaies) {
//     //   print(odai.name);
//     // }
//     List<Container> pages = List.generate(
//       count,
//       (int index) => Container(
//         child: Center(
//           child: Text(
//             odaies[index].name,
//             // 'こんな鮨屋は嫌だ？一体何？',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 40,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ),
//     );
//     return pages;
//   }
}
