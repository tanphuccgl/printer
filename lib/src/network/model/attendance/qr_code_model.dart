// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QRCodeModel {
  String? linkQrcode;
  String? ngayTao;
  String? gioBatDau;
  String? gioKetThuc;

  QRCodeModel({this.linkQrcode, this.ngayTao, this.gioBatDau, this.gioKetThuc});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link_qrcode': linkQrcode,
      'ngay_tao': ngayTao,
      'gio_bat_dau': gioBatDau,
      'gio_ket_thuc': gioKetThuc,
    };
  }

  factory QRCodeModel.fromMap(Map<String, dynamic> map) {
    return QRCodeModel(
      linkQrcode:
          map['link_qrcode'] != null ? map['link_qrcode'] as String : null,
      ngayTao: map['ngay_tao'] != null ? map['ngay_tao'] as String : null,
      gioBatDau:
          map['gio_bat_dau'] != null ? map['gio_bat_dau'] as String : null,
      gioKetThuc:
          map['gio_ket_thuc'] != null ? map['gio_ket_thuc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QRCodeModel.fromJson(String source) =>
      QRCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
