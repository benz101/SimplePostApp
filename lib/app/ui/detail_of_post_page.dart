import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/detail_of_post_controller.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/model/list_of_post.dart';

class DetailOfPostPage extends StatelessWidget {
  static const routeName = '/detail-of-post--page';
  const DetailOfPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailOfPostController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Detail Of Poss Page')),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: DetailOfPostBuilder(controller: controller),
          ),
        );
      }
    );
  }
}

class DetailOfPostBuilder extends StatelessWidget {
  final DetailOfPostController controller;
  const DetailOfPostBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300],
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Builder(builder: (context) {
          if (controller.state == RequestState.IS_LOADING) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent));
          }
          if (controller.state == RequestState.IS_SUCCESS) {
            return ItemOfDetailBuilder(
                controller: controller, item: controller.detailOfData!);
          }
          if (controller.state == RequestState.IS_ERROR) {
            return Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    onPressed: () => controller.getDetailOfPostProcess(),
                    child: const Text(
                      'Reload',
                      style: TextStyle(color: Colors.white),
                    )));
          }
          return Container();
        }));
  }
}

class ItemOfDetailBuilder extends StatelessWidget {
  final DetailOfPostController controller;
  final ItemOfPost item;
  const ItemOfDetailBuilder(
      {super.key, required this.controller, required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('Title: ${item.title ?? '-'}',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(item.body??'-'),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }
}