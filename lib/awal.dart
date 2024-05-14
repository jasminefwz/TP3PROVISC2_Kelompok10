import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tp3provis/employee_provider.dart'; // Mengimpor file 'employee_provider.dart'
import 'package:tp3provis/employee_bloc.dart'; // Mengimpor file 'employee_bloc.dart'

class Awal extends StatefulWidget {
  @override
  _AwalState createState() => _AwalState();
}

class _AwalState extends State<Awal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  SizedBox(height: 20),
                  Text(
                    'TP3 PROVIS',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Nomor Kelompok: [10]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Mhs 1:  [2200978, Ratu Syahirah Khairunnisa]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Mhs 2:  [2200598, Jasmine Noor Fawzia]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 30),
                  ElevatedButton(
                    // onPressed: _handleLogin,
                    onPressed: () {
                      // Proses pendaftaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeProviderScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Provider',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 80,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol daftar ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeBlocScreen()),
                      );
                    },
                    child: Text(
                      'Bloc',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
