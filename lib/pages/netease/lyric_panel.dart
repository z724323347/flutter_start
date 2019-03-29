import 'package:flutter/material.dart';
import './lyric_model.dart';

typedef void PositionChangeHandler(int second);

class LyricPanel extends StatefulWidget {
  final Lyric lyric;
  PositionChangeHandler handler;

  LyricPanel(@required this.lyric);

  _LyricPanelState createState() => _LyricPanelState();
}

class _LyricPanelState extends State<LyricPanel> {
  
  int index = 0;
  LyricSlice currentSlice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget
    ..handler = ((position) {
      print('..handler ' + position.toString());
      LyricSlice slice =widget.lyric.slices[index];
      if (position > slice.in_second) {
        index ++;
        setState((){
          currentSlice =slice;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            currentSlice != null ? currentSlice.slice : '',
            style: TextStyle(
              color: Colors.greenAccent
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> buildLyricItems(Lyric lyric) {
    List<Widget> items =List();
    for (LyricSlice slice in lyric.slices) {
      if (slice != null && slice.slice !=null) {
        items.add(Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              slice.slice,
              style:TextStyle(
                color:Colors.white
              )
            ),
          ),
        ));
      }
      return items;
    }
  }




}