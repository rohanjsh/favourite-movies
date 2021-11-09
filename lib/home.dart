import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class TimeLines extends StatefulWidget {
  const TimeLines({Key? key}) : super(key: key);

  @override
  State<TimeLines> createState() => _TimeLinesState();
}

class _TimeLinesState extends State<TimeLines> {
  late int currentTabIndex;
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
    currentTabIndex = 0;
    super.initState();
  }

  setCurrentTabIndex(int val) {
    setState(() {
      currentTabIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(color: Colors.black87, blurRadius: 3),
            ]),
        child: FloatingActionButton.extended(
          elevation: 5,
          backgroundColor: Color(0xff255FD5),
          onPressed: () {},
          label: Row(
            children: [
              Icon(
                Icons.play_arrow_rounded,
              ),
              Text(
                'Start Session',
                style: TextStyle(letterSpacing: 0.5),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffFFFFFF),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        onTap: setCurrentTabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_people), label: 'Rehab'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Demo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Text(
                  'Good Morning \nJane',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      height: 1.1,
                      color: Color(0xff3A3937)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'You have 4 sessions \ntoday!',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      height: 1.1,
                      color: Color(0xff6D6D6D)),
                ),
                SizedBox(
                  height: 20,
                ),
                FixedTimeline.tileBuilder(
                  theme: TimelineTheme.of(context).copyWith(
                    nodePosition: 0.0,
                  ),
                  builder: TimelineTileBuilder.connected(
                    contentsAlign: ContentsAlign.basic,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.shortestSide / 1.18,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(width: 1.5, color: Colors.black12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Session 1',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          color: Color(0xff3F3E3C),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons
                                                  .airline_seat_recline_extra_outlined,
                                              color: Color(0xff3688BC),
                                              size: 15,
                                            ),
                                          ),
                                          Text(
                                            "Knee Rehab \nProgramme",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff3688BC),
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Color(0xff255FD5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 20),
                                          child: Text(
                                            'Competed',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Performed At',
                                            style: TextStyle(
                                              color: Color(
                                                0xffC5C5CC,
                                              ),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            '8:12 AM',
                                            style: TextStyle(
                                                color: Color(0xff7C7C7C),
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  'https://i.ibb.co/z2X93RT/image.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    connectorBuilder: (_, index, ___) => DashedLineConnector(
                      color: Color(0xff255FD5),
                      gap: 12,
                      dash: 12,
                    ),
                    indicatorBuilder: (_, index) => Indicator.outlined(
                      borderWidth: 2.0,
                      size: 26,
                      backgroundColor: Color(0xff255FD5),
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),

                    // connectorStyleBuilder: (context, index) =>
                    //     ConnectorStyle.dashedLine,
                    // indicatorStyleBuilder: (context, index) =>
                    //     IndicatorStyle.outlined,
                    itemCount: 4,
                    // firstConnectorStyle: ConnectorStyle.transparent,
                    // lastConnectorStyle: ConnectorStyle.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
