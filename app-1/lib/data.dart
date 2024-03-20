import 'package:intl/intl.dart';
import 'package:surf_flutter_courses_template/main.dart';
import 'package:surf_flutter_courses_template/model.dart';

/// Список продуктов.
///
/// Можете дополнить этот список самостоятельно, если хотите протестировать
/// приложение более объёмно.
final dataForStudents = <ProductEntity>[
  ProductEntity(
    title: 'Арбуз',
    price: 1200,
    category: Category.food,
    imageUrl:
        'https://images.unsplash.com/photo-1589984662646-e7b2e4962f18?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
    amount: Grams(1000),
    sale: 50,
  ),
  ProductEntity(
    title: 'Дыня',
    price: 1400,
    category: Category.food,
    amount: Grams(2000),
    imageUrl:
        'https://images.unsplash.com/photo-1598025362874-49480e049c76?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bWVsb258ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
  ),
  ProductEntity(
    title: 'Телевизор',
    price: 2100000,
    category: Category.tech,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1509281373149-e957c6296406?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1328&q=80',
  ),
  ProductEntity(
    title: 'Миксер',
    price: 250000,
    category: Category.tech,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1578643463396-0997cb5328c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWl4ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
  ),
  ProductEntity(
    title: 'Крем для загара',
    price: 90000,
    category: Category.care,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1521223344201-d169129f7b7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1335&q=80',
  ),
  ProductEntity(
    title: 'Крем защитный',
    price: 1900,
    category: Category.care,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1611080541599-8c6dbde6ed28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
  ),
  ProductEntity(
    title: 'Pebsi',
    price: 9000,
    category: Category.drinks,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1567671899076-51a64ddb7c5d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Ymx1ZSUyMGRyaW5rfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
  ),
  ProductEntity(
    title: 'Shpryte',
    price: 10200,
    category: Category.drinks,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1541807120430-f3f78c281225?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z3JlZW4lMjBkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
  ),
  ProductEntity(
    title: 'Аспирин',
    price: 15,
    amount: Quantity(1),
    category: Category.drugs,
    imageUrl:
        'https://images.unsplash.com/photo-1626716493137-b67fe9501e76?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXNwaXJpbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
  ),
  ProductEntity(
    title: 'Ибупрофен',
    price: 54,
    category: Category.drugs,
    amount: Quantity(1),
    imageUrl:
        'https://images.unsplash.com/photo-1550572017-edd951b55104?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aWJ1cHJvZmVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
  ),
];

/// Будем работать с копией данные, чтобы можно было использовать исходный список
/// для режима "Без сортировки".
var listData = List<ProductEntity>.from(dataForStudents);

/// Функция получения суммы чека с учетом скидки.
String amountCheck() {
  double amount = 0;

  for (var element in dataForStudents) {
    amount += element.priceWithSale;
  }

  return NumberFormat.currency(locale: 'ru', symbol: 'руб')
      .format(convertPennyToRuble(amount));
}

/// Функция получения суммы чека без учета скидки.
String amountCheckWithoutSale() {
  double amount = 0;

  for (var element in dataForStudents) {
    amount += element.price;
  }

  return NumberFormat.currency(locale: 'ru', symbol: 'руб')
      .format(convertPennyToRuble(amount));
}

/// Функция получения общей суммы скидки.
String amountSale() {
  double amount = 0;

  for (var element in dataForStudents) {
    if (element.sale >= 0) {
      amount += element.price * element.sale / 100;
    }
  }

  return NumberFormat.currency(locale: 'ru', symbol: 'руб')
      .format(convertPennyToRuble(-amount));
}

/// Функция вычисления общего процента скидки.
String percentSale() {
  double amount = 0;
  double sale = 0;

  for (var element in dataForStudents) {
    amount += element.price.toDouble();
    sale += element.price * element.sale / 100;
  }

  if (sale == 0) {
    return '0 %';
  }

  return '${(sale / amount * 100).toStringAsFixed(2)}%';
}

/// Функция выполняет сортировку списка или устанавливает исходные данные списка.
void sortData(final SortingOptions newSorting) {
  switch (newSorting) {
    case SortingOptions.nameAZ:
      listData.sort(
        (a, b) => a.title.compareTo(b.title),
      );
      break;
    case SortingOptions.nameZA:
      listData.sort(
        (a, b) => b.title.compareTo(a.title),
      );
      break;
    case SortingOptions.priceAsc:
      listData.sort(
        (a, b) => a.price.compareTo(b.price),
      );
      break;
    case SortingOptions.priceDesc:
      listData.sort(
        (a, b) => b.price.compareTo(a.price),
      );
      break;

    default:
      listData = List<ProductEntity>.from(dataForStudents);
  }
}
