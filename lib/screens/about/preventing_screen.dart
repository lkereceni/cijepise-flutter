import 'package:cijepise/components/about_paragraph.dart';
import 'package:cijepise/components/about_title.dart';
import 'package:cijepise/components/screen_title.dart';
import 'package:cijepise/constants.dart';
import 'package:flutter/material.dart';

class PreventingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(title: 'Kako se zaštititi?'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Pranje ruku'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Centri za kontrolu i prevenciju bolesti preporučuju redovno pranje ruku sapunom najmanje 20 sekundi posebno nakon odlaska u toalet, prije jela, i nakon istresanja nosa, kašljanja ili kihanja. Ako sapun nije dostupan, onda se preporučuje bilo koje sredstvo za pranje ruku s najmanje 60% alkohola.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Respiratorna higijena'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Zdravstvena tijela preporučuju pojedincima da pokrivaju usta i nos maramicom tokom kašljanja ili kihanja (koju bi trebalo odmah odložiti), ili rukavom ako maramica nije dostupna.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Pojedincima koji mogu biti zaraženi savjetuje se nošenje kirurške maske. Maske za lice mogu ograničiti jačinu i put putovanja kapi koje se raspršuju tijekom razgovora, kihanja i kašljanja.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Socijalno distanciranje'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Socijalno distanciranje je način na koji ljudi mogu spriječiti blisku i čestu interakciju s drugima kako bi se prestala širiti zarazna bolest, u ovom slučaju koronavirus. Škole i druga mjesta okupljanja, poput kina i kazališta, se zatvaraju, a sportski događaji i vjerska okupljanja otkazuju. Karantena odvaja i ograničava kretanje ljudi koji su izloženi mogućoj zarazi, a traje toliko dugo da se osigura pojava simptoma ukoliko je osoba zaražena.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Samoizolacija'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Izolacija znači da se osoba smješta i boravi u posebnoj sobi/prostoriji radi sprečavanja širenja zarazne bolesti. Isto vrijedi i za samoizolaciju, samo se termin izolacija koristi za bolesne osobe, a samoizolacija ili kućna karantena za zdrave. Izolacija je mjera izdvajanja osobe od drugih ljudi koja se primjenjuje prilikom liječenja osoba koje su bolesne i imaju simptome bolesti, u ovom slučaju su to simptomi akutne respiratorne infekcije (barem jedan od sljedećih simptoma: povišena tjelesna temperatura, kašalj, kratak dah odnosno poteškoće s disanjem) uz ispunjene epidemiološke kriterije (boravak u zemljama koje su zahvaćene epidemijom ili bliski kontakt s osobom koja je vjerojatan ili potvrđen slučaj bolesti). Osobe za koje zdravstveni djelatnik postavi sumnju na infekciju virusom COVID-19 hospitaliziraju se uz primjenu mjera izolacije, dijagnostike i liječenja.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Samoizolacija je posebna mjera zdravstvene zaštite koja se provodi temeljem odluke ministra zdravstva. Primjenjuje se za zdrave osobe (bez simptoma) koje se bile u bliskom kontaktu s oboljelim osobama ili su unazad 14 dana boravile u područjima/zemljama s lokalnom ili raširenom transmisijom (prijenosom) koronavirusnom bolesti COVID-19 u trajanju od 14 dana od napuštanja zahvaćenog područja ili doticaja s oboljelom osobom. Osnovno pravilo je da treba ostati kod kuće (u kućnoj karanteni, strani državljani u organiziranoj karanteni) i izbjegavati fizički bliski kontakt s drugim ljudima. Vrijeme trajanja zdravstvenog nadzora odnosno samoizolacije je 14 dana, zato što inkubacija COVID-19 bolesti (od zaraze do pojave simptoma) može trajati od 2 do 14 dana.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
