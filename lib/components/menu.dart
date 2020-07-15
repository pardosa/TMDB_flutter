import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class Menu {
  final String main;
  final List<String> sub;

  Menu(this.main, this.sub);
}

class Menus extends StatelessWidget {
  final int selectedMenu;
  final int selectedSubMenu;
  final Function setSelectedMenu;
  final Function setSelectedSubMenu;

  Menus(this.setSelectedMenu, this.setSelectedSubMenu, this.selectedMenu,
      this.selectedSubMenu);

  // List<String> menus = ["All", "Movies", "TV Series", "Person"];
  final List<Menu> menus = [
    new Menu("Movies",
        ["Trending", "Popular", "Top rated", "Now Playing", "Upcoming"]),
    new Menu("TV Series",
        ["Trending", "Popular", "Top rated", "Airing Today", "On The Air"]),
    new Menu("Person", ["Trending", "Popular"])
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          height: 65,
          padding: EdgeInsets.only(left: 10, top: 30),
          child: ListView.builder(
            itemBuilder: (context, index) => buildSubMenu(index, context),
            scrollDirection: Axis.horizontal,
            itemCount: menus[selectedMenu].sub.length,
          ),
        )
      ],
    );
  }

  Padding buildSubMenu(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          this.setSelectedSubMenu(index);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              menus[selectedMenu].sub[index],
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: index == selectedSubMenu
                      ? kTextColor
                      : Colors.black.withOpacity(0.4)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              height: 6,
              width: index == 0 ? 30 : 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index == selectedSubMenu
                      ? kThirdColor
                      : Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
