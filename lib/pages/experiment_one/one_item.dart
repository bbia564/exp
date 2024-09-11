import 'package:experiment/db_experiment/experiment_entity.dart';
import 'package:experiment/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class OneItem extends StatelessWidget {
  const OneItem(this.typeEntity, {this.onRefresh, Key? key}) : super(key: key);

  final ExperimentTypeEntity typeEntity;
  final VoidCallback? onRefresh;

  Widget _item(int index) {
    final entity = typeEntity.list?[index];
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              entity!.imageData,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: <Widget>[
            <Widget>[
              Flexible(
                child: Text(
                  entity.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Text(
                  entity.success == 0 ? 'Failed' : 'Success',
                  style: TextStyle(
                      color: entity.success == 0
                          ? Colors.grey
                          : const Color(0xff0fb916)),
                ),
              ).decorated(
                  color: entity.success == 0
                      ? Colors.white
                      : const Color(0xffe3ffe3),
                  borderRadius: BorderRadius.circular(4))
            ].toRow(),
            Text(
              'Experiment time：${entity.timeString}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 20,
            color: Colors.grey,
          )
        ].toRow(),
      )
          .decorated(color: bgColor, borderRadius: BorderRadius.circular(10))
          .marginOnly(bottom: 10),
      onTap: () {
        Get.toNamed('/experimentDetails',arguments: entity)?.then((value) {
          onRefresh?.call();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: <Widget>[
        <Widget>[
          Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            child: const Text(
              '#',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(5)),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            typeEntity.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ))
        ].toRow(),
        const SizedBox(
          height: 10,
        ),
        typeEntity.list?.isEmpty ?? true
            ? Container(
                width: double.infinity,
                height: 125,
                child: <Widget>[
                  Image.asset(
                    'assets/noData.webp',
                    width: 57,
                    height: 57,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No experimental records were added',
                    style: TextStyle(fontSize: 15,color: Colors.grey),
                  ),
                ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
              ).decorated(
                color: bgColor,
                borderRadius: BorderRadius.circular(10)).marginOnly(bottom: 10)
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: typeEntity.list?.length ?? 0,
                itemBuilder: (_, index) {
                  return _item(index);
                })
      ].toColumn(),
    );
  }
}
