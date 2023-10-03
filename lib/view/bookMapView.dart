import 'package:bookmap_ver2/controller/bookMapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset.dart';

class BookMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BookMapState();
  }
}

class BookMapState extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BoockMapTapState();
}

class BoockMapTapState extends State<BookMapState> with SingleTickerProviderStateMixin{
  late TabController bookMapTapController;
  final BookMapController bookMapController = Get.find<BookMapController>();
  @override
  void initState(){
    super.initState();
    bookMapTapController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: bookMapTapController,
              isScrollable: true,
              labelColor: appColor.shade900,
              unselectedLabelColor: appColor.shade800,
              labelStyle: const TextStyle(fontFamily: "Pretendard", fontSize: 16, fontWeight: FontWeight.w600),
              indicator: CircleTabIndicator(color: appColor.shade900, radius: 4),
              indicatorColor: appColor.shade700,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "내가 만든"),
                Tab(text: "스크랩"),
              ],
            ),
          ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: GetX<BookMapController>(
              builder: (bookMapController) {
                return SizedBox(
                  width: double.maxFinite,
                  height: (MediaQuery.of(context).size.height - 240),
                  child: TabBarView(
                    controller: bookMapTapController,
                    children: [
                      //전체
                      NotificationListener(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: bookMapController.myBookMaps.length,
                          itemBuilder: (context, index){
                            return Card(
                              surfaceTintColor: appColor,
                              margin: EdgeInsets.all(12),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Image.network(bookMapController.myBookMaps[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 11,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(bottom: 10)),
                                              Text('${bookMapController.myBookMaps[index].mapName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                              Text('${bookMapController.myBookMaps[index].makerName}', style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //내가 만든 sort:1
                      NotificationListener(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: bookMapController.myBookMaps.where((p0) => (p0.sort == 1)).length,
                          itemBuilder: (context, index){
                            return Card(
                              surfaceTintColor: appColor,
                              margin: EdgeInsets.all(12),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Image.network(bookMapController.myBookMaps.where((p0) => (p0.sort == 1)).toList()[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 11,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(bottom: 10)),
                                              Text('${bookMapController.myBookMaps.where((p0) => (p0.sort == 1)).toList()[index].mapName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                              Text('${bookMapController.myBookMaps.where((p0) => (p0.sort == 1)).toList()[index].makerName}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //스크랩
                      NotificationListener(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: bookMapController.myBookMaps.where((p0) => (p0.sort == 2)).length,
                          itemBuilder: (context, index){
                            return Card(
                              surfaceTintColor: appColor,
                              margin: EdgeInsets.all(12),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Image.network(bookMapController.myBookMaps.where((p0) => (p0.sort == 2)).toList()[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 11,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(padding: EdgeInsets.only(bottom: 10)),
                                              Text('${bookMapController.myBookMaps.where((p0) => (p0.sort == 2)).toList()[index].mapName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                                              Text('${bookMapController.myBookMaps.where((p0) => (p0.sort == 2)).toList()[index].makerName}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],),
                );
              }
          ),
        ),
      ],
    );
  }
}

// TabBar indicator decoration
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}
class _CirclePainter extends BoxPainter{
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint ..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}