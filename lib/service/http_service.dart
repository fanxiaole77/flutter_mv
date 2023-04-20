import 'package:dio/dio.dart';
import 'package:flutter_mv/service/http_config.dart';

Future get(url,{Map<String,dynamic>? queryParameters})async{
  try{
    Response response;
    Dio dio = Dio();
    if(token != ""){
      dio.options.headers = {
       'Content-Type':'application/json',
        'Authorization':token
      };
    }
    response = await dio.get(url,queryParameters: queryParameters);
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception("后端异常");
    }
  }catch(e){
    print('error::${e}');
    return null;
  }
}


Future post(url,{ data, Map<String, dynamic>? queryParameters})async{
  try{
    Response response;
    Dio dio = Dio();
    response = await dio.post(url,data: data,queryParameters: queryParameters);
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception("后端异常");
    }
  }catch(e){
    print('error::${e}');
    return null;
  }
}