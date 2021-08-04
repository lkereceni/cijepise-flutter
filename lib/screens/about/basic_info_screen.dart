import 'package:cijepise/components/about_paragraph.dart';
import 'package:cijepise/components/about_title.dart';
import 'package:cijepise/components/screen_title.dart';
import 'package:cijepise/constants.dart';
import 'package:flutter/material.dart';

class BasicInfoScreen extends StatelessWidget {
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
                ScreenTitle(title: 'Osnovne informacije'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Što je cijepljenje?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Cijepljenje je jedna od najefikasnijih javnozdravstvenih mjera u povijesti medicine koja je samostalno produljila ljudski vijek za najmanje 20 godina.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Cijepljenjem protiv COVID-19 u organizam unosimo tvar koja stimulira naš imunološki sustav da  samostalno stvara otpornost na koronavirus.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Zašto se treba cijepiti?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Cijepljenje je najdjelotvorniji način zaštite od bolesti COVID-19 i najučinkovitiji način suzbijanja širenja pandemije.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Cijepljenje je dobrovoljno i besplatno. Međutim,  da bi cijepljenje bilo efikasno, ključno je da se cijepi velika većina građana.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text: 'Cijepljenjem štitite sebe i osobe s kojima živite ili s kojima dolazite u kontakt.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Sva registrirana cjepiva u Hrvatskoj i Europskoj uniji djelotvorno štite od težih oblika bolesti, hospitalizacije i smrtnih ishoda.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Tko se treba cijepiti?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Svi građani s prebivalištem ili boravištem u Hrvatskoj mogu se cijepiti protiv COVID19. Cjepiva protiv COVID-19 nisu namijenjena djeci mlađoj od 16 ili 18 godina:  granična dob za cijepljenje ovisi o vrsti cjepiva.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Ipak, zbog većeg rizika za razvoj težih oblika bolesti COVID-19, prioritet imaju osobe s kroničnim bolestima i osobe starije životne dobi. To uključuje osobe s respiratornim, kardiovaskularnim, malignim bolestima, bolestima bubrega, dijabetesom i imunodeficijencijama.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Netom prije cijepljenja liječnik će utvrditi postoje li zdravstveni razlozi zbog kojih bi cijepljenje trebalo odgoditi (npr. u slučaju povišene tjelesne temperature, akutne bolesti) ili zbog kojih se netko trajno ne može cijepiti (poznata preosjetljivosti na sastojke cjepiva i/ili ozbiljne reakcije nakon prve doze cjepiva).'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(text: 'Osobe koje su pozitivne na COVID-19 ne mogu se cijepiti dok su bolesne.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Osobe koje su preboljele COVID-19 trebaju čekati najmanje mjesec dana od ozdravljenja prije cijepljenja.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Kako se provodi cijepljenje?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(text: 'Cijepljenje se kod većine cjepiva provodi s dvije doze'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Nakon što ste se prijavili za cijepljenje, obavijest o oba termina cijepljenja dobit ćete obavijest na mobilni uređaj.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Ne mogu se ponovno cijepiti osobe koje su se već cijepile protiv COVID-19 i koje su primile obje doze cjepiva.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Gdje se provodi cijepljenje?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Cijepljenje se provodi:\nu ordinacijama opće prakse (osobito za kronične bolesnike),\nu županijskim zavodima za javno zdravstvo,\nna punktovima za masovno cijepljenje u organizaciji županijskih zavoda za javno zdravstvo i domova zdravlja.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Nepokretne ili teže pokretne osobe prijavljuju se za cijepljenje svojem liječniku obiteljske medicine. On će ih cijepiti prilikom kućnog posjeta, ili će ih kod kuće cijepiti mobilni timovi.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Kako se prijaviti na cijepljenje?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Za cijepljenje se možete prijaviti:\n\t1. Prijavom kod svojeg liječnika obiteljske medicine.\n\t2. Putem ove aplikacije.\n\t3. Pozivom na besplatni broj telefona 0800 0011.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Što ako sam trudna ili dojim?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'U ovom se trenutku smatra  da se mogu cijepiti trudnice i dojilje koje imaju neki dodatni rizični čimbenik za razvoj teškog oblika bolesti COVID-19 ili koje su izložene većem riziku od zaraze, primjerice zdravstvene djelatnice.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Trudnice i dojilje odluku o cijepljenju trebaju donijeti uz dodatno savjetovanje s liječnikom o koristima i potencijalnim rizicima cijepljenja.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Kada žena oboli od bolesti COVID-19, trudnoća može povećati rizik za razvoj teške kliničke slike. Može postojati i povećani rizik od negativnih ishoda trudnoće, poput prijevremenog porođaja. Trudnicama koje imaju vrućicu nakon cijepljenja treba savjetovati uzimanje paracetamola. Nije potrebno rutinsko testiranje na trudnoću prije primanja cjepiva protiv COVID-19.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Je li cjepivo sigurno?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Prije stavljanja na tržište u Hrvatskoj, svako cjepivo mora zadovoljiti strogo zadane zahtjeve kakvoće, sigurnosti i djelotvornosti, kako Hrvatske agencije za lijekove i medicinske proizvode, tako i Europske agencije za lijekove.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(text: 'Time se hrvatskim građanima nude samo najkvalitetnija cjepiva na tržištu.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Sigurnost svih cjepiva intenzivno se prati, kako u ispitivanjima prije davanja odobrenja za stavljanje cjepiva u promet, tako i kroz različite studije te sustave prijavljivanja mogućih nuspojava.'),
                SizedBox(height: kDefaultPadding),
                AboutTitle(text: 'Jesu li moguće nuspojave?'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(text: 'Kao i kod lijekova, nuspojave su moguće i kod cjepiva.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Nuspojave vezane za cijepljenje protiv COVID-19 relativno su česte, ali uglavnom blage i prolazne: javljaju se prvih dana nakon cijepljenja i traju od 1 do 2 dana. Radi se o umoru, vrućici, zimici, bolu u mišićima, bolu u zglobovima, glavobolji, boli i otoku na mjestu uboda i sličnim prolaznim simptomima.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Za sva cjepiva koja se koriste u Hrvatskoj, klinička istraživanja dokazala su da prednost cijepljenja uvelike nadilazi rizik mogućih nuspojava.'),
                SizedBox(height: kDefaultPadding / 2),
                AboutParagraph(
                    text:
                        'Prilikom cijepljenja dobit ćete uputu o tome gdje i kome možete prijaviti eventualne nuspojave.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
