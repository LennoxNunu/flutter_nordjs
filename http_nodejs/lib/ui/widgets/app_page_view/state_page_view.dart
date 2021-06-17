import 'package:flutter/material.dart';

class StatePageView extends StatefulWidget {
  StatePageView({Key key}) : super(key: key);

  @override
  _StatePageViewState createState() => _StatePageViewState();
}

class _StatePageViewState extends State<StatePageView> {
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: PageView(
            controller: _pageController,
            children: [
              onBoardPage("onboard1", "Take Notes"),
              onBoardPage("onboard2", "Work Happens"),
              onBoardPage("onboard3", "Task and Assignments"),
            ],
            onPageChanged: (value) => {setCurrentPage(value)},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => getIndicator(index)),
        )
      ],
    );
  }

  Column onBoardPage(String img, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/image/$img.png'))),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }
}
