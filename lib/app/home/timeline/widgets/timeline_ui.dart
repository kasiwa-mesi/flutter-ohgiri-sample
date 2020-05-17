import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
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
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final _pageController = PageController();
    _onPageViewChange(int page) {
      int currentIndex;
      if (page != 0) {
        print("Current Page: " + page.toString());
        currentIndex = page;
      }
    }
    return StreamBuilder<List<Odai>>(
        stream: database.odaisStream(),
        builder: (context, snapshot) {
          // return TimelinePagesBuilder(
          // snapshot: snapshot,
          print('StreamBuilder: ${snapshot.connectionState}');
          final List<Odai> odaies = snapshot.data;
          if (odaies == null) {
            return Container();
          }
          final odaiCount = odaies.length;
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
                return ListTile(
                  title: Text(title),
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
  }

  List<Container> _buildFullPages(int count, List<Odai> odaies) {
    // for (var odai in odaies) {
    //   print(odai.name);
    // }
    List<Container> pages = List.generate(
      count,
      (int index) => Container(
        child: Center(
          child: Text(
            odaies[index].name,
            // 'こんな鮨屋は嫌だ？一体何？',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
    return pages;
  }
}
