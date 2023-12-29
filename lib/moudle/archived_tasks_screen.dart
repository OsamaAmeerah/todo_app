import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/default_component.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context,state) {
        var tasks = AppCubit.get(context).archivedtasks;

        return ConditionalBuilder(
          builder: (context) => ListView.separated(

              itemBuilder: (context , index) {

                return buildTaskItem(tasks[index] , context);
              },

              separatorBuilder: (context , index) =>Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],

                ),
              ),

              itemCount: tasks.length),
          condition: tasks.isNotEmpty,
          fallback: (context){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add ,
                    color: Colors.grey,
                    size: 100.0,

                  ),
                  Text('No Archived Tasks Yet, Add Some !',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.1,

                    ),

                  ),



                ],


              ),
            );


          },
        );
      },
      listener: (context,state){},
    );
  }
}
