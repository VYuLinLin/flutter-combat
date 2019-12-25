// 一个通用的InheritedWidget,保存任意需要跨组件共享的状态
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  // 共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    // 返回true，则每次更新都会调用依赖其的子孙节点的didChangeDependencies
    return true;
  }
}

/**
 * 有了保存数据的类InheritedProvider后，
 * 1、数据发生变化怎么通知？
 * 2、谁来重新构建InheritedProvider？
 */

// 该方法用于在Dart中获取模版类型
Type _typeOf<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.data, this.child});

  final Widget child;
  final T data;

  // 定义一个便捷方法，方便子树中的Widget获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
      ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
      : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget as InheritedProvider<T>;

    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners）,重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当Provider更新时，如果新旧数据不==，则解绑旧数据坚挺，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model类添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model类的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 购物车示例--------------------------------------------

class Item {
  Item(this.price, this.count);
  double price; // 商品单价
  int count; // 商品份数
}

// 购物车模型
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将item添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider,更新状态
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跨组件状态共享'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var cart = ChangeNotifierProvider.of<CartModel>(context);
                      return Text('总价：${cart.totalPrice}');
                    },
                  ),
                  Builder(
                    builder: (context) {
                      print('漂浮按钮');
                      return RaisedButton(
                        child: Text('添加商品'),
                        onPressed: () {
                          // 给购物车中添加商品，添加后总价会更新
                          ChangeNotifierProvider.of<CartModel>(context, listen: false).add(Item(20, 1));
                        },
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
