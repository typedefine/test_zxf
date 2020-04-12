class ZXFMessageModel {
  ZXFData _data;

  ZXFMessageModel({ZXFData data}) {
    this._data = data;
  }

  ZXFData get data => _data;
  set data(ZXFData data) => _data = data;

  ZXFMessageModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new ZXFData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class ZXFData {
  List<ZXFItems> _items;
  int _count;

  Data({List<ZXFItems> items, int count}) {
    this._items = items;
    this._count = count;
  }

  List<ZXFItems> get items => _items;
  set items(List<ZXFItems> items) => _items = items;
  int get count => _count;
  set count(int count) => _count = count;

  ZXFData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      _items = new List<ZXFItems>();
      json['items'].forEach((v) {
        _items.add(new ZXFItems.fromJson(v));
      });
    }
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._items != null) {
      data['items'] = this._items.map((v) => v.toJson()).toList();
    }
    data['count'] = this._count;
    return data;
  }
}

class ZXFItems {
  String _content;
  String _id;
  int _creationTime;
  int _state;
  int _type;

  Items({String content, String id, int creationTime, int state, int type}) {
    this._content = content;
    this._id = id;
    this._creationTime = creationTime;
    this._state = state;
    this._type = type;
  }

  String get content => _content;
  set content(String content) => _content = content;
  String get id => _id;
  set id(String id) => _id = id;
  int get creationTime => _creationTime;
  set creationTime(int creationTime) => _creationTime = creationTime;
  int get state => _state;
  set state(int state) => _state = state;
  int get type => _type;
  set type(int type) => _type = type;

  ZXFItems.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _id = json['id'];
    _creationTime = json['creationTime'];
    _state = json['state'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['id'] = this._id;
    data['creationTime'] = this._creationTime;
    data['state'] = this._state;
    data['type'] = this._type;
    return data;
  }
}
