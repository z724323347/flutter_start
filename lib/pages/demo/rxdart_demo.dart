import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/rx_command_model.dart';
import 'package:flutter_pro/pages/demo/rxdart_demo_test.dart';
import 'package:rxdart/rxdart.dart';

class TestRxPage extends StatefulWidget {
  @override
  _TestRxPageState createState() => _TestRxPageState();
}

class _TestRxPageState extends State<TestRxPage> {
  String temp;
  static RxModel rxModel = new RxModel();
  String valueAsString = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('rxdart'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: rxFun_,
                child: Text('rxFun'),
              ),
              RaisedButton(
                onPressed: rxZipWith,
                child: Text('rxZipWith_(等待4秒)'),
              ),
              Text('console ： \n ${temp}'),
              //rxcommand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: rxModel.addCommand,
                    child: Text('ADD + '),
                  ),
                  StreamBuilder<int>(
                    initialData: int.parse(valueAsString),
                    stream: rxModel.counterUpdates,
                    builder: (context, snappShot) {
                      if (snappShot != null && snappShot.hasData) {
                        valueAsString = snappShot.data.toString();
                      }
                      return Text(
                        valueAsString,
                        style: Theme.of(context).textTheme.display1,
                      );
                    },
                  ),
                ],
              ),
              //redart
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: TestPage(),
              )
            ],
          ),
        ));
  }

  void rxFun_just() {
    Observable.just(0).delay(Duration(milliseconds: 2000)).listen((_) {
      print('rxFun -----');
    });
  }

  void rxFun_() {
    List list = [1, 2, 3, 4, 5];
    // List list;
    print('list  ....... ${list?.length}');
    var obs1 = Observable(Stream.fromIterable(list));
    obs1.listen((item) {
      print('立即执行1 :${DateTime.now()} : ${item}');
    });

    // var obs2 = Observable.fromFuture(new Future.value("Hello"));
    // obs2.listen(print);

    var obs3 = Observable.fromIterable(list);
    obs3.listen((item) {
      print('立即执行2 :${DateTime.now()} : ${item}');
    });

    Observable(Stream.fromIterable(list))
        .interval(new Duration(milliseconds: 1000))
          ..listen((item) {
            setState(() {
              temp = '${DateTime.now()} : ${item}';
              print('延时执行 :${DateTime.now()} : ${item}');
            });
          });

    Observable.just(1)
        .zipWith(Observable.just(5), (one, two) => one + two)
        .listen(print);
  }

  void rxZipWith() async {
    print('点击时间 :${DateTime.now()}');
    var userObservable = Observable.fromFuture(getUser())
        .map<User>((jsonString) => User.fromJson(jsonString));

    var productObservable = Observable.fromFuture(getProduct())
        .map<Product>((jsonString) => Product.fromJson(jsonString));

    Observable<Invoice> invoiceObservable =
        userObservable.zipWith<Product, Invoice>(
            productObservable, (user, product) => Invoice(user, product));

    print("Start listening for invoices - ${DateTime.now()}");
    invoiceObservable.listen((invoice) {
      print('输出时间 : ${DateTime.now()}');
      print(invoice.toString());
      setState(() {
        temp = invoice.toString();
      });
    });

    // 这段话只是为了防止stream数据操作完成时进程被杀死
    // await Future.delayed(Duration(seconds: 5));
  }

  Future<String> getProduct() async {
    print("Started getting product  ---${DateTime.now()}");
    await Future.delayed(Duration(seconds: 2));
    print("Finished getting product ---${DateTime.now()}");
    return '{"name": "Flux compensator", "price": 99999.99}';
  }

// 模拟网络返回JSON字符串
  Future<String> getUser() async {
    print("Started getting User  ----${DateTime.now()}");
    await Future.delayed(Duration(seconds: 4));
    print("Finished getting User ----${DateTime.now()}");
    return '{"name": "Jon Doe", "adress": "New York", "phoneNumber":"424242","age": 42 }';
  }
}

class Invoice {
  final User user;
  final Product product;

  Invoice(this.user, this.product);

  printInvoice() {
    print(user.toString());
    print(product.toString());
  }

  @override
  String toString() {
    return '${user.toString()} \n ${product.toString()} ';
  }
}

class Product {
  final String name;
  final double price;
  // 实际项目中，我推荐大家使用serializer插件，而不是手动写serializer
  factory Product.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return Product(jsonMap['name'], jsonMap['price']);
  }

  Product(this.name, this.price);

  @override
  String toString() {
    return '$name - $price ';
  }
}

class User {
  final String name;
  final String adress;
  final String phoneNumber;
  final int age;

  // 实际项目中，推荐大家使用serializer插件，而不是手动写serializer
  factory User.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return User(
      jsonMap['name'],
      jsonMap['adress'],
      jsonMap['phoneNumber'],
      jsonMap['age'],
    );
  }

  User(this.name, this.adress, this.phoneNumber, this.age);

  @override
  String toString() {
    return '$name - $adress - $phoneNumber - $age';
  }
}
