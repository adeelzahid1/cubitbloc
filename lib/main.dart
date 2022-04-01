import 'package:cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Cubit',
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget build');
    CounterCubit _cubit = context.read<CounterCubit>();
    CounterCubit _cubit2 = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Cubit')),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {

          state.isIncrement ? {
            ScaffoldMessenger.of(context).clearSnackBars(),
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Increment Click'), duration: Duration(milliseconds: 400)))
          }
              : {
            ScaffoldMessenger.of(context).clearSnackBars(),
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Decrement Click'), duration: Duration(milliseconds: 400)))
          };
  },
  child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have Push the Button ',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 30.0),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return state.counterValue < 0
                    ? Text('Minus Value : ${state.counterValue}',
                    style: const TextStyle(color: Colors.red, fontSize: 28.0))
                    : state.counterValue <6 && state.counterValue>=0 ? Text(' Positive Val: ${state.counterValue}',
                    style: const TextStyle(color: Colors.orange, fontSize: 28.0))
                    :  Text(' Awesome: ${state.counterValue}',
                    style: const TextStyle(color: Colors.green, fontSize: 28.0));
              },
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _cubit.increment,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 15.0),
                FloatingActionButton(
                  onPressed: _cubit2.decrement,
                  child: const Icon(Icons.remove),
                )
              ],
            ),
          ],
        ),
      ),
),
    );
  }
}
