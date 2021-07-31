import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:cijepise/services/database.dart';
import 'package:cijepise/constants.dart';

//Widgets
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDarkBlueColor,
            size: 28.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Database.getUserVaccinationInfo(http.Client(), userOib),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppointmentInputContainer(
                          label: 'Ime',
                          width: size.width * 0.4,
                          controller: imeController,
                        ),
                        AppointmentInputContainer(
                          label: 'Prezime',
                          width: size.width * 0.4,
                          controller: prezimeController,
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    AppointmentInputContainer(
                      label: 'Ulica i kućni broj',
                      width: size.width,
                      controller: adresaController,
                    ),
                    SizedBox(height: kDefaultPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding),
                          child: Text(
                            'Županija',
                            style: TextStyle(
                              color: kHintTextColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.0),
                        FutureBuilder(
                          future: Database.getZupanije(http.Client()),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kLightBlueColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              width: size.width,
                              height: 50.0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    'Županija',
                                    style: TextStyle(color: kHintTextColor),
                                  ),
                                  icon: Icon(
                                    Icons.expand_more,
                                    size: 24.0,
                                  ),
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: kInputTextColor,
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
                                    });
                                  },
                                  value: selectedZupanijaItem,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Grad',
                            style: TextStyle(color: kHintTextColor, fontSize: 14.0),
                          ),
                        ),
                        SizedBox(height: 2.0),
                        FutureBuilder(
                          future: Database.gradoviJson(selectedZupanijaItem),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kLightBlueColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              width: size.width,
                              height: 50.0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                    'Grad',
                                    style: TextStyle(
                                      color: kHintTextColor,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.expand_more,
                                    size: 24.0,
                                  ),
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: kInputTextColor,
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
                    SizedBox(height: kDefaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppointmentInputContainer(
                          label: 'OIB',
                          width: size.width * 0.4,
                          controller: oibController,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: kDefaultPadding),
                              child: Text(
                                'Datum rođenja',
                                style: TextStyle(
                                  color: kHintTextColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            SizedBox(
                              width: size.width * 0.4,
                              height: 50.0,
                              child: InkWell(
                                onTap: () {
                                  selectDate(context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: kDefaultPadding),
                                  decoration: BoxDecoration(
                                    color: kLightBlueColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Text(
                                    sDatumRodenja,
                                    style: TextStyle(
                                      color: kInputTextColor,
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
                    SizedBox(height: kDefaultPadding * 2),
                    RoundedButton(
                      text: 'Promijeni podatke',
                      onClick: () {
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
                        Database.addUserVaccination(oibController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
