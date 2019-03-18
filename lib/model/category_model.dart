import 'dart:convert' show json;

class CategoryModel {

  String code;
  String message;
  List<Category> data;

  CategoryModel.fromParams({this.code, this.message, this.data});

  factory CategoryModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CategoryModel.fromJson(json.decode(jsonStr)) : new CategoryModel.fromJson(jsonStr);
  
  CategoryModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    message = jsonRes['message'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new Category.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": ${code != null?'${json.encode(code)}':'null'},"message": ${message != null?'${json.encode(message)}':'null'},"data": $data}';
  }
}

class Category {

  String comments;
  String image;
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;

  Category.fromParams({this.comments, this.image, this.mallCategoryId, this.mallCategoryName, this.bxMallSubDto});
  
  Category.fromJson(jsonRes) {
    comments = jsonRes['comments'];
    image = jsonRes['image'];
    mallCategoryId = jsonRes['mallCategoryId'];
    mallCategoryName = jsonRes['mallCategoryName'];
    bxMallSubDto = jsonRes['bxMallSubDto'] == null ? null : [];

    for (var bxMallSubDtoItem in bxMallSubDto == null ? [] : jsonRes['bxMallSubDto']){
            bxMallSubDto.add(bxMallSubDtoItem == null ? null : new BxMallSubDto.fromJson(bxMallSubDtoItem));
    }
  }

  @override
  String toString() {
    return '{"comments": ${comments != null?'${json.encode(comments)}':'null'},"image": ${image != null?'${json.encode(image)}':'null'},"mallCategoryId": ${mallCategoryId != null?'${json.encode(mallCategoryId)}':'null'},"mallCategoryName": ${mallCategoryName != null?'${json.encode(mallCategoryName)}':'null'},"bxMallSubDto": $bxMallSubDto}';
  }
}

class BxMallSubDto {

  String comments;
  String mallCategoryId;
  String mallSubId;
  String mallSubName;

  BxMallSubDto.fromParams({this.comments, this.mallCategoryId, this.mallSubId, this.mallSubName});
  
  BxMallSubDto.fromJson(jsonRes) {
    comments = jsonRes['comments'];
    mallCategoryId = jsonRes['mallCategoryId'];
    mallSubId = jsonRes['mallSubId'];
    mallSubName = jsonRes['mallSubName'];
  }

  @override
  String toString() {
    return '{"comments": ${comments != null?'${json.encode(comments)}':'null'},"mallCategoryId": ${mallCategoryId != null?'${json.encode(mallCategoryId)}':'null'},"mallSubId": ${mallSubId != null?'${json.encode(mallSubId)}':'null'},"mallSubName": ${mallSubName != null?'${json.encode(mallSubName)}':'null'}}';
  }
}

