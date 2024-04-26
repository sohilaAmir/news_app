
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';
import '../../modules/busniess/busniess_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/sports/sports_screen.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,

      ),
      label: 'Business'

    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,

        ),
        label: 'Sports'

    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,

        ),
        label: 'Science'

    ),
    // const BottomNavigationBarItem(
    //     icon: Icon(
    //       Icons.settings,
    //     ),
    //     label: 'Setting'
    //
    // )


  ];


  void changeBottomNavBar(int index) {
    if(index==1)
      {
        getsports();
      }
    if(index==2)
      {
        getscience();
      }
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
   // const SettingScreen(),

  ];

  List<dynamic> business=[];

  void getBusiness(){
 emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'business',
          'apiKey':'0fdb76d20a93498eae413ff993b84d31'


        } ).then((value)
    {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());


    }
    ).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
    });

  }

  List<dynamic> sports=[];

  void getsports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'sports',
          'apiKey':'0fdb76d20a93498eae413ff993b84d31'


        } ).then((value)
    {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());

    }
    ).catchError((error){
      emit(NewsGetSportsErrorState(error.toString()));
    });

  }

  List<dynamic> science=[];

  void getscience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'science',
          'apiKey':'0fdb76d20a93498eae413ff993b84d31'


        } ).then((value)
    {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());

    }
    ).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
    });

  }

  List<dynamic> search=[];

  void getsearch( String value){
    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
        url: 'v2/everything',
        query:{
    //       'country':'us',
    //       'category':'science',
          'apiKey':'0fdb76d20a93498eae413ff993b84d31',
         'q':value,


        } ).then((value)
    {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());

    }
    ).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }


  int splashIndex=0;

  List splashDetials =[
    {
      'imageUrl':'https://img.freepik.com/premium-vector/news-update-online-news-newspaper_1200-532.jpg',
      'title':'welcome...!',
      'discription':'Stay informed, stay connected.',
      'buttonText':'Next'
    },
    {
      'imageUrl':'https://static.vecteezy.com/system/resources/previews/006/181/554/non_2x/e-mail-news-subscription-promotion-flat-illustration-online-news-news-update-information-about-activities-events-company-information-and-announcements-design-for-mobile-and-web-graphics-vector.jpg',
      'title':'Get breaking news',
      'discription':'Find Real-time updates on current events and Customizable news feed based on your preferences   Access to a variety of sources and perspectives',
      'buttonText':'Next'
    },
    {
      'imageUrl':'https://img.freepik.com/free-vector/user-interface-development-isometric-concept-with-young-woman-creating-custom-design-mobile-application-vector-illustration_1284-72341.jpg',
      'title':'Stay ahead of the curve ',
      'discription':'Access to a variety of sources and perspectives and never miss a beat in the fast-paced world of current events',
      'buttonText':'Explore'
    },


  ];

  void changesplashIndex(int index) {
    if (index != splashDetials.length-1)
      {
        splashIndex=index+1;
        print('$splashIndex');
        emit(NewsGetSplashScreenState());
      }else{



    }

  }

}