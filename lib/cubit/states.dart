abstract class AppStates{}

class AppInitialState extends AppStates {}

class BottomNavBarChangeState extends AppStates{}

class AppTitleChange extends AppStates{}

//DataBase States.
class AppCreatDataBaseState extends AppStates{}
class AppDeleteDataBaseState extends AppStates{}
class AppUpdateDataBaseState extends AppStates{}
class AppInsertDataBaseState extends AppStates{}
class AppGetDataFromDataBaseState extends AppStates{}
class AppGetDataBaseLoadingState extends AppStates{}

//Bottom Sheet :
class BottomSheetChangeState extends AppStates{}