import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messytenmobile/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  int _price = 0; // default
  String _content = "";
  String? _category; // wajib dipilih mulai null agar tervalidasi
  String _thumbnail = "";
  bool _isFeatured = false; // default

  final List<String> _categories = [
    'jerseys',
    'footwear',
    'accessories',
    'equipment',
    'collectibles',
    'fan_gear',
  ];

  // Helper: validasi URL http/https sederhana
  bool _isValidHttpUrl(String s) {
    final uri = Uri.tryParse(s);
    return uri != null &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // === Title ===
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Product Name",
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(60)],
                onChanged: (value) => setState(() => _title = value),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Product Name tidak boleh kosong!";
                  }
                  if (value.trim().length < 3) {
                    return "Product Name minimal 3 karakter.";
                  }
                  // max 60
                  if (value.trim().length > 60) {
                    return "Product Name maksimal 60 karakter.";
                  }
                  return null;
                },
              ),
            ),

            // === Price ===
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga (Rp)",
                  labelText: "Harga",
                  prefixText: "Rp ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12)
                ],
                onChanged: (value) =>
                    setState(() => _price = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final v = int.tryParse(value);
                  if (v == null) {
                    return "Harga harus berupa angka.";
                  }
                  if (v <= 0) {
                    return "Harga harus lebih dari 0.";
                  }
                  return null;
                },
              ),
            ),

            // === Content ===
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Deskripsi Produk",
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                onChanged: (value) => setState(() => _content = value),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (value.trim().length < 10) {
                    return "Deskripsi minimal 10 karakter.";
                  }
                  return null;
                },
              ),
            ),

            // === Category  ===
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                value: _category,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ))
                    .toList(),
                onChanged: (newValue) => setState(() => _category = newValue),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori wajib dipilih.";
                  }
                  if (!_categories.contains(value)) {
                    return "Kategori tidak valid.";
                  }
                  return null;
                },
              ),
            ),

            // === Thumbnail URL ) ===

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "URL Thumbnail",
                  labelText: "URL Thumbnail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (value) => setState(() => _thumbnail = value),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "URL Thumbnail tidak boleh kosong!";
                  }
                  final s = value.trim();
                  final uri = Uri.tryParse(s);
                  final isValid = uri != null &&
                      (uri.isScheme('http') || uri.isScheme('https')) &&
                      uri.host.isNotEmpty;
                  if (!isValid) {
                    return "Format URL tidak valid (harus http/https).";
                  }
                  if (s.length > 2048) {
                    return "URL terlalu panjang.";
                  }
                  return null;
                },
              ),
            ),

            // === Is Featured ===
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwitchListTile(
                title: const Text("Tandai sebagai Produk Unggulan"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
              ),
            ),

            // === Tombol Simpan ===
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Judul: $_title'),
                                  Text('Harga: Rp $_price'),
                                  Text('Deskripsi: $_content'),
                                  Text('Kategori: $_category'),
                                  Text(
                                      'Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
                                  Text(
                                      'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  // Opsi: reset state juga
                                  setState(() {
                                    _title = "";
                                    _price = 0;
                                    _content = "";
                                    _category = null;
                                    _thumbnail = "";
                                    _isFeatured = false;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child:
                      const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
