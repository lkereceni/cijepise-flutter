import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:cijepise/services/database.dart';
import 'package:cijepise/utilities/constants.dart';

//Components
import 'package:cijepise/components/appointment_input_container.dart';
import 'package:cijepise/components/rounded_button.dart';

String userId;
String userOib;
String userIme;
String userPrezime;
String userAdresa;
String userGrad;
String userZupanija;
String userDatumRodenja;
String sDatumRodenja = '';

class DataChangeScreen extends StatefulWidget {
  DataChangeScreen({Key key}) : super(key: key);

  @override
  _DataChangeScreenState createState() => _DataChangeScreenState();
}

class _DataChangeScreenState extends State<DataChangeScreen> {
  //Controllers
  TextEditingController imeController = new TextEditingController(),
      prezimeController = new TextEditingController(),
      adresaController = new TextEditingController(),
      oibController = new TextEditingController(),
      datumRodenjaController = new TextEditingController();

  String selectedGradItem;
  String selectedZupanijaItem;

  Future getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedId = prefs.getString('id');
    var obtainedOib = prefs.getString('oib');
    var obtainedIme = prefs.getString('ime');
    var obtainedPrezime = prefs.getString('prezime');
    var obtainedAdresa = prefs.getString('adresa');
    var obtainedGrad = prefs.getString('grad');
    var obtainedZupanija = prefs.getString('zupanija');
    var obtainedDatumRodenja = prefs.getString('datumRodenja');

    String datumRodenjaGodina = obtainedDatumRodenja.substring(0, 4);
    String datumRodenjaMjesec = obtainedDatumRodenja.substring(4, 6);
    String datumRodenjaDan = obtainedDatumRodenja.substring(6, 8);
    sDatumRodenja = datumRodenjaDan + '.' + datumRodenjaMjesec + '.' + datumRodenjaGodina + '.';

    setState(() {
      userId = obtainedId;
      userOib = obtainedOib;
      userIme = obtainedIme;
      userPrezime = obtainedPrezime;
      userAdresa = obtainedAdresa;
      userGrad = obtainedGrad;
      userZupanija = obtainedZupanija;
      userDatumRodenja = obtainedDatumRodenja;

      imeController.text = userIme;
      prezimeController.text = obtainedPrezime;
      adresaController.text = obtainedAdresa;
      oibController.text = obtainedOib;

      selectedGradItem = obtainedGrad;
      selectedZupanijaItem = obtainedZupanija;
    });
  }

  bool datePicked = false;
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy.');
  final DateFormat databaseFormatter = DateFormat('yyyyMMdd');

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1915, 8),
      lastDate: DateTime(2022),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        sDatumRodenja = formatter.format(selectedDate);
        datePicked = true;
      });
    }
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: Database.getUserVaccinationInfo(http.Client(), userOib),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 2.0,
                    left: -10.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(kDarkBlueColor),
                        size: 36.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    top: 140.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          AppointmentInputContainer(
                            label: 'Ime',
                            width: 170.0,
                            controller: imeController,
                          ),
                          SizedBox(width: 20.0),
                          AppointmentInputContainer(
                            label: 'Prezime',
                            width: 170.0,
                            controller: prezimeController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240.0,
                    child: AppointmentInputContainer(
                      label: 'Ulica i kućni broj',
                      width: 360.0,
                      controller: adresaController,
                    ),
                  ),
                  Positioned(
                    top: 330.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Županija',
                            style: TextStyle(color: Color(kHintTextColor), fontSize: 14.0),
                          ),
                        ),
                        FutureBuilder(
                          future: Database.getZupanije(http.Client()),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(kLightBlueColor),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              width: 360.0,
                              height: 50.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0, right: 8.0),
                                child: DropdownButton(
                                  hint: Text(
                                    'Županija',
                                    style: TextStyle(
                                      color: Color(kHintTextColor),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.expand_more,
                                    size: 24.0,
                                  ),
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Color(kInputTextColor),
                                    fontFamily: 'UniSans',
                                    fontSize: 16.0,
                                  ),
                                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      child: Text(item.nazivZupanije),
                                      value: item.nazivZupanije,
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      if (selectedGradItem != null) {
                                        selectedGradItem = null;
                                      }
                                      selectedZupanijaItem = newVal;
                                      //zupanijaQuery = newVal;
                                    });
                                  },
                                  value: selectedZupanijaItem,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 420.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Grad',
                            style: TextStyle(color: Color(kHintTextColor), fontSize: 14.0),
                          ),
                        ),
                        FutureBuilder(
                          future: Database.gradoviJson(selectedZupanijaItem),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(kLightBlueColor),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              width: 360.0,
                              height: 50.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 24.0, right: 0.0),
                                child: DropdownButton(
                                  hint: Text(
                                    'Grad',
                                    style: TextStyle(
                                      color: Color(kHintTextColor),
                                    ),
                                  ),
                                  icon: Expanded(
                                    child: Icon(
                                      Icons.expand_more,
                                      size: 24.0,
                                    ),
                                  ),
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Color(kInputTextColor),
                                    fontFamily: 'UniSans',
                                    fontSize: 16.0,
                                  ),
                                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      child: Text(item['mjesto']),
                                      value: item['mjesto'],
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      selectedGradItem = newVal;
                                    });
                                  },
                                  value: selectedGradItem,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 510.0,
                    child: Row(
                      children: [
                        AppointmentInputContainer(
                          label: 'OIB',
                          width: 170.0,
                          controller: oibController,
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Datum rođenja',
                                style: TextStyle(
                                  color: Color(kHintTextColor),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            SizedBox(
                              width: 170.0,
                              height: 50.0,
                              child: InkWell(
                                onTap: () {
                                  selectDate(context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 14.0),
                                  decoration: BoxDecoration(
                                    color: Color(kLightBlueColor),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Text(
                                    sDatumRodenja,
                                    style: TextStyle(
                                      color: Color(kInputTextColor),
                                      fontFamily: 'UniSans',
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 650.0,
                    child: RoundedButton(
                      text: 'Promijeni podatke',
                      onClick: () {
                        print('selectedDate: ${selectedDate.year}');
                        print(DateTime.now().year);
                        selectedDate.year == DateTime.now().year
                            ? sDatumRodenja = userDatumRodenja
                            : sDatumRodenja = databaseFormatter.format(selectedDate);
                        Database.updateUser(
                          userId,
                          imeController.text,
                          prezimeController.text,
                          adresaController.text,
                          selectedGradItem,
                          selectedZupanijaItem,
                          int.parse(oibController.text),
                          int.parse(sDatumRodenja),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
