class BookEntity {
  BookType type;
  DateTime dateTime;
  BookEntity({
    required this.type,
    required this.dateTime,
  });
}

enum BookType {
  churrasqueira,
  salao;

  String get name {
    switch (this) {
      case BookType.churrasqueira:
        return 'Churrasqueira';
      case BookType.salao:
        return 'Salão de festas';
      default:
        return '';
    }
  }
}
