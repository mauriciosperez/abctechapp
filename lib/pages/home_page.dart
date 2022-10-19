import 'package:abctechapp/controller/assist_controller.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AssistController> {
  const HomePage({super.key});

  Widget renderAssist(List<Assist> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: ((context, index) => ListTile(
              title: Text(list[index].name),
              selectedColor: Colors.red,
              selected: controller.isSelected(index),
              onTap: () => controller.selectAssist(index),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de serviços')),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: const [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Os serviços disponíveis são:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )))
                ],
              ),
              controller.obx((state) => renderAssist(state ?? []),
                  onEmpty: const Text('Nenhuma assistência disponível'),
                  onError: (error) => Text(error.toString())),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.finishSelectAssist,
          child: const Icon(Icons.done)),
    );
  }
}
