class WatcherModel {
  String id;
  String cryptoId;
  String name;
  String priceUsd;
  int priceVariation;
  WatcherModel(
      {required this.id,
      required this.cryptoId,
      required this.name,
      this.priceVariation = 0,
      required this.priceUsd});
}
