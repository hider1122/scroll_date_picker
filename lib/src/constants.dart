import 'package:flutter/cupertino.dart';

const String ko = 'ko';
const String fr = 'fr';
const String de = 'de';
const String vi = 'vi';
const String en = 'en';
const String id = 'id';
const String it = 'it';
const String th = 'th';
const String es = 'es';
const String nl = 'nl';
const String zh = 'zh';
const String ar = 'ar';
const String islamic_ar = "islamic_ar";
const String islamic_en = "islamic_en";

enum MonthType {
  ko,
  fr,
  de,
  vi,
  en,
  id,
  it,
  th,
  es,
  nl,
  zh,
  ar,
  islamic_ar,
  islamic_en
}

List<String> getMonths(MonthType monthType) {
  switch (monthType) {
    case MonthType.zh:
    case MonthType.ko:
      return intMonths;
    case MonthType.fr:
      return frMonths;
    case MonthType.de:
      return deMonths;
    case MonthType.vi:
      return viMonths;
    case MonthType.id:
      return idMonths;
    case MonthType.it:
      return itMonths;
    case MonthType.th:
      return thMonths;
    case MonthType.es:
      return esMonth;
    case MonthType.nl:
      return nlMonth;
    case MonthType.ar:
      return arMonths;
    case MonthType.islamic_en:
      return arHijriMonts;
    case MonthType.islamic_ar:
      return enHijriMonts;
    default:
      return enMonths;
  }
}

const List<String> intMonths = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
];
const List<String> enMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
const List<String> frMonths = [
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];
const List<String> deMonths = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember',
];
const List<String> viMonths = [
  'Tháng 1',
  'Tháng 2',
  'Tháng 3',
  'Tháng 4',
  'Tháng 5',
  'Tháng 6',
  'Tháng 7',
  'Tháng 8',
  'Tháng 9',
  'Tháng 10',
  'Tháng 11',
  'Tháng 12',
];
const List<String> idMonths = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];
const List<String> itMonths = [
  'Gennaio',
  'Febbraio',
  'Marzo',
  'Aprile',
  'Maggio',
  'Giugno',
  'Luglio',
  'Agosto',
  'Settembre',
  'Ottobre',
  'Novembre',
  'Dicembre',
];
const List<String> thMonths = [
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม',
];
const List<String> esMonth = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre',
];
const List<String> nlMonth = [
  'Januari',
  'Februari',
  'Maart',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Augustus',
  'September',
  'Oktober',
  'November',
  'December',
];
const List<String> arMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];
const List<String> arHijriMonts = [
  'Muharram',
  'Safar',
  'Rabi\' Al-Awwal',
  'Rabi\' Al-Thani',
  'Jumada Al-Awwal',
  'Jumada Al-Thani',
  'Rajab',
  'Sha\'aban',
  'Ramadan',
  'Shawwal',
  'Dhu Al-Qi\'dah',
  'Dhu Al-Hijjah'
];
const List<String> enHijriMonts = [
  'محرم',
  'صفر',
  'ربيع الاول',
  'ربيع الثاني',
  'جمادى الأول',
  'جمادى الثاني',
  'رجب',
  'شعبان',
  'رمضان',
  'شوال',
  'ذو القعدة',
  'ذو الحجة'
];
