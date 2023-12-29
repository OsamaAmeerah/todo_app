import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappagain/cubit/states.dart';
import 'package:todoappagain/moudle/new_tasks_screen.dart';
import '../moudle/archived_tasks_screen.dart';
import '../moudle/done_tasks_screen.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit(BuildContext context) : super(AppInitialState());
int currentIndex = 0;
late Database database;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];


//Bottom Sheet state :

  static AppCubit get(context) => BlocProvider.of(context);



  List<Widget>screens = [
    const NewTasksScreen(),
   const DoneTasksScreen(),
    const ArchivedTasksScreen(),


  ];


  List<String> titleChange = [
    'Tasks',
    'Done Tasks',
    'Archived Tasks',

  ];

void changeIndex(int index)
  {

    currentIndex = index;
    emit(BottomNavBarChangeState());

  }
  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.task) ,



        label: 'Tasks',),
    const BottomNavigationBarItem(
        icon: Icon(Icons.done) ,



        label: 'Done',),
    const BottomNavigationBarItem(
        icon: Icon(Icons.archive) ,



        label: 'Archived',),

    
    
    
  ];


  void creatDataBase()
  {
  openDatabase(
     'todoagain.db',
     version: 1,
     onCreate: (database , version)
        {

       print('dataBase Created');

       database.execute(

           'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'


       ).then((value) {
         print('Table Created');
         
         
       }).catchError((error){
         print('error when creating table : ${error.toString()}');
       });


       },
       onOpen: (database)
       {
         getDataFromDataBase(database);
         print('dataBase opened');

       },

  ).then((value) {
    database = value;
emit(AppCreatDataBaseState());
  });

  }
  insertToDataBase({
    required String title,
    required String date,
    required String time,


}) async
  {
   await database.transaction((txn) {

    return txn.rawInsert('INSERT INTO tasks(title, time, date, status) VALUES("$title","$date","$time","new")').then((value) {


        print('$value Inserted Successfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);

    }).catchError((error){

        print('Error When inserting new record ${error.toString()}');


      });

    });
  }

 void getDataFromDataBase(database)
  {
    newtasks = [];
    donetasks = [];
   archivedtasks = [];
    emit(AppGetDataBaseLoadingState());
     database.rawQuery('SELECT * FROM  tasks').then((value) {


     emit(AppGetDataFromDataBaseState());
     value.forEach((element) {
    if(element['status'] == 'new')
      // ignore: curly_braces_in_flow_control_structures
      newtasks.add(element);
     else if (element['status'] == 'done')
      // ignore: curly_braces_in_flow_control_structures
      donetasks.add(element);
    else
      // ignore: curly_braces_in_flow_control_structures
      archivedtasks.add(element);
   });


   });

  }


  void updateData ({
    required String status,
    required int id,


}) async
  {

   database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
   ).then((value) {
getDataFromDataBase(database);
   emit(AppUpdateDataBaseState());
   });
  }

  void deleteData ({
    required int id,


  }) async
  {

    database.rawDelete(
        'DELETE FROM tasks  WHERE id = ?',
        [id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });
  }
void changeBottomSheetState ({
    required IconData icon,
  required bool isShown

})
{
isBottomSheetShown = isShown;
fabIcon = icon;
emit(BottomSheetChangeState());
}

}

