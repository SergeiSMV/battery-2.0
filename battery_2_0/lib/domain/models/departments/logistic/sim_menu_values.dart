
class FilterItems {
  static const String cellUp = 'по ячейке А↓';
  static const String cellDown = 'по ячейке Я↓';
  static const String categoryUp = 'по категории А↓';
  static const String categoryDown = 'по категории Я↓';
  static const String producerUp = 'по поставщику А↓';
  static const String producerDown = 'по поставщику Я↓';
  static const String statusUp = 'по статусу А↓';
  static const String statusDown = 'по статусу Я↓';
  static const String dateUp = 'по дате старые↓';
  static const String dateDown = 'по дате новые↓';

  static const List<String> choices = <String>[
    cellUp,
    cellDown,
    categoryUp,
    categoryDown,
    producerUp,
    producerDown,
    statusUp,
    statusDown,
    dateUp,
    dateDown
  ];
}


class PrintQrItems {
  static const String printAll = 'печать все QR';
  static const String printSelect = 'выбрать для печати';

  static const List<String> choices = <String>[
    printAll,
    printSelect,
  ];
}



class Setings {
  static const String nomenclature = 'номенклатура';
  static const String producers = 'поставщики';
  static const String colors = 'цвета';

  static const List<String> choices = <String>[
    nomenclature,
    producers,
    colors,
  ];
}


