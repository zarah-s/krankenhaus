class QRModel {
  Map transaction;
  List products;
  QRModel.fromJson(Map<String, dynamic> json)
      : transaction = json['transaction'],
        products = json['products'];
}
