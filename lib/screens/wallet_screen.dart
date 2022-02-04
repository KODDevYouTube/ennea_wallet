import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "\$400",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal
          ),
        ),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 150,
                      color: Theme.of(context).dialogBackgroundColor,
                    )
                  ])
              )
            ];
          },
          body: Container(
            color: Theme.of(context).dialogBackgroundColor,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index){
                    return Text("$index");
                    //return Text('Item $index');
                  },
                ),
              ),
            ),
          )
      ),
    );
  }
}
