import 'dart:io';
import 'fiturLaundry.dart';
import '2stack.dart';
import '1queue.dart';

void main() {
  Queue<Pelanggan> antrianPelanggan = Queue<Pelanggan>();
  Stack<Pelanggan> undoStack = Stack<Pelanggan>();

  bool selesai = false;
  while (!selesai) {
    stdout.write('Menu Utama:\n1. Masukkan pelanggan baru\n2. Proses antrian pelanggan\n3. Hapus Pelanggan\n4. Undo\n5. Keluar\nPilih menu (1/2/3/4/5): ');
    var pilihan = stdin.readLineSync()?.trim();

    switch (pilihan) {
      case '1':
        tambahPelanggan(antrianPelanggan);
        break;
      case '2':
        prosesAntrianPelanggan(antrianPelanggan);
        break;
      case '3':
        hapusPelanggan(antrianPelanggan, undoStack);
        break;
      case '4':
        undo(undoStack, antrianPelanggan);
        break;
      case '5':
        selesai = true;
        break;
      default:
        stdout.writeln('Pilihan tidak valid. Silakan pilih 1, 2, 3, 4, 5, atau 6.');
    }
  }
}