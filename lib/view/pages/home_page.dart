import 'package:barcode_scanner/data/models/scanned_data.dart';
import 'package:barcode_scanner/features/blocs/home_bloc.dart';
import 'package:barcode_scanner/view/widgets/list_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeShareErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Oops, nothing to share'),
            duration: Duration(milliseconds: 900),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadSuccessState:
            final successState = state as HomeLoadSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text("Barcode scanner")),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: ScannedData.data.length,
                      itemBuilder: (context, index) {
                        return ListUnit(
                            bloc: homeBloc, title: ScannedData.data[index]);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: MaterialButton(
                        onPressed: () {
                          homeBloc.add(HomeBarcodeScannerPressedEvent());
                        },
                        child: const Text('Scan'),
                      )),
                      Expanded(
                          child: MaterialButton(
                        onPressed: () {
                          homeBloc.add(HomeSharePressedEvent());
                        },
                        child: const Text('Share'),
                      )),
                    ],
                  ),
                ],
              ),
            );
          default:
            return const Placeholder();
        }
      },
    );
  }
}
