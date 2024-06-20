import 'dart:io';
import '2stack.dart';
import '1queue.dart';

class Pelanggan {
  String nama;
  String alamat;
  double beratPakaian;
  double totalPembayaran;

  Pelanggan(this.nama, this.alamat, this.beratPakaian)
      : totalPembayaran = beratPakaian * 6000;

  String toCsvString() {
    return '$nama,$alamat,$beratPakaian,$totalPembayaran';
  }
}

void tambahPelanggan(Queue<Pelanggan> antrianPelanggan) {
  stdout.write('Masukkan nama pelanggan: ');
  var nama = stdin.readLineSync()?.trim();

  stdout.write('Masukkan alamat pelanggan: ');
  var alamat = stdin.readLineSync()?.trim();

  stdout.write('Masukkan berat pakaian (kg): ');
  var beratPakaianStr = stdin.readLineSync()?.trim();
  var beratPakaian = double.tryParse(beratPakaianStr ?? '');

  if (beratPakaian == null) {
    stdout.writeln('Input berat pakaian tidak valid. Silakan coba lagi.');
    return;
  }

  Pelanggan pelangganBaru = Pelanggan(nama!, alamat!, beratPakaian);
  antrianPelanggan.enqueue(pelangganBaru);

  stdout.writeln('Pelanggan berhasil ditambahkan ke dalam antrian.\n');
}

void prosesAntrianPelanggan(Queue<Pelanggan> antrianPelanggan) {
  if (antrianPelanggan.isEmpty) {
    print('Tidak ada pelanggan dalam antrian.');
    return;
  }

  Pelanggan? pelangganSaatIni = antrianPelanggan.dequeue();

  if (pelangganSaatIni == null) {
    print('Antrian tidak valid. Silakan coba lagi.');
    return;
  }

  // Proses pelanggan
  print('Memproses pelanggan: ${pelangganSaatIni.nama}');
  print('Alamat: ${pelangganSaatIni.alamat}');
  print('Berat Pakaian: ${pelangganSaatIni.beratPakaian} kg');
  print('Total Pembayaran: Rp. ${pelangganSaatIni.totalPembayaran}');
  print('Proses selesai untuk pelanggan ini.');

  // Simpan pelanggan yang sudah diproses ke file CSV
  simpanKeCsv(pelangganSaatIni);
}

void hapusPelanggan(Queue<Pelanggan> antrianPelanggan, Stack<Pelanggan> undoStack) {
  if (antrianPelanggan.isEmpty) {
    stdout.writeln('Tidak ada pelanggan dalam antrian untuk dihapus.');
    return;
  }

  stdout.writeln('Daftar Pelanggan di Antrian:');
  tampilkanAntrianPelanggan(antrianPelanggan);

  stdout.write('Pilih nomor pelanggan yang akan dihapus (1-${antrianPelanggan.length}): ');
  var nomorStr = stdin.readLineSync()?.trim();
  var nomor = int.tryParse(nomorStr ?? '');

  if (nomor == null || nomor < 1 || nomor > antrianPelanggan.length) {
    stdout.writeln('Nomor pelanggan tidak valid.');
    return;
  }

  Pelanggan? pelangganYangDihapus = antrianPelanggan.elementAt(nomor - 1);
  antrianPelanggan.removeAt(nomor - 1);

  stdout.writeln('Pelanggan ${pelangganYangDihapus?.nama} berhasil dihapus dari antrian.\n');

  undoStack.push(pelangganYangDihapus!);
}

void undo(Stack<Pelanggan> undoStack, Queue<Pelanggan> antrianPelanggan) {
  if (undoStack.isEmpty) {
    stdout.writeln('Tidak ada aksi yang bisa dibatalkan (undo).');
    return;
  }

  Pelanggan? pelangganYangDiUndo = undoStack.pop();
  antrianPelanggan.enqueue(pelangganYangDiUndo!);

  stdout.writeln('Membatalkan aksi sebelumnya. Pelanggan ${pelangganYangDiUndo.nama} dikembalikan ke antrian.\n');
}

void tampilkanAntrianPelanggan(Queue<Pelanggan> antrianPelanggan) {
  int index = 1;
  for (var pelanggan in antrianPelanggan.toList()) {
    stdout.writeln('$index. ${pelanggan.nama}');
    index++;
  }
}

//CSV KODE
void simpanKeCsv(Pelanggan pelanggan) {
  File file = File('pelanggan.csv');

  RandomAccessFile raf = file.openSync(mode: FileMode.append);

  raf.writeStringSync('${pelanggan.toCsvString()}\n');

  raf.closeSync();
}




