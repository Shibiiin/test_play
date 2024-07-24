import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5"
  ];
  final List<String> _data = [];

  final List<String> texts = [
    "First Text",
    "Second Text",
    "Third Text",
    "Fourth Text",
  ];

  @override
  void initState() {
    super.initState();
    _addItems();
  }

  void _addItems() async {
    for (int i = 0; i < _items.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _data.add(_items[i]);
      _listKey.currentState?.insertItem(_data.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Site Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView.builder(
              itemCount: texts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      texts[index],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_data[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(item),
        ),
      ),
    );
  }
}
