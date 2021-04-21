import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money/Design/mColors.dart';
import 'package:money/Widgets/TransactionPage/AddTransaction.dart';

import 'TransactionHistoryWidget.dart';

class TransactionList extends StatelessWidget {
  final CollectionReference collectionReference;

      TransactionList(this.collectionReference);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isPortrait(context)? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.width * 0.95,
      child: StreamBuilder<QuerySnapshot>(
          stream: collectionReference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return ListView(
                  children: documents
                      .map((doc) => TransactionWidget(doc, collectionReference))
                      .toList());
            } else if (snapshot.hasError) {
              return Text("Something went wrong!");
            }
            return SpinKitDoubleBounce(
              color: mColors.secondaryColor,
            );
          }),
    );
  }
  static bool isPortrait(context) {
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      return true;
    }
    return false;
  }
}
