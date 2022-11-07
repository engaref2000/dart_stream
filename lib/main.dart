import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

//this function will generate stream of 3 interger 1, 2, 3 in each secound
Stream<int> getNumbers() async* {
  for (int i = 1; i <= 10; i++) {
    yield i;

    await Future.delayed(const Duration(seconds: 1));
  }
}

Stream<int> getNumbersException() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
    if (i == 2) {
      throw Exception('the number equal 2 ');
    }
  }
}

void listen() {
  getNumbers().listen(print);
}

// this function will sum all item in stream and print the resualt when don .
void sumStream() {
  int sum = 0;
  getNumbers().listen((data) => sum += data).onDone(() =>
      // print(data);
      print(sum));
}

//this function is listen for stream and print the error when ocure and this will stop run the stream
void listenWithException() {
  getNumbersException()
      .listen((data) => print(data))
      .onError((error) => print(error));
}

//this another way to listen for stream and print the sum of all item .
void awaitFor() async {
  int sum = 0;
  await for (int val in getNumbers()) {
    sum += val;
  }
  print(sum);
}

//check the stream if is empty , when the frist data yield in stream the isempty become false .
void isEmpty() async {
  if (await getNumbers().isEmpty) {
    print('stream is empty');
  } else {
    print('stream is Not empty');
  }
}

//return the first item in stream and generate error if the stream is empty .
void first() async {
  print(await getNumbers().first);
}

//return the last item in stream and generate error if the stream is empty .
void last() async {
  print(await getNumbers().last);
}

void length() async {
  print(await getNumbers().length);
}

// return 1 if the stream has only on value ;
// and throght error else .
void single() async {
  print(await getNumbers().single);
}

//check element in stream if any value meet then condition
// no error if the the condition is not meet ;
void any() async {
  if (await getNumbers().any((element) => element > 10)) {
    print('there is   number greater than  1 ');
  } else {
    print('there is not  number greater than 1 ');
  }
}
//contains retrun true if the stream produce the same element
//the defrent with any is that in any you can pass condition than meet the element

void contains() async {
  if (await getNumbers().contains(4)) {
    print('the stream is contains 4 ');
  } else {
    print('the stream is  not contains 4 ');
  }
}

//the elementAt is the same elementAt for iterable after the stream is finishing . the stream is 0 base , and give the  Index out of range: if the index is not in stream.
void elementAt() async {
  print(await getNumbers().elementAt(2));
}

// the same of any but here is looking for positon of element and givr Bad state: No element if all element not meet the condition
void firstWhere() async {
  print(await getNumbers().firstWhere((element) => element > 12));
}

void lastWhere() async {
  print(await getNumbers().lastWhere((element) => element >= 2));
}

//join all element in stream and return a string contain all elelment
void join() async {
  print(await getNumbers().join(', '));
}

//return the element if it is unique and meet the condition  and throuw Error: Bad state: Too many elements if multi element meet the condition, and if no element meet the conditon this to give a Error: Bad state: No element
void singleWhere() async {
  print(await getNumbers().singleWhere((element) => element >= 12));
}

//the expand will emit the element with anther data
void expanded() {
  getNumbers().expand((element) => [element, element * 10]).listen(print);
}

void map() {
  getNumbers().map((event) {
    if (event % 2 == 0) {
      return event * 2;
    } else {
      return event - 1;
    }
  }).listen(print);
}

//this will skip the first 2 element
void skip() {
  getNumbers().skip(2).listen(print);
}

// skip first item meet the condition after than all the item will apear .
void skipWhile() {
  getNumbers().skipWhile((element) => element % 5 != 0).listen(print);

/*this is output the function 
5
6
7
8
9
10
*/
}

//take will handel the count of item in stream
void take() {
  getNumbers().take(2).listen((event) {
    print(event);
  });
}

Stream<int> getdata() async* {
  yield 2;
  yield 4;
  yield 6;
  yield 3;
  yield 2;
}

Stream<int> getNumberDuplicates() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
    yield i;
    await Future.delayed(const Duration(seconds: 2));
  }
}

//take the first item that meet the condition and stop
void takeWhile() {
  getdata().takeWhile((element) => element % 2 == 0).listen(print);
}

// emit all item that meet the condition
void where() {
  getNumbers().where((event) => event % 2 != 0).listen((event) {
    print(event);
  });
}

//return the distinct value in stream.
void distinct() {
  getNumberDuplicates().distinct().listen((event) {
    print(event);
  });
}

// you can chaining multi function to the stream
void chaining() {
  getNumberDuplicates()
      .distinct()
      .map((event) => event * 10)
      .where((event) => event != 20)
      .listen((event) {
    print(event);
  });
}

//how we handel the error on stream not listen
void handleError() {
  getNumbersException().handleError((error) => print(error)).listen(print);
}

//generate erro Error: TimeoutException after 0:00:03.000000: No stream event if we wait the stream  3 secound wtih any event .
void timeOut() {
  getNumbers().timeout(const Duration(seconds: 3)).listen(print);
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //listen();
    //sumStream();
    //listenWithException();
    // awaitFor();
    // isEmpty();
    // first();
    // last();
    // length();
    // single();
    // any();
    // contains();
    // elementAt();
    // firstWhere();
    // lastWhere();
    // join();
    // singleWhere();
    // expanded();
    // map();
    // skip();
    // skipWhere();
    // take();
    // takeWhile();
    // where();
    // distinct();
    // chaining();
    // handleError();
    // timeOut();
    return Scaffold(
      body: Center(
          child: StreamBuilder<int>(
              stream: getNumbers(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data.toString() : 'no data yet',
                  style: const TextStyle(fontSize: 30),
                );
              })),
    );
  }
}
