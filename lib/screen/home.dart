import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widget/menu_card.dart';
import 'cek_hari.dart';
import 'konversi_waktu.dart';
import 'piramida.dart';
import 'segitiga.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _buka(BuildContext context,Widget page){
    Navigator.push(context,MaterialPageRoute(builder:(_)=>page));
  }

  @override
  Widget build(BuildContext context){
    final namaDepan=ProfileData.nama.split(' ').first;

    return Scaffold(
      appBar:AppBar(title:const Text(CalcMateText.appName)),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(20,18,20,28),
        children:[
          Container(
            padding:const EdgeInsets.all(20),
            decoration:BoxDecoration(
              color:AppColors.coklatTua,
              borderRadius:BorderRadius.circular(22),
              boxShadow:[BoxShadow(
                color:AppColors.coklatTua.withValues(alpha:.18),
                blurRadius:12,offset:const Offset(0,6),
              )],
            ),
            child:Row(
              children:[
                Expanded(child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text('Halo, $namaDepan!',style:const TextStyle(
                      fontSize:22,fontWeight:FontWeight.bold,color:AppColors.krem,
                    )),
                    const SizedBox(height:7),
                    const Text(
                      'Pilih alat yang ingin kamu gunakan dan hitung dengan lebih mudah.',
                      style:TextStyle(color:AppColors.krem,height:1.45,fontSize:13),
                    ),
                  ],
                )),
                Container(
                  padding:const EdgeInsets.all(12),
                  decoration:const BoxDecoration(color:AppColors.hijauTua,shape:BoxShape.circle),
                  child:const Icon(Icons.calculate_rounded,size:34,color:AppColors.krem),
                ),
              ],
            ),
          ),
          const SizedBox(height:26),
          const Text('Kalkulator & Utilitas',style:TextStyle(
            fontSize:18,fontWeight:FontWeight.w800,color:AppColors.coklatTua,
          )),
          const SizedBox(height:6),
          const Text(
            'Gunakan fitur berikut untuk menyelesaikan perhitunganmu.',
            style:TextStyle(fontSize:12.5,color:AppColors.teksSekunder),
          ),
          const SizedBox(height:14),
          MenuCard(
            icon:Icons.change_history_rounded,
            title:'Piramida',
            subtitle:'Hitung luas, keliling, dan volume piramida',
            onTap:()=>_buka(context,const PiramidaPage()),
          ),
          MenuCard(
            icon:Icons.change_history_rounded,
            title:'Segitiga',
            subtitle:'Hitung segitiga sama kaki, sama sisi, dan siku-siku',
            onTap:()=>_buka(context,const SegitigaPage()),
          ),
          MenuCard(
            icon:Icons.public_rounded,
            title:'Konversi Waktu',
            subtitle:'Konversi WIB, WITA, WIT, Malaysia, dan Kanada',
            onTap:()=>_buka(context,const KonversiWaktuPage()),
          ),
          MenuCard(
            icon:Icons.calendar_month_rounded,
            title:'Cek Hari',
            subtitle:'Ubah nomor 1–7 menjadi nama hari',
            onTap:()=>_buka(context,const CekHariPage()),
          ),
        ],
      ),
    );
  }
}
