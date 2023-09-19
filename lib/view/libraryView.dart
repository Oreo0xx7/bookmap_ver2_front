import 'package:bookmap_ver2/model/libraryModel.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../asset.dart';
import '../controller/bookController.dart';
import '../searchDetailGet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LibraryState();
  }
}

class LibraryState extends StatefulWidget{
  @override
  LibraryTabsState createState() => LibraryTabsState();
}

class LibraryTabsState extends State<LibraryState> with SingleTickerProviderStateMixin{
  //final BookController bookController = Get.find<BookController>();
  late TabController libraryTapController;
  final BookController bookController = Get.put(BookController());
  late Future<List<dynamic>> fetchData;
  final List<String> bookTypeList = ['읽고 싶은', '읽는 중인', '읽은'];

  @override
  void initState(){
    super.initState();
    libraryTapController = Get.put(TabController(length: 4, vsync: this));
    fetchData = _fetchData();
  }

  // 검색을 위한...
  final FocusNode _focusNode = FocusNode();
  int homeStatus = 0;
  // late TabController _tabController;
  // late TextEditingController? _editingController;
  // ScrollController? _scrollController;
  static List? data;
  int page = 1;
  String? searchQuery;


  @override
  Widget build(BuildContext context) {
     return Column(
       children: [
         SearchLibrary(),

         //탭 바
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: libraryTapController,
              isScrollable: true,
              labelColor: appColor.shade900,
              unselectedLabelColor: appColor.shade800,
              labelStyle: const TextStyle(fontFamily: "Pretendard", fontSize: 16, fontWeight: FontWeight.w600),
              indicator: CircleTabIndicator(color: appColor.shade900, radius: 4),
              indicatorColor: appColor.shade700,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "읽고 싶은"),
                Tab(text: "읽고 있는"),
                Tab(text: "읽은"),
              ],
            ),
          ),
         Padding(padding: EdgeInsets.only(bottom: 10)),

         //탭 내부
         GetX<BookController>(
             builder: (bookController) {
             return SizedBox(
               width: double.maxFinite,
               height: (MediaQuery.of(context).size.height - 310),
               child: TabBarView(
                 controller: libraryTapController,
                 children: [
                   //전체
                   NotificationListener(
                             onNotification: (OverscrollIndicatorNotification overscroll) {
                               overscroll.disallowIndicator();
                               return true;
                             },
                             child: ListView.builder(
                               itemCount: bookController.books!.length,
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
                                             child: Image.network(bookController.books[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                         const Spacer(
                                           flex: 1,
                                         ),
                                         Expanded(
                                           flex: 11,
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [
                                                   Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Row(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children:[Icon(Icons.circle, color: bookColor[bookController.books[index].sort],),
                                                         Text('${bookTypeList[bookController.books[index].sort]}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)]
                                                       ),
                                                       Padding(padding: EdgeInsets.only(bottom: 10)),
                                                       Text('${bookController.books[index].bookName}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                                       Text('${bookController.books[index].writer}', style: TextStyle(fontSize: 14),)
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
                   //읽고 싶은
                   NotificationListener(
                     onNotification: (OverscrollIndicatorNotification overscroll) {
                       overscroll.disallowIndicator();
                       return true;
                     },
                     child: ListView.builder(
                       itemCount: bookController.books.where((p0) => p0.sort == 0).toList().length,
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
                                     child: Image.network(bookController.books.where((p0) => p0.sort == 0).toList()[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                 const Spacer(
                                   flex: 1,
                                 ),
                                 Expanded(
                                   flex: 11,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children:[Icon(Icons.circle, color: bookColor[0],),
                                                 Text(bookTypeList[bookController.books.where((p0) => p0.sort == 0).toList()[index].sort], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)]
                                           ),
                                           Padding(padding: EdgeInsets.only(bottom: 10)),
                                           Text(bookController.books.where((p0) => p0.sort == 0).toList()[index].bookName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                           Text(bookController.books.where((p0) => p0.sort == 0).toList()[index].writer, style: TextStyle(fontSize: 14),)
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
                   //읽고 있는
                   NotificationListener(
                     onNotification: (OverscrollIndicatorNotification overscroll) {
                       overscroll.disallowIndicator();
                       return true;
                     },
                     child: ListView.builder(
                       itemCount: bookController.books.where((p0) => p0.sort == 1).toList().length,
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
                                     child: Image.network(bookController.books.where((p0) => p0.sort == 1).toList()[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                 const Spacer(
                                   flex: 1,
                                 ),
                                 Expanded(
                                   flex: 11,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children:[Icon(Icons.circle, color: bookColor[1],),
                                                 Text(bookTypeList[bookController.books.where((p0) => p0.sort == 1).toList()[index].sort], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)]
                                           ),
                                           Padding(padding: EdgeInsets.only(bottom: 10)),
                                           Text(bookController.books.where((p0) => p0.sort == 1).toList()[index].bookName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                           Text(bookController.books.where((p0) => p0.sort == 1).toList()[index].writer, style: TextStyle(fontSize: 14),)
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
                   //읽은
                   NotificationListener(
                     onNotification: (OverscrollIndicatorNotification overscroll) {
                       overscroll.disallowIndicator();
                       return true;
                     },
                     child: ListView.builder(
                       itemCount: bookController.books.where((p0) => p0.sort == 2).toList().length,
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
                                     child: Image.network(bookController.books.where((p0) => p0.sort == 2).toList()[index].img, fit: BoxFit.fitWidth, width: 50,)),
                                 const Spacer(
                                   flex: 1,
                                 ),
                                 Expanded(
                                   flex: 11,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children:[Icon(Icons.circle, color: bookColor[2],),
                                                 Text(bookTypeList[bookController.books.where((p0) => p0.sort == 2).toList()[index].sort], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)]
                                           ),
                                           Padding(padding: EdgeInsets.only(bottom: 10)),
                                           Text(bookController.books.where((p0) => p0.sort == 2).toList()[index].bookName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                           Text(bookController.books.where((p0) => p0.sort == 2).toList()[index].writer, style: TextStyle(fontSize: 14),)
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
       ],
     );
  }

  Padding SearchLibrary() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(16))
          ),
          child: TextField(
            focusNode: _focusNode,
            cursorColor: appColor.shade800,
            keyboardType: TextInputType.text,
            onTap: (){
            },
            decoration: InputDecoration(
              //검색바 클릭 전 border
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                    color: appColor.shade700,
                    width: 1.2
                ),
              ),
              //검색바 클릭시 아래 border 출력
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                    color: appColor.shade700,
                    width: 1.2
                ),
              ),
              contentPadding: const EdgeInsets.only(left: 15, top: 16),
              hintText: '서재 내 도서 검색',
              hintStyle: TextStyle(color: appColor.shade800),
              // homeContent 화면으로의 back을 위한 아이콘
              // 검색 아이콘
              suffixIcon: Icon(Icons.search, color: appColor.shade900),
            ),
            textInputAction: TextInputAction.search,
          ),
        )
    );
  }

  //bookdata fetch 를 위한...
  Future<List<Map<String, dynamic>>> _fetchData() async {
    http.Client client = http.Client();

    final response = await client.get(Uri.parse(server + '/bookshelf/allbooks'),
        headers: <String, String>{
          'Authorization': 'Bearer ${loginController.idToken}'
        });
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<dynamic> listData = data;
    List<Map<String, dynamic>> mappedData = listData.map((item) => item as Map<String, dynamic>).toList();

    return mappedData;
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


