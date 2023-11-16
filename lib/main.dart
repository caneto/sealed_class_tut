import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_class_tut/home_page_cubit.dart';
import 'package:sealed_class_tut/ui_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sealed Class Tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sealed Class Tutorial'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    RandomNumbers? nums;
    return BlocProvider<HomePageCubit>(
      create: (context) => HomePageCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<HomePageCubit, UIState>(
                builder: (context, state) {
                  if (state is SuccessState<RandomNumbers>) {
                    nums = state.data;
                  }
                  return Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: const BorderSide(width: 1, color: Colors.blueGrey),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          context.read<HomePageCubit>().randomDivision();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left:15, right: 15),
                          child: Text(
                            'Divide',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      nums != null
                          ? Text(
                              'Division of ${nums?.num1} by ${nums?.num2} is: ',
                              style: const TextStyle(fontSize: 20),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<HomePageCubit, UIState>(
                builder: (context, state) {
                  return switch (state) {
                    InitialState() => const SizedBox.shrink(),
                    LoadingState() => const CircularProgressIndicator(),
                    SuccessState<double>() => Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.data.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ErrorState() => Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(state.message),
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
