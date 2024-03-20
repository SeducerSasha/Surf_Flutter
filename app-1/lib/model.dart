// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';

/// Модель продукта.
///
/// Содержит в себе название, цену, категорию и ссылку на изображение.
class ProductEntity {
  /// Название товара.
  final String title;

  /// Цена товара в копейках. Без скидки.
  ///
  /// Подумайте и ответьте на три вопроса:
  /// 1. Почему цена хранится в копейках, а не в рублях?
  /// 2. Почему тип данных цены - [int], а не [double]?
  /// 3. Как можно было реализовать передачу цены иначе?
  ///
  /// Ответы на вопросы разместите тут (они будут проверены при код-ревью):
  ///
  /// [ОТВЕТЫ]
  /// 1. При хранении в рублях и использовании вычислений с округлениями могут потеряться копейки.
  /// 2. Если сейчас цена в копейках, зачем тут double. Копейка - минимальная денежная единица
  /// 3. Можно было бы передавать в рублях и использовать перевод в копейки и обратно
  final int price;

  /// Категория товара.
  final Category category;

  /// Ссылка на изображение товара.
  final String imageUrl;

  /// Количество товара.
  ///
  /// Может быть описано в граммах [Grams] или в штуках [Quantity].
  final Amount amount;

  /// Скидка на товар.
  ///
  /// Требуется высчитать самостоятельно итоговую цену товара.
  final double sale;

  /// Получение цены с учетом скидки.
  double get priceWithSale {
    if (sale == 0) {
      return price.toDouble();
    }
    return price * sale / 100;
  }

  /// Вывод цены с учетом скидки.
  String priceToString() {
    return NumberFormat.currency(locale: 'ru', symbol: 'руб')
        .format(convertPennyToRuble(priceWithSale));
  }

  /// Вывод цены без учета скидки.
  String priceWithoutSaleToString() {
    if (sale == 0) {
      return '';
    }
    return NumberFormat.currency(locale: 'ru', symbol: 'руб')
        .format(convertPennyToRuble(price.toDouble()));
  }

  ProductEntity({
    required this.title,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.amount,
    this.sale = 0,
  });
}

/// Класс, описывающий количество товара.
sealed class Amount {
  int get value;
}

/// Класс, описывающий количество товара в граммах.
class Grams implements Amount {
  @override
  final int value;
  Grams(this.value);

  @override
  String toString() => '${(value / 1000).toStringAsFixed(2)} кг';
}

/// Класс, описывающий количество товара в штуках.
class Quantity implements Amount {
  @override
  final int value;
  Quantity(this.value);

  @override
  String toString() => '$value шт';
}

/// Категория товара.
enum Category {
  food('Продукты питания'),
  tech('Технологичные товары'),
  care('Уход'),
  drinks('Напитки'),
  drugs('Медикаменты');

  final String name;

  const Category(this.name);
}

/// Функция перевода копеек в рубли.
double convertPennyToRuble(final double penny) {
  return penny / 100;
}
