import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/list_of_post_controller.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/model/list_of_post.dart';
import 'package:posting_sample_app/app/ui/detail_of_post_page.dart';

class ListOfPostPage extends StatelessWidget {
  static const routeName = '/list-of-post--page';
  const ListOfPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ListOfPostController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('List Of Post Page'),
              actions: [
                GestureDetector(
                  onTap: () {
                    controller.showLogoutAppBottomSheet(context);
                  },
                  child: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  SearchFormBuilder(controller: controller),
                  Expanded(
                    child: ListOfPostBuilder(
                        controller: controller, list: controller.listOfData),
                  ),
                ],
              )
            ),
          );
        });
  }
}

class SearchFormBuilder extends StatelessWidget {
  final ListOfPostController controller;
  const SearchFormBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller.keywordCtrl,
        decoration: const InputDecoration(
            hintText: 'Enter Keyword',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.search)),
     
      ),
    );
  }
}

class ListOfPostBuilder extends StatelessWidget {
  final ListOfPostController controller;
  final List<ItemOfPost> list;

  const ListOfPostBuilder(
      {super.key, required this.controller, required this.list});

  @override
  Widget build(BuildContext context) {
    if (controller.state == RequestState.IS_LOADING) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.blueAccent));
    } else if (controller.state == RequestState.IS_ERROR) {
      return Center(
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () => controller.getListOfPostProcess(),
              child: const Text(
                'Reload',
                style: TextStyle(color: Colors.white),
              )));
    } else if (controller.state == RequestState.IS_SUCCESS) {
      if (list.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () => controller.getListOfPostProcess(),
          child: ListView.builder(
              itemCount: list.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) =>
                  ItemOfPostBuilder(item: list[index])),
        );
      } else {
        return Center(
            child: GestureDetector(
                onTap: () => controller.getListOfPostProcess(),
                child: const Text(
                  'Data is Empty\n(Pleae Tap To Reload)',
                  textAlign: TextAlign.center,
                )));
      }
    }

    return Container();
  }
}

class ItemOfPostBuilder extends StatelessWidget {
  final ItemOfPost item;
  const ItemOfPostBuilder({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Get.toNamed(DetailOfPostPage.routeName,
            arguments: {'postId': item.id}),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          // margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${item.title ?? '-'}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Body: ${item.body ?? '-'}',
                      overflow: TextOverflow.ellipsis, maxLines: 2)
                ],
              )),
              const SizedBox(
                width: 50,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
