class BookMapModel{
  late final String mapName;
  late final String description;
  late final String keyword;
  late final String makerName;
  late final String makerEmail;
  final String img;
  final int sort;

  BookMapModel({
    required this.mapName,
    required this.img,
    required this.makerName,
    required this.makerEmail,
    required this.sort,
    this.description = "",
    this.keyword = ""
});
}