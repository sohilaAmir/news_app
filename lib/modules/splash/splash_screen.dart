import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../../shared/component/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../layout/news_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).splashDetials;
        var index =NewsCubit.get(context).splashIndex;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            backgroundColor: Colors.white,
            leading:index!=0?IconButton
              (onPressed: (){
              NewsCubit.get(context).changesplashIndex( index-2);
            },
                icon:Icon(Icons.arrow_back_outlined),
            color: Colors.grey[600],) :null ,
          ),
          body:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image(
                image: NetworkImage(list[index]['imageUrl']),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${list[index]['title']}',
                  style:TextStyle(
                      fontSize: 27,
                       color: Colors.black,
                  fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 40),
                  height: 100,
                  child: Text(
                    '${list[index]['discription']}',
                    style:TextStyle(
                        fontSize: 15,
                        color: Colors.grey,

                        ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                 color: Colors.orange,
                    minWidth: 190,
                    height: 45,

                    onPressed: (){
                   if(list.length-1==index){
                     navigateAndFinish(context,NewsLayout());
                   }else{
                     NewsCubit.get(context).changesplashIndex( index);
                   }

                    },
                    child:
                    Container(
                      child: Text(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                          '${list[index]['buttonText']}',

                      ),
                    ))





              ],
            ),
          ),


        );
      },
    );
  }
}
