import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3provis/api_service.dart';
import 'package:tp3provis/item.dart';
import 'package:google_fonts/google_fonts.dart';


class EmployeeProvider with ChangeNotifier {
  ApiService _apiService = ApiService();
  List<Item> _items = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Item> get items => _items;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _items = await _apiService.fetchItems();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class EmployeeProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider()..fetchItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[300],
          title: Text(
            'TP3 PROVIS PROVIDER',
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
        body: Consumer<EmployeeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage.isNotEmpty) {
              return Center(child: Text(provider.errorMessage));
            } else {
              return ListView.builder(
                itemCount: provider.items.length,
                itemBuilder: (context, index) {
                  final employee = provider.items[index];
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
            }
          },
        ),
      ),
    );
  }
}