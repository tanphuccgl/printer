import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AtterndanceInfomationModel {
  String? maSinhVien;
  String? hoDem;
  String? ten;
  String? tenLop;
  AtterndanceInfomationModel({
    this.maSinhVien,
    this.hoDem,
    this.ten,
    this.tenLop,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'MaSinhVien': maSinhVien,
      'HoDem': hoDem,
      'Ten': ten,
      'TenLop': tenLop,
    };
  }

  factory AtterndanceInfomationModel.fromMap(Map<String, dynamic> map) {
    return AtterndanceInfomationModel(
      maSinhVien:
          map['MaSinhVien'] != null ? map['MaSinhVien'] as String : null,
      hoDem: map['HoDem'] != null ? map['HoDem'] as String : null,
      ten: map['Ten'] != null ? map['Ten'] as String : null,
      tenLop: map['TenLop'] != null ? map['TenLop'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtterndanceInfomationModel.fromJson(String source) =>
      AtterndanceInfomationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
