1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Dalam Flutter widget tree adalah struktur hierarki yang menggambarkan bagaimana semua widget saling berhubungan untuk membentuk antarmuka pengguna. Setiap widget dapat menjadi parent yang membungkus satu atau beberapa child , dan hubungan ini menentukan bagaimana tampilan dan tata letak UI diatur. Parent widget mengontrol posisi, ukuran, dan gaya anaknya, sementara child widget menentukan konten atau ukuran minimum yang dibutuhkan. Flutter membangun dan memperbarui UI dengan cara membangun ulang bagian dari pohon widget ini setiap kali terjadi perubahan state.

contoh Center(Text("ada")) center merupakan parentnya dan text adalah anaknya, sehingga text di center 

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 di main.dart *

MaterialApp
 Widget utama yang membungkus seluruh aplikasi dan menyediakan konfigurasi global seperti tema (ThemeData), judul, serta halaman awal (home).

ThemeData
Mengatur tampilan tema aplikasi, seperti warna utama (primarySwatch), warna sekunder, dan penggunaan Material Design 3.

MyApp (StatelessWidget) Widget root aplikasi yang menampilkan MaterialApp.

menu.dart

Scaffold
Menyediakan struktur dasar halaman (memiliki AppBar, body, FloatingActionButton, dll).

AppBar
Bagian atas halaman yang menampilkan judul “Football Shop”.

Text
Menampilkan teks, seperti judul aplikasi, nama, dan label kartu.

Padding
Memberi jarak di sekeliling widget, agar tampilan tidak menempel ke tepi layar.

Column
Menyusun widget secara vertikal (atas ke bawah).

Row
Menyusun widget secara horizontal (samping ke samping), digunakan untuk menampilkan tiga InfoCard.

SizedBox
Memberi jarak vertikal antar widget dengan tinggi tertentu.

Center
Memposisikan widget di tengah area yang tersedia.

GridView.count
 Menampilkan item dalam bentuk grid (dalam proyek ini, 3 kolom per baris).

Card
 Widget berbentuk kartu dengan bayangan lembut di bawahnya, digunakan pada InfoCard.

Container
Membungkus widget lain dan memungkinkan pengaturan padding, ukuran, dan warna latar.

MediaQuery
Mengambil ukuran layar perangkat agar ukuran widget (misalnya lebar InfoCard) dapat menyesuaikan secara responsif.

Material
Memberikan efek visual dan interaktif khas Material Design, seperti warna dan sudut membulat pada ItemCard.

InkWell
Menangani aksi sentuhan (tap) dengan efek ripple dan fungsi onTap.

SnackBar
Menampilkan pesan sementara di bagian bawah layar saat pengguna menekan ItemCard.

ScaffoldMessenger
Menampilkan dan mengelola SnackBar pada halaman yang sedang aktif.

Icon
Menampilkan ikon di dalam ItemCard.

EdgeInsets**
Digunakan untuk mengatur jarak (padding atau margin) dalam berbagai widget seperti Padding dan Container.

Custom Widget

MyHomePage (StatelessWidget)
 Halaman utama aplikasi yang menampilkan identitas dan daftar item.

InfoCard (StatelessWidget)
 Widget khusus untuk menampilkan informasi pribadi (NPM, Nama, Kelas) dalam bentuk kartu.

ItemCard (StatelessWidget)
 Widget khusus untuk menampilkan menu pilihan (All Products, Create Product, My Products) dalam bentuk kartu berwarna dengan ikon.

ItemHomepage (Class data model)
 Bukan widget, tapi class yang menyimpan data untuk setiap ItemCard (nama, ikon, warna).

 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
 MaterialApp adalah fondasi utama aplikasi Flutter berbasis Material Design yang menyediakan tema, navigasi, dan konteks global, dan biasa digunakan sebagai root. Contohnya dia mengatur tema dan warna aplikasi contoh lain juga dia Membungkus seluruh widget dalam konteks Material Design
Sehingga widget seperti Scaffold, AppBar, FloatingActionButton, dan SnackBar dapat digunakan dengan benar.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Menurut saya stateless widget itu ada konten atau halaman page yang statis dan stateful widget itu kontennya bisa dinamis (contoh animasi, responsive). Contoh stateless widget adalah kamu membangun sebuah widget untuk tampilkan informasi statis, seperti Card(...), kalau stateful contohnya ketika kita menekan suatu tombol cardnya berubah warna

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang merepresentasikan lokasi (posisi) sebuah widget di dalam widget tree Flutter. Dengan kata lain, setiap widget yang ada di dalam aplikasi memiliki konteksnya sendiri, yang digunakan Flutter untuk mengetahui di mana widget tersebut berada dalam struktur pohon dan apa saja data yang bisa diaksesnya.

Tanpa BuildContext, widget tidak tahu posisi dirinya di dalam pohon, sehingga tidak bisa mengakses data atau fungsi dari parent widget.

BuildContext juga penting agar Flutter tahu bagian mana dari UI yang perlu di-rebuild saat ada perubahan state.

