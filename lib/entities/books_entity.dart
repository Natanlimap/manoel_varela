class BookEntity {
  BookType type;
  DateTime dateTime;
  String uuid;
  String name;
  String bookId;
  BookEntity({
    required this.type,
    required this.dateTime,
    required this.uuid,
    required this.name,
    this.bookId = '',
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

  static BookType fromString(String value) {
    switch (value) {
      case 'Churrasqueira':
        return BookType.churrasqueira;
      case 'Salão de festas':
        return BookType.salao;
      default:
        return BookType.churrasqueira;
    }
  }
}
