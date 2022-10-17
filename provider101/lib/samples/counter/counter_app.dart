import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/counter/counter_provider.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Counter Value is"),
          Consumer<CounterProvider>(builder: (context, counterProvider, child) {
            return Text(
              counterProvider.count.toString(),
              textScaleFactor: 3.0,
            );
          }),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Provider.of<CounterProvider>(context, listen: false).decrement();
                  },
                  child: const Icon(Icons.exposure_minus_1)),
              TextButton(
                  onPressed: () {
                    Provider.of<CounterProvider>(context, listen: false).reset();
                  },
                  child: const Icon(Icons.refresh)),
              TextButton(
                  onPressed: () {
                    Provider.of<CounterProvider>(context, listen: false).increment();
                  },
                  child: const Icon(Icons.exposure_plus_1))
            ],
          )
        ],
      ),
    );
  }
}
