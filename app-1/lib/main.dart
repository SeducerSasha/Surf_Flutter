// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/data.dart';
import 'package:surf_flutter_courses_template/model.dart';

/// Константа цвета.
const colorGreen = Color(0xFF67CD00);

/// Перечисление вариантов сортировки.
enum SortingOptions { none, nameAZ, nameZA, priceAsc, priceDesc }

void main() {
  runApp(const CheckApp());
}

class CheckApp extends StatelessWidget {
  const CheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Check(),
    );
  }
}

/// Экран чека.
class Check extends StatelessWidget {
  const Check({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.chevron_left,
          color: colorGreen,
        ),
        centerTitle: true,
        title: const HeaderCheck(),
      ),
      body: const BodyCheck(),
      bottomNavigationBar: const NavigationBar(),
    );
  }
}

/// Заголовок чека.
class HeaderCheck extends StatelessWidget {
  const HeaderCheck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final String dateTimeCheck =
        '${today.day.toString().padLeft(2, '0')}.${today.month.toString().padLeft(2, '0')}.${today.year.toString()} в ${today.hour.toString()}:${today.minute.toString()}';

    return Column(
      children: [
        const Text(
          'Чек № 56',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(
          dateTimeCheck,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

/// Панель навигации.
class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.article_outlined,
            ),
            label: 'Каталог'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined), label: 'Корзина'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Личное'),
      ],
      currentIndex: 3,
      selectedItemColor: colorGreen,
      unselectedItemColor: const Color(0xFF60607B),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle:
          const TextStyle(fontSize: 10, color: Color(0xFF60607B)),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (value) {},
    );
  }
}

/// Тело чека.
class BodyCheck extends StatefulWidget {
  const BodyCheck({
    super.key,
  });

  @override
  State<BodyCheck> createState() => _BodyCheckState();
}

/// Изначально установлен режим "Без сортировки".
SortingOptions? sorting = SortingOptions.none;

class _BodyCheckState extends State<BodyCheck> {
  @override
  Widget build(BuildContext context) {
    /// Функция вызова обработки сортировки и перерисовки экрана.
    void changeSorting(final SortingOptions newSorting) {
      /// Обрабатывать будем только если режим изменился.
      if (sorting != newSorting) {
        setState(() {
          /// Сортируем список.
          sortData(newSorting);
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          /// Кнопка вызова сортировки списка.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Список покупок',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF252849)),
              ),
              GestureDetector(
                /// После нажатия кнопки будем ожидать закрытия модального окна, чтобы
                /// сменить режим сортировки и перерисовать экран.
                onTap: () async {
                  sorting = await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24))),
                    builder: (context) {
                      return const SotringBottomSheet();
                    },
                  );

                  changeSorting(sorting ?? SortingOptions.none);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF1F1F1)),
                  child: Stack(alignment: Alignment.center, children: [
                    const Icon(Icons.sort),

                    /// Если сортировка установлена - выводим признак на кнопке.
                    sorting == SortingOptions.none
                        ? const SizedBox.shrink()
                        : const Align(
                            alignment: Alignment.bottomRight,
                            child: Badge(
                              backgroundColor: colorGreen,
                              smallSize: 8,
                            ),
                          ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          /// Список продуктов чека.
          const ListViewBody(),

          /// Подвал чека с итогами.
          const FooterBody(),
        ],
      ),
    );
  }
}

/// Модально окно со списком сортивовок.
class SotringBottomSheet extends StatefulWidget {
  const SotringBottomSheet({super.key});

  @override
  State<SotringBottomSheet> createState() => _SotringBottomSheetState();
}

SortingOptions sortingBottomSheet = SortingOptions.none;

class _SotringBottomSheetState extends State<SotringBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Сортировка',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.close))
              ],
            ),
            RadioListTile(
              title: const Text('Без сортировки'),
              value: SortingOptions.none,
              groupValue: sortingBottomSheet,
              onChanged: (SortingOptions? value) {
                setState(
                  () {
                    sortingBottomSheet = value!;
                  },
                );
              },
            ),
            const Divider(),
            const Text('По имени'),
            RadioListTile(
              title: const Text('По имени от А до Я'),
              activeColor: colorGreen,
              value: SortingOptions.nameAZ,
              groupValue: sortingBottomSheet,
              onChanged: (SortingOptions? value) {
                setState(
                  () {
                    sortingBottomSheet = value!;
                  },
                );
              },
            ),
            RadioListTile(
              title: const Text('По имени от Я до А'),
              activeColor: colorGreen,
              value: SortingOptions.nameZA,
              groupValue: sortingBottomSheet,
              onChanged: (SortingOptions? value) {
                setState(
                  () {
                    sortingBottomSheet = value!;
                  },
                );
              },
            ),
            const Divider(),
            const Text('По цене'),
            RadioListTile(
              title: const Text('По возрастанию'),
              activeColor: colorGreen,
              value: SortingOptions.priceAsc,
              groupValue: sortingBottomSheet,
              onChanged: (SortingOptions? value) {
                setState(
                  () {
                    sortingBottomSheet = value!;
                  },
                );
              },
            ),
            RadioListTile(
              title: const Text('По убыванию'),
              activeColor: colorGreen,
              value: SortingOptions.priceDesc,
              groupValue: sortingBottomSheet,
              onChanged: (SortingOptions? value) {
                setState(
                  () {
                    sortingBottomSheet = value!;
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(sortingBottomSheet);
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(colorGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: colorGreen)))),
              child: const Text('Готово'),
            )
          ],
        ),
      ),
    );
  }
}

/// Подвал чека с итогами.
class FooterBody extends StatelessWidget {
  const FooterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text(
              'В вашей покупке',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${listData.length.toString()} товаров',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              amountCheckWithoutSale(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Скидка ${percentSale()}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Text(
              amountSale(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Итого',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              amountCheck(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

/// Вывод списка продуктов.
class ListViewBody extends StatefulWidget {
  const ListViewBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewBody> createState() => _ListViewBodyState();
}

class _ListViewBodyState extends State<ListViewBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) => ProductItem(
          product: listData[index],
        ),
      ),
    );
  }
}

/// Вывод информации о конкретном продукте.
class ProductItem extends StatelessWidget {
  final ProductEntity product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.amber,
            ),
            child: const SizedBox(
              width: 68,
              height: 68,
            ),
            // child: Image.network(
            //   width: 68,
            //   height: 68,
            //   product.imageUrl,
            //   fit: BoxFit.contain,
            // ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.amount}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: [
                        Text(product.priceWithoutSaleToString(),
                            style: const TextStyle(
                              color: Color(0xFFB5B5B5),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          product.priceToString(),
                          style: TextStyle(
                              color: product.sale != 0
                                  ? const Color(0xFFFF0000)
                                  : Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
