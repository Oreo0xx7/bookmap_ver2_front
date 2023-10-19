import 'package:bookmap_ver2/model/searchUserModel.dart';
import 'package:flutter/material.dart';

import '../asset.dart';

class MainSearchUserTile extends StatelessWidget {

  final SearchUserModel searchUserModel;
  MainSearchUserTile(this.searchUserModel);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: appColor,
                backgroundImage: NetworkImage(
                    searchUserModel.image
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    searchUserModel.nickname,
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 8),
                  Text(
                    searchUserModel.status,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
              SizedBox(width: 10),
          //     TextButton(onPressed: (){
          //
          //     },
          //       child: Text(
          //       '팔로우',
          //       maxLines: 2,
          //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          //     ),)
             ],
           ),
        )
    );
  }
}
