import 'package:flutter/material.dart';
import 'package:parkassist/widgets/parking_space.dart';

class ParkingLot extends StatelessWidget {
  ParkingLot({required this.row, required this.column});

  final int row;
  final int column;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(row, (rowIndex) {
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(column, (columnIndex) {
              return Row(children: [
                ParkingSpace(rowIndex, columnIndex),
                SizedBox(
                  width: 10,
                )
              ]);
            }),
          ),
          SizedBox(
            height: 10,
          )
        ]);
      }),
    );
  }
}
