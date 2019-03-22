import 'dart:convert' show json;

class CategoryGoodsListModel {

  String code;
  String message;
  List<GoodsList> data;

  CategoryGoodsListModel.fromParams({this.code, this.message, this.data});

  factory CategoryGoodsListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CategoryGoodsListModel.fromJson(json.decode(jsonStr)) : new CategoryGoodsListModel.fromJson(jsonStr);
  
  CategoryGoodsListModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    message = jsonRes['message'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new GoodsList.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": ${code != null?'${json.encode(code)}':'null'},"message": ${message != null?'${json.encode(message)}':'null'},"data": $data}';
  }
}

class GoodsList {

  double oriPrice;
  double presentPrice;
  String goodsId;
  String goodsName;
  String image;

  GoodsList.fromParams({this.oriPrice, this.presentPrice, this.goodsId, this.goodsName, this.image});
  
  GoodsList.fromJson(jsonRes) {
    oriPrice = jsonRes['oriPrice'];
    presentPrice = jsonRes['presentPrice'];
    goodsId = jsonRes['goodsId'];
    goodsName = jsonRes['goodsName'];
    image = jsonRes['image'];
  }

  @override
  String toString() {
    return '{"oriPrice": $oriPrice,"presentPrice": $presentPrice,"goodsId": ${goodsId != null?'${json.encode(goodsId)}':'null'},"goodsName": ${goodsName != null?'${json.encode(goodsName)}':'null'},"image": ${image != null?'${json.encode(image)}':'null'}}';
  }
}

