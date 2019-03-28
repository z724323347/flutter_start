
class TestModel {
  int _pointID;
  String _image;
  int _contractId;
  int _publicationId;
  double _pointLng;
  double _pointLat;

  TestModel(this._pointID, this._image, this._contractId, this._publicationId,
      this._pointLng, this._pointLat);

  int get pointID => _pointID;

  String get image => _image;

  int get contractId => _contractId;

  int get publicationId => _publicationId;

  double get pointLng => _pointLng;

  double get pointLat => _pointLat;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['pointid'] = _pointID;
    map['image'] = _image;
    map['contractId'] = _contractId;
    map['publicationId'] = _publicationId;
    map['pointLng'] = _pointLng;
    map['pointLat'] = _pointLat;
    return map;
  }

  TestModel.fromMap(Map<String, dynamic> map) {
    this._publicationId = map['publicationId'];
    this._pointID = map['pointid'];
    this._image = map['image'];
    this._contractId = map['contractId'];
    this._pointLng = map['pointLng'];
    this._pointLat = map['pointLat'];
  }
}
