import 'dart:convert' show json;

class MusicBroadcasting {

  int code;
  String message;
  List<ChannelList> result;

  MusicBroadcasting.fromParams({this.code, this.message, this.result});

  factory MusicBroadcasting(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MusicBroadcasting.fromJson(json.decode(jsonStr)) : new MusicBroadcasting.fromJson(jsonStr);
  
  MusicBroadcasting.fromJson(jsonRes) {
    code = jsonRes['code'];
    message = jsonRes['message'];
    result = jsonRes['result'] == null ? null : [];

    for (var resultItem in result == null ? [] : jsonRes['result']){
            result.add(resultItem == null ? null : new ChannelList.fromJson(resultItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"message": ${message != null?'${json.encode(message)}':'null'},"result": $result}';
  }
}

class ChannelList {

  int cid;
  String title;
  List<ChannelCid> channellist;

  ChannelList.fromParams({this.cid, this.title, this.channellist});
  
  ChannelList.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    title = jsonRes['title'];
    channellist = jsonRes['channellist'] == null ? null : [];

    for (var channellistItem in channellist == null ? [] : jsonRes['channellist']){
            channellist.add(channellistItem == null ? null : new ChannelCid.fromJson(channellistItem));
    }
  }

  @override
  String toString() {
    return '{"cid": $cid,"title": ${title != null?'${json.encode(title)}':'null'},"channellist": $channellist}';
  }
}

class ChannelCid {

  int value;
  String cate_name;
  String cate_sname;
  String ch_name;
  String channelid;
  String name;
  String thumb;

  ChannelCid.fromParams({this.value, this.cate_name, this.cate_sname, this.ch_name, this.channelid, this.name, this.thumb});
  
  ChannelCid.fromJson(jsonRes) {
    value = jsonRes['value'];
    cate_name = jsonRes['cate_name'];
    cate_sname = jsonRes['cate_sname'];
    ch_name = jsonRes['ch_name'];
    channelid = jsonRes['channelid'];
    name = jsonRes['name'];
    thumb = jsonRes['thumb'];
  }

  @override
  String toString() {
    return '{"value": $value,"cate_name": ${cate_name != null?'${json.encode(cate_name)}':'null'},"cate_sname": ${cate_sname != null?'${json.encode(cate_sname)}':'null'},"ch_name": ${ch_name != null?'${json.encode(ch_name)}':'null'},"channelid": ${channelid != null?'${json.encode(channelid)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"thumb": ${thumb != null?'${json.encode(thumb)}':'null'}}';
  }
}

