import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:posting_sample_app/app/helper/base_url.dart';
import 'package:posting_sample_app/app/helper/standard_response.dart';
import 'package:posting_sample_app/app/model/list_of_post.dart';

class PostService {
  final _dio = Dio();

  Future<StandardResponse<List<ItemOfPost>>> getListOfPost() async {
    try {
      final response = await _dio.get('$baseURL/posts');
      if (response.statusCode == 200) {
        debugPrint('getListOfPost is success');
        return StandardResponse<List<ItemOfPost>>(
            isSuccess: true,
            message: response.statusMessage,
            data: listOfPostFromJson(jsonEncode(response.data)));
      } else {
         debugPrint('getListOfPost is failed because ${response.statusMessage}');
          return StandardResponse<List<ItemOfPost>>(
            isSuccess: false,
            message: response.statusMessage,
            data: []
            );
      }
    } catch (e) {
       debugPrint('getListOfPost is error because $e');
      return StandardResponse<List<ItemOfPost>>(
          isSuccess: false, message: e.toString(), data: null);
    }
  }

  Future<StandardResponse<ItemOfPost>> getDetailOfPost(
      {required int id}) async {
    try {
      final response = await _dio.get('$baseURL/posts/$id');
       if (response.statusCode == 200){
        debugPrint('getListOfPost is success');
          return StandardResponse<ItemOfPost>(
          isSuccess: true,
          message: response.statusMessage,
          data: ItemOfPost.fromJson(response.data));
       }else{
         debugPrint('getListOfPost is failed because: ${response.statusMessage}');
          return StandardResponse<ItemOfPost>(
          isSuccess: false,
          message: response.statusMessage,
          data: null
          );
       }
    
    } catch (e) {
       debugPrint('getListOfPost is error because: $e');
      return StandardResponse<ItemOfPost>(
          isSuccess: false, message: e.toString(), data: null);
    }
  }
}
