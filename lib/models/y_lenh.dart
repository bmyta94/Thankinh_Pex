class YLenh {
  final String id;
  final String tenBenhNhan;
  final String tuoi;
  final String gioiTinh;
  final String soGiuong;
  final String chanDoan;
  final String chiDinhLocMau;
  final String quaLoc;
  final String dichLoc;
  final String canNang;
  final String tc;
  final String inr;
  final String nguyCo;
  final String tocDoMau;
  final String dichRf;
  final String dichDf;
  final String heparinBolus;
  final String heparinDuyTri;
  final String thuoc;
  final String bacSi;
  final String dieuDuong;

  YLenh({
    required this.id,
    required this.tenBenhNhan,
    required this.tuoi,
    required this.gioiTinh,
    required this.soGiuong,
    required this.chanDoan,
    required this.chiDinhLocMau,
    required this.quaLoc,
    required this.dichLoc,
    required this.canNang,
    required this.tc,
    required this.inr,
    required this.nguyCo,
    required this.tocDoMau,
    required this.dichRf,
    required this.dichDf,
    required this.heparinBolus,
    required this.heparinDuyTri,
    required this.thuoc,
    required this.bacSi,
    required this.dieuDuong,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'tenBenhNhan': tenBenhNhan,
    'tuoi': tuoi,
    'gioiTinh': gioiTinh,
    'soGiuong': soGiuong,
    'chanDoan': chanDoan,
    'chiDinhLocMau': chiDinhLocMau,
    'quaLoc': quaLoc,
    'dichLoc': dichLoc,
    'canNang': canNang,
    'tc': tc,
    'inr': inr,
    'nguyCo': nguyCo,
    'tocDoMau': tocDoMau,
    'dichRf': dichRf,
    'dichDf': dichDf,
    'heparinBolus': heparinBolus,
    'heparinDuyTri': heparinDuyTri,
    'thuoc': thuoc,
    'bacSi': bacSi,
    'dieuDuong': dieuDuong,
  };

  factory YLenh.fromJson(Map<String, dynamic> json) => YLenh(
    id: json['id'],
    tenBenhNhan: json['tenBenhNhan'],
    tuoi: json['tuoi'],
    gioiTinh: json['gioiTinh'],
    soGiuong: json['soGiuong'],
    chanDoan: json['chanDoan'],
    chiDinhLocMau: json['chiDinhLocMau'],
    quaLoc: json['quaLoc'],
    dichLoc: json['dichLoc'],
    canNang: json['canNang'],
    tc: json['tc'],
    inr: json['inr'],
    nguyCo: json['nguyCo'],
    tocDoMau: json['tocDoMau'],
    dichRf: json['dichRf'],
    dichDf: json['dichDf'],
    heparinBolus: json['heparinBolus'],
    heparinDuyTri: json['heparinDuyTri'],
    thuoc: json['thuoc'],
    bacSi: json['bacSi'],
    dieuDuong: json['dieuDuong'],
  );
}
