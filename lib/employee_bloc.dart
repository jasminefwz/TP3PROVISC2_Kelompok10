import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3provis/api_service.dart';
import 'package:tp3provis/item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchEmployees extends EmployeeEvent {}

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Item> employees;

  const EmployeeLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final ApiService apiService;

  EmployeeBloc(this.apiService) : super(EmployeeInitial()) {
    on<FetchEmployees>(_onFetchEmployees);
  }

  void _onFetchEmployees(FetchEmployees event, Emitter<EmployeeState> emit) async {
    try {
      emit(EmployeeLoading());
      final employees = await apiService.fetchItems();
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}

class EmployeeBlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text(
          'TP3 PROVIS BLOC',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 87,
      ),
      body: BlocProvider(
        create: (context) => EmployeeBloc(ApiService())..add(FetchEmployees()),
        child: EmployeeList(),
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is EmployeeLoaded) {
          final employees = state.employees;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return Card(
                color: Colors.pink[100],
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      
                      title: Text(
                        employee.employee_name,
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Rp ${employee.employee_salary}',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Divider(),
                          Text(
                            '${employee.employee_age} years',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        } else if (state is EmployeeError) {
          return Center(child: Text('Failed to fetch employees: ${state.message}'));
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}