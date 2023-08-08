import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:business/business.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final BlockMain _blockMain;

  @override
  void initState() {
    super.initState();
    _blockMain = GetIt.I.get<BlockMain>();
    _blockMain.add(const BlockMainEvent.init());

  }

  @override
  Widget build(BuildContext context) {
    return Provider<BlockMain>(
      create: (_) => _blockMain,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    _blockMain.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlockMainState>(
      stream: context.read<BlockMain>().state,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final state = snapshot.data;

          return state!.map<Widget>(
            loading: (_) => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Initializing'),
              ),
            ),
            loaded: (state) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(
                  state.userData.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context
                    .read<BlockMain>()
                    .add(BlockMainEvent.setUser(userId: state.userData.id + 1)),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
