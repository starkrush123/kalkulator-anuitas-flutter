**Peringatan: Aplikasi ini akan segera hadir di platform mobile Android!**

# Kalkulator Anuitas Flutter

Halo semuanya! Selamat datang di proyek Kalkulator Anuitas Flutter. Aplikasi ini dibuat untuk membantu kalian menghitung anuitas dengan mudah, baik itu anuitas biasa maupun anuitas di awal periode. Selain itu, kalian juga bisa melihat detail angsuran per periode dan mengatur beberapa hal biar aplikasi ini makin nyaman dipakai.

Sebenarnya, aplikasi ini adalah turunan dari versi Python yang sudah ada sebelumnya. Saya porting ke Flutter agar kedepannya bisa dijalankan di platform mobile seperti Android dan iOS, jadi lebih fleksibel dan bisa diakses banyak orang.

## Fitur-fitur Keren

*   **Hitung Anuitas:** Kalian bisa menghitung anuitas berdasarkan total pinjaman, bunga per periode (dalam persen), dan jumlah periode angsuran.
*   **Dua Mode Rumus:** Ada dua pilihan rumus anuitas:
    *   **Anuitas Biasa:** Perhitungan anuitas standar.
    *   **Anuitas di Awal Periode:** Buat kalian yang butuh perhitungan anuitas di awal periode.
*   **Detail Angsuran:** Penasaran berapa sih pokok, bunga, dan sisa pinjaman di angsuran tertentu? Aplikasi ini bisa kasih tahu!
*   **Pengaturan Fleksibel:** Kalian bisa atur:
    *   **Ukuran Teks:** Sesuaikan ukuran teks biar nyaman di mata.
    *   **Mode Rumus Default:** Pilih mode rumus anuitas yang paling sering kalian pakai.
    *   **Mode Tampilan:** Mau terang, gelap, atau ikutin pengaturan sistem? Bebas!
*   **Aksesibilitas:** Aplikasi ini dirancang dengan mempertimbangkan aksesibilitas, terutama untuk pembaca layar. Jadi, semua elemen penting punya label semantik yang jelas.
*   **Penanganan Error:** Kalau ada input yang salah atau masalah lain, aplikasi ini akan kasih tahu kalian dengan pesan error yang jelas, lengkap dengan detail teknisnya (kalau kalian mau lihat).

## Gimana Cara Pakainya?

Gampang banget!

1.  **Input Data:** Masukkan total pinjaman, bunga per periode (dalam persen), dan jumlah periode angsuran di kolom yang tersedia.
2.  **Detail Angsuran (Opsional):** Kalau mau lihat detail angsuran ke berapa, isi aja nomor angsurannya di kolom "Detail Angsuran ke-".
3.  **Hitung!:** Tekan tombol "Hitung Anuitas" dan tadaaa... hasilnya langsung muncul!

## Pengaturan Aplikasi

Untuk mengubah pengaturan, kalian bisa klik ikon **roda gigi** di pojok kanan atas layar. Di sana, kalian bisa:

*   Pilih mode rumus anuitas yang kalian inginkan.
*   Atur ukuran teks sesuai selera.
*   Ganti mode tampilan (terang, gelap, atau ikut sistem).

## Struktur Kode (Buat Kalian yang Penasaran)

Proyek ini diatur dengan rapi biar gampang dipahami dan dikembangkan. Berikut sekilas tentang struktur folder `lib`:

*   `lib/main.dart`: Ini adalah titik masuk utama aplikasi kita. Di sini kita setup `Provider` untuk manajemen state dan konfigurasi tema.
*   `lib/logic/hitung.dart`: Semua fungsi perhitungan anuitas ada di sini. Jadi, logika bisnisnya terpisah dari UI.
*   `lib/models/settings.dart`: Model data untuk pengaturan aplikasi (ukuran font, mode rumus, tema) dan `ChangeNotifier` untuk `Provider`.
*   `lib/screens/home_screen.dart`: Tampilan utama aplikasi, tempat kalian input data dan melihat hasil perhitungan.
*   `lib/widgets/about_dialog.dart`: Dialog "Tentang Aplikasi" yang berisi informasi dasar.
*   `lib/widgets/error_dialog.dart`: Dialog yang muncul kalau ada error, lengkap dengan detailnya.
*   `lib/widgets/settings_dialog.dart`: Dialog untuk mengubah pengaturan aplikasi.

## Dependensi yang Dipakai

Kita pakai beberapa paket dari pub.dev:

*   `provider`: Buat manajemen state yang gampang dan efisien.
*   `shared_preferences`: Untuk menyimpan pengaturan aplikasi biar nggak hilang pas aplikasi ditutup.
*   `intl`: Buat format angka dan mata uang biar sesuai dengan lokal (misalnya, Rupiah Indonesia).
*   `flutter_localizations`: Untuk dukungan lokalisasi di Flutter.

## Cara Menjalankan Proyek Ini

pastikan kalian sudah setup flutter di lingkungan developmen kalian.
1.  **Clone repositori ini:**
    ```bash
    git clone [URL_REPOSITORI_KALIAN]
    ```
2.  **Masuk ke folder proyek:**
    ```bash
    cd kalkulator_anuitas_flutter
    ```
3.  **Ambil dependensi:**
    ```bash
    flutter pub get
    ```
4.  **Jalankan aplikasinya:**
    ```bash
    flutter run
    ```

Selamat mencoba dan semoga bermanfaat! Kalau ada pertanyaan atau saran, jangan sungkan ya!

---

Ini adalah langkah pertama saya untuk masuk ke dunia mobile development. Semoga saya bisa terus belajar dan berkarya!