6.  Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

 Hot Reload

Hot reload memungkinkan kamu memperbarui kode Dart secara cepat dan langsung melihat perubahan di aplikasi yang sedang berjalan, tanpa kehilangan state aplikasi saat ini (misalnya nilai variabel, posisi scroll, input user).

Ciri-ciri Hot Reload:

Memperbarui UI atau logika widget secara langsung.

Tidak menghapus state yang sedang berjalan.

Cepat, biasanya hanya beberapa detik.

Biasanya digunakan saat mengubah tampilan, style, atau layout.

Contoh Penggunaan:

Mengubah warna teks dari merah ke biru  maka langsung terlihat di aplikasi.

Menambahkan widget baru di Column atau Row makalangsung muncul.

Hot Restart

Hot restart melakukan reload penuh pada seluruh aplikasi, sehingga semua state akan di-reset. Artinya aplikasi mulai kembali dari awal, seperti menutup dan membuka ulang aplikasi, tapi tetap lebih cepat daripada stop dan run ulang.

Ciri-ciri Hot Restart:

Menghapus semua state yang ada.

Semua variabel global, stateful widget, dan posisi UI akan kembali ke kondisi awal.

Cocok digunakan saat mengubah inisialisasi atau konfigurasi awal aplikasi.

Contoh Penggunaan:

Mengubah nilai awal counter di StatefulWidget.

Mengubah konfigurasi ThemeData di MaterialApp.

Menambahkan package baru yang memengaruhi seluruh aplikasi.


**Tugas 8**

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?


Navigator.push() menambahkan halaman baru di atas stack. Pengguna masih bisa kembali ke halaman sebelumnya (back).

Navigator.pushReplacement() mengganti halaman sekarang dengan halaman baru. Halaman lama dihapus dari stack, jadi tidak bisa kembali ke sana.

Gunakan Navigator.push() ketika:

Dari Product List ke Product Detail (user mungkin ingin kembali untuk lihat produk lain).

dSX

Gunakan Navigator.pushReplacement() keti:
Setelah Login/Signup sukses ke Home (mencegah kembali ke layar auth).


2.  Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi

intinya kita pakai Scaffold sebagai “kerangka”, AppBar untuk header konsisten (judul/aksi), dan Drawer sebagai navigasi global. Buat satu layout reusable agar setiap halaman pakai struktur yang sama tanpa copy–paste.

contoh:
Shell/Layout tunggal: bungkus Scaffold, AppBar, Drawer dalam widget khusus dan terima title, actions, dan body sebagai parameter.

Tema konsisten: warna/typography diatur lewat ThemeData (hindari hardcode per halaman).

Navigasi di Drawer: item navigasi mengarah ke route utama tandai item aktif supaya user tahu posisi.


3.Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.


Dalam form Flutter, Padding, SingleChildScrollView, dan ListView membantu menjaga UI rapi, nyaman, dan tahan terhadap overflow. Padding memberi jarak konsisten di sekeliling setiap field sehingga form lebih mudah dipindai dan tidak “mepet” tepi layar persis seperti yang kita lakukan pada Product Form (misalnya jarak 8 px di tiap TextFormField). SingleChildScrollView membuat seluruh isi form dapat digulir sehingga tidak terjadi overflow saat keyboard muncul, cocok untuk form pendek sedang seperti halaman “Add Product”   pengguna tetap bisa melihat tombol Save tanpa elemen tertutup keyboard. Sementara itu, ListView lebih pas untuk form yang panjang atau dinamis—misalnya daftar input stok per ukuran S, M, L, XL di Football Shop karena membangun item secara efisien, mendukung pemisah antar‐elemen lewat separator, dan menjaga performa saat jumlah field bertambah. kita gunakan Padding untuk ritme visual yang konsisten, SingleChildScrollView untuk mencegah overflow dan memastikan form tetap bisa diakses saat keyboard tampil, dan ListView ketika jumlah input banyak/berulang agar tetap ringan dan terstruktur.


4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Untuk menjaga identitas visual Football Shop tetap konsisten, tetapkan palet warna brand (primary/secondary/netral/error) lalu taruhh lewat ThemeData dan ColorScheme agar seluruh komponen AppBar, tombol, field, ikon, hingga teks otomatis memakai warna yang sama tanpa hardcode per halaman. Gunakan Material 3  dan sesuaikan AppBarTheme, ElevatedButtonTheme, InputDecorationTheme, serta TextTheme sehingga judul, label, dan state  selaras dengan brand. Bangun skema dari warna utama  memakai ColorScheme.fromSeed, sediakan darkTheme agar konsisten di mode gelap, dan pertahankan kontras warna untuk aksesibilitas. Untuk kebutuhan khusus seperti badg diskon atau Featured, tambahkan ThemeExtension sehingga aset warna/gradien tetap tersentralisasi. Dengan pendekatan ini, kita cukup pakai komponen standar Flutter dan seluruh aplikasi akan memantulkan identitas brand secara konsisten.