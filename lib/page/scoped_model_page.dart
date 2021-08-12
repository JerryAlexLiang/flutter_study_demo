import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/scoped_counter_model.dart';
import 'package:flutter_study_demo/page/scoped_model_two_page.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelPage extends StatefulWidget {
  ScopedModelPage({Key key}) : super(key: key);

  @override
  _ScopedModelPageState createState() {
    return _ScopedModelPageState();
  }
}

class _ScopedModelPageState extends State<ScopedModelPage> {
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
    //方式2：CounterModel.of,本质是：ScopedModel.of<CounterModel>(context);
    // int _counterModel = ScopedCounterModel.of(context).counter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped Model'),
        primary: true,
      ),
      body: Column(
        children: [
          //方式一：ScopedModelDescendant来获取绑定属性值
          ScopedModelDescendant<ScopedCounterModel>(
              builder: (context, child, model) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '${model.counter}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }),
          // //方式2：CounterModel.of,本质是：ScopedModel.of<CounterModel>(context);
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Text(
          //     '${ScopedCounterModel.of(context).counter}',
          //     style: TextStyle(
          //       color: Colors.blue,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.run_circle),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ScopedModelTwoPage();
          }));
        },
      ),
    );
  }
}
