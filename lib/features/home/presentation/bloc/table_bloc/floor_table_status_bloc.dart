import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/home/data/floor_tables.dart';


class FloorTableStatus extends Cubit<List<FloorTable>>{
  List<FloorTable> floorTables;
  FloorTableStatus({required this.floorTables}):super([]);

  void setFloor_tables(List<FloorTable> floor_tables){
    floorTables = floor_tables;
    emit(floorTables);
  }

  void markFloorTableStatus(int index,TableStatus tableStatus,String floor){
    floorTables.firstWhere((element) => element.id==index).status = tableStatus as String?;
    List<FloorTable> floorWiseTables = floorTables.where((element) => element.floor==floor).toList();
    emit(floorWiseTables);
  }

  void selectTable(int index,String floor){
    floorTables.firstWhere((element) => element.id==index).isSelected =!floorTables.firstWhere((element) => element.id==index).isSelected;
    for(int i=0;i<floorTables.length;i++){
      if(floorTables[i].id!=index)
        {
          floorTables[i].isSelected =false;
        }
    }
    List<FloorTable> floorWiseTables = floorTables.where((element) => element.floor==floor).toList();
    emit(floorWiseTables);
  }
  
  void loadSpecificFloorTables(String floor){
    List<FloorTable> floorWiseTables=floorTables.where((element) => element.floor==floor).toList();
    emit(floorWiseTables);
  }


}
