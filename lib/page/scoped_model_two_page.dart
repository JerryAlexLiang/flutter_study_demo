import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/scoped_counter_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelTwoPage extends StatefulWidget {
  ScopedModelTwoPage({Key key}) : super(key: key);

  @override
  _ScopedModelTwoPageState createState() {
    return _ScopedModelTwoPageState();
  }
}

class _ScopedModelTwoPageState extends State<ScopedModelTwoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //方式2：实例化获取数据 CounterModel.of,本质是：ScopedModel.of<CounterModel>(context);
    // int _counterModel = ScopedCounterModel.of(context).counter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped Model2'),
        primary: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ScopedModelDescendant<ScopedCounterModel>(
                builder: (context, child, model) {
              return Text(
                '${model.counter}',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 22,
                ),
              );
            }),
          ),
          ScopedModelDescendant<ScopedCounterModel>(
              builder: (context, child, model) {
            return Container(
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.red,
                child: Text('方式1：increase'),
                onPressed: () {
                  model.incrementCounter();
                },
              ),
            );
          }),
          // Container(
          //   margin: EdgeInsets.all(10),
          //   child: Text('${ScopedCounterModel.of(context).counter}'),
          // ),
          // Container(
          //   margin: EdgeInsets.all(10),
          //   child: MaterialButton(
          //     textColor: Colors.white,
          //     color: Colors.blue,
          //     child: Text('方式2：increase'),
          //     onPressed: () {
          //       ScopedCounterModel.of(context).incrementCounter();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
