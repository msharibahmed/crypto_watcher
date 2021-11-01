class WatcherModel {
  String id;
  String cryptoId;
  String name;
  String priceUsd;
  bool isIncreasing;
  WatcherModel(
      {required this.id,
      required this.cryptoId,
      required this.name,
      this.isIncreasing = true,
      required this.priceUsd});
}
