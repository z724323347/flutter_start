import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/toast.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //图片
  final String leaderPhone; //电话
  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:'+ leaderPhone;
    ToastUtil.showCenter(url);
    print(url);

    // //  拨打电话
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}