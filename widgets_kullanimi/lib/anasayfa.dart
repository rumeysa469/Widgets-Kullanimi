import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var tfcontrol = TextEditingController();
  String alinan_veri = "";
  String resim_adi = "mutlu.png";
  bool switchkontrol = false;
  bool checkboxkontrol = false;
  int radio_deger = 0;
  bool progress_kontrol = false;
  double ilerleme = 30.0;
  var tf_saat = TextEditingController();
  var tf_tarih = TextEditingController();
  var ulkeler_listesi = <String>[];
  String secile_ulke = "Türkiye";

  @override
  void initState() {
    super.initState();
    ulkeler_listesi.add("Türkiye");
    ulkeler_listesi.add("İtalya");
    ulkeler_listesi.add("Japonya");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Widgets"),),
      body: SingleChildScrollView( // bu widget sayfamızı aşağıya sürüklemek için kullanılıyor
        child: Center(
          child: Column(
            children: [
              Text(alinan_veri),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tfcontrol,
                  decoration: InputDecoration(hintText: "Veri"), // değer alacağımız kısmının içinde yazıyor
                  keyboardType: TextInputType.number, // klavye sayılar olarak geliyor
                  obscureText: true,
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  alinan_veri = tfcontrol.text;
                });
              }, child: const Text("Veriyi Al")),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      resim_adi = "mutlu.png";

                    });
                  }, child: const Text("Resim 1")),
                  Image.asset("resimler/$resim_adi"),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      resim_adi = "uzgun.png";

                    });
                  }, child: const Text("Resim 2")),
                ],
        //------------------------------------- SWİTCH VE CHECKBOX EKLEME ------------------------------
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  SizedBox(width: 200,
                    child: SwitchListTile( // bu yapı da anahtar yapısı şeklinde
                        title: const Text("dart"),
                        controlAffinity: ListTileControlAffinity.leading, // bu kod yazdığımız dart kelimesini switvhin yanına yazdırıyor
                        value: switchkontrol,
                        onChanged: (veri){
                          setState(() {
                            switchkontrol =veri;

                      });
                    }),
                  ),
                  SizedBox(width: 200,
                    child: CheckboxListTile( // bu kod da kutucuk şekilde
                        title: const Text("Flutter"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: checkboxkontrol,
                        onChanged: (veri){
                          setState(() {
                            checkboxkontrol =veri!;

                          });
                        }),
                  )

                ],
        // ------------------------------------------------ RADİOLİST EKLEME YANİ BİR SEÇENEĞE ZORLAMA --------------------------------------------
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  SizedBox(width: 200,
                    child: RadioListTile( // bu radiolistile yapısı iki seçim arasından sadece birini seçmeye zorluyor
                        title: const Text("Barcelona"),
                        value: 1,
                        groupValue: radio_deger,
                        onChanged: (veri){
                          setState(() {
                            radio_deger =veri!;

                          });
                        }),
                  ),
                  SizedBox(width: 200,
                    child: RadioListTile(
                        title: const Text("Real Madrid"),
                        value: 2,
                        groupValue: radio_deger,
                        onChanged: (veri){
                          setState(() {
                            radio_deger =veri!;

                          });
                        }),
                  ),

                ],

              ),
        //----------------------------------------- BAŞLA VE DURDUR BUTONU OLUSTURP ARALARINDA BİR KONTROL İCONU EKLEME YUVARLAK DÖENEN ŞEY------------------------------------------------------
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      progress_kontrol = true;

                    });
                  }, child: const Text("Başla")),
                  Visibility(visible: progress_kontrol,child:  const CircularProgressIndicator()),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      progress_kontrol = false;

                    });
                  }, child: const Text("Durdur")),
                ],

              ),
          //------------------------------------- SLİDER EKLEME YANİ SÜRÜKLEME İLE DEĞER AYARLAMA -------------------------------------------------------
              Text(ilerleme.toInt().toString()),
              Slider(max: 100.0, min: 0,value: ilerleme, onChanged: (veri){
                setState(() {
                  ilerleme =veri;
                });

              }),
        //----------------------------------------- SAAT VE TARİH EKLEME VE KENDİMİZ DEĞER GİRME-------------------------------------------------------------------------
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox( width: 120,
                      child: TextField(controller: tf_saat , decoration: const InputDecoration(hintText: "Saat"),)),
                  IconButton(onPressed: (){
                    showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()))
                    .then((value){
                      tf_saat.text = "${value!.hour} : ${value.minute}";
                    });

                  }, icon: const Icon(Icons.access_time)),
                  SizedBox(width: 120,
                      child: TextField(controller: tf_tarih , decoration: const InputDecoration(hintText: "Tarih"),)),
                  IconButton(onPressed: (){
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now() ,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030))
                    .then((value){
                      tf_tarih.text = "${value!.day} / ${value.month} / ${value.year} ";
                    });

                  }, icon: const Icon(Icons.date_range)),


                ],

              ),

          //----------------------------------- GÖSTER BUTONU ------------------------------------------------




             DropdownButton(
                 value: secile_ulke ,
                 icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                 items: ulkeler_listesi.map((ulke){
                   return DropdownMenuItem(value: ulke ,child: Text(ulke),);

                 }).toList(),

                 onChanged: (veri){
                   setState(() {
                     secile_ulke = veri!;
                   });
                 }),

              GestureDetector(
                  onTap: (){
                   print("Contanier tek tıklandı.");
                  },
                  onDoubleTap: (){
                   print("Contanier çift tıklandı.");
                  },
                  onLongPress: (){
                   print("Contanier üzerine uzun basıldı.");
                  },
                  child: Container(width: 200 , height: 150, color: Colors.red,)),
              ElevatedButton(onPressed: (){
                print("Switch son durum : $switchkontrol");
                print("Checkbox son durum : $checkboxkontrol");
                print("Radio son durum : $radio_deger");
                print("Ülke son durum : $secile_ulke");




              }, child: const Text("Göster")),

            ],
          ),
        ),
      ),
    );
  }
}
