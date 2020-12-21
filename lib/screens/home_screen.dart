import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wakeupbuddies/DateTimePicker.dart';
import 'package:wakeupbuddies/provider/user_provider.dart';
import 'package:wakeupbuddies/screens/pageviews/calls_screen.dart';
import 'package:wakeupbuddies/screens/pageviews/chat_list_screen.dart';
import 'package:wakeupbuddies/screens/pageviews/contacts_scren.dart';
import 'package:wakeupbuddies/utils/universal_variables.dart';

import 'callscreens/pickup/pickup_layout.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  PageController pageController;

  UserProvider userProvider;

  @override
  void initState(){

    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });


    pageController = PageController();
  }

  void onPageChanged(int page){
    setState((){
      _page = page;
    });
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {

    double _labelFontSize = 10;

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,

        body: PageView(
          children: <Widget>[
            Container(child: ChatListScreen(),),
            Container(child: DateTimePicker(),),
            Container(child: ContactsScreen(),),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              backgroundColor: UniversalVariables.blackColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_rounded ,
                      color: (_page == 0)
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor),
                  title: Text(
                    "Planned",
                    style: TextStyle(
                        fontSize: _labelFontSize,
                        color: (_page == 0)
                            ? UniversalVariables.lightBlueColor
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_alarm_rounded,
                      color: (_page == 1)
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor),
                  title: Text(
                    "New wake-up",
                    style: TextStyle(
                        fontSize: _labelFontSize,
                        color: (_page == 1)
                            ? UniversalVariables.lightBlueColor
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts_outlined,
                      color: (_page == 2)
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor),
                  title: Text(
                    "Buddies",
                    style: TextStyle(
                        fontSize: _labelFontSize,
                        color: (_page == 2)
                            ? UniversalVariables.lightBlueColor
                            : Colors.grey),
                  ),
                ),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}

