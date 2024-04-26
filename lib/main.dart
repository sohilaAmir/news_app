
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/news_layout.dart';

import 'modules/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();// تتاكد ان الفانكنشن اللي هي كانت await تتنفذ الاول وبعد كده يعمل الباقي
  DioHelper.init();
  await CacheHelper.init();
  bool? darkMode = CacheHelper.getData(key: 'darkMode');
  bool? onBoarding =CacheHelper.getData(key: 'onBoarding');
  String? token =CacheHelper.getData(key: 'token');
  Widget widget ;

  // جزء ده انا بشوف انا في انهي مرحله في الابليكشن
  if(onBoarding !=null){
    // 3shan ashof ana 3mlt login aw shoft al onboarding abl keda wla la
    if(token !=null ) { // انا عديت من ال لوج ان مره خلاص
      widget = NewsLayout();
    }else{
      widget = SplashScreen();
    }

  }else{
    // ana lesa fe al awll asln
    widget = SplashScreen();

  }


  runApp  (MyApp( darkMode?? false,onBoarding??false,widget ) );
}

class MyApp extends StatelessWidget {

  final bool darkMode;
  final bool onBoarding;
  final Widget startWidget;
  MyApp(this.darkMode,this.onBoarding,this.startWidget);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changThemeMode(
          fromShared: darkMode,
        ),),
        BlocProvider( create: (context) => NewsCubit()..getBusiness()),

      ],

      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            themeMode: AppCubit.get(context).darkMode? ThemeMode.dark:ThemeMode.light,
            theme: lightTheme,

            darkTheme: darkTheme,


            debugShowCheckedModeBanner: false,
            home:startWidget,
          );
        },
      ),
    );
  }


}

class ShopCubit {
}

