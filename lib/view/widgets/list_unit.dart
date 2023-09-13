import 'package:barcode_scanner/features/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUnit extends StatelessWidget {
  final String title;
  final Bloc bloc;

  const ListUnit({super.key, required this.bloc, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(title),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    bloc.add(HomeListUnitEditPressedEvent());
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    bloc.add(
                        HomeListUnitRemovePressedEvent(scannedString: title));
                  },
                  icon: const Icon(Icons.remove)),
            ],
          )
        ],
      ),
    );
  }
}
