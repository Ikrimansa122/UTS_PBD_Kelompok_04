# UTS_PBD_Kelompok_04

# Sistem Rekap Nilai Praktikum Mahasiswa

## Mata Kuliah

**Pemrograman Basis Data**

## Dosen Pengampu

**Abdul Malik, S.Kom., M.Cs.**

---

# Deskripsi Sistem

Sistem Rekap Nilai Praktikum Mahasiswa merupakan aplikasi basis data sederhana yang dibangun menggunakan **MySQL** melalui **XAMPP/phpMyAdmin**.

Sistem ini digunakan untuk:

* Menyimpan data mahasiswa
* Menyimpan data dosen
* Menyimpan data mata kuliah
* Menyimpan data nilai praktikum mahasiswa
* Menghitung nilai akhir mahasiswa secara otomatis
* Menentukan grade nilai
* Menentukan bobot nilai
* Menentukan status kelulusan
* Menyimpan riwayat hasil rekap nilai ke dalam tabel log

Proyek ini dibuat untuk memenuhi tugas **Ujian Tengah Semester (UTS)** pada mata kuliah **Pemrograman Basis Data**.

---

# Anggota Kelompok

| No | Nama                   | NIM       |
| -- | ---------------------- | --------- |
| 1  | Ikrimansa              | IK2411021 |
| 2  | Aulia                  | IK2411008 |
| 3  | Tiara Nuriani          | IK2411024 |
| 4  | Nadya Pratiwi Riswanto | IK2411049 |
| 5  | Magfakhrani            | IK2411050 |

---

# Struktur Tabel

## 1. Tabel Mahasiswa

| Field    | Tipe Data    |
| -------- | ------------ |
| nim      | VARCHAR(15)  |
| nama     | VARCHAR(100) |
| kelas    | VARCHAR(20)  |
| angkatan | YEAR         |

**Primary Key:** `nim`

---

## 2. Tabel Dosen

| Field      | Tipe Data    |
| ---------- | ------------ |
| kode_dosen | VARCHAR(10)  |
| nama_dosen | VARCHAR(100) |
| email      | VARCHAR(100) |

**Primary Key:** `kode_dosen`

---

## 3. Tabel Mata Kuliah

| Field      | Tipe Data    |
| ---------- | ------------ |
| kode_mk    | VARCHAR(10)  |
| nama_mk    | VARCHAR(100) |
| sks        | INT          |
| semester   | INT          |
| kode_dosen | VARCHAR(10)  |

**Primary Key:** `kode_mk`

**Foreign Key:**

* `kode_dosen` → `dosen.kode_dosen`

---

## 4. Tabel Grade Nilai

| Field       | Tipe Data    |
| ----------- | ------------ |
| grade       | VARCHAR(2)   |
| bobot       | DECIMAL(3,2) |
| nilai_bawah | DECIMAL(5,2) |
| nilai_atas  | DECIMAL(5,2) |

**Primary Key:** `grade`

---

## 5. Tabel Nilai Praktikum

| Field        | Tipe Data          |
| ------------ | ------------------ |
| id_nilai     | INT AUTO_INCREMENT |
| nim          | VARCHAR(15)        |
| kode_mk      | VARCHAR(10)        |
| nilai_tugas  | DECIMAL(5,2)       |
| nilai_kuis   | DECIMAL(5,2)       |
| nilai_uts    | DECIMAL(5,2)       |
| nilai_akhir  | DECIMAL(5,2)       |
| grade        | VARCHAR(2)         |
| bobot        | DECIMAL(3,2)       |
| status_lulus | VARCHAR(20)        |

**Primary Key:** `id_nilai`

**Foreign Key:**

* `nim` → `mahasiswa.nim`
* `kode_mk` → `mata_kuliah.kode_mk`
* `grade` → `grade_nilai.grade`

---

## 6. Tabel Log Rekap Nilai

| Field        | Tipe Data          |
| ------------ | ------------------ |
| id_log       | INT AUTO_INCREMENT |
| nim          | VARCHAR(15)        |
| kode_mk      | VARCHAR(10)        |
| nilai_akhir  | DECIMAL(5,2)       |
| grade        | VARCHAR(2)         |
| bobot        | DECIMAL(3,2)       |
| status_lulus | VARCHAR(20)        |
| keterangan   | VARCHAR(255)       |
| waktu_proses | DATETIME           |

**Primary Key:** `id_log`

---

# Relasi Antar Tabel

```text
DOSEN
  |
  | 1 : N
  v
MATA_KULIAH
  |
  | 1 : N
  v
NILAI_PRAKTIKUM
 ^            ^
 |            |
 | N : 1      | N : 1
 |            |
MAHASISWA   GRADE_NILAI

NILAI_PRAKTIKUM --> LOG_REKAP_NILAI
```

---

# Rumus Perhitungan Nilai Akhir

```sql
nilai_akhir =
(nilai_tugas * 0.30) +
(nilai_kuis * 0.30) +
(nilai_uts * 0.40)
```

### Contoh Perhitungan

```text
Nilai Tugas : 80
Nilai Kuis  : 85
Nilai UTS   : 90
```

Hasil:

```text
Nilai Akhir : 85.50
Grade       : A-
Bobot       : 3.75
Status      : LULUS
```

---

# Daftar Stored Procedure

## 1. rekap_semua_nilai()

### Fungsi

* Menghitung nilai akhir seluruh mahasiswa
* Menentukan grade
* Menentukan bobot nilai
* Menentukan status kelulusan
* Menyimpan hasil rekap ke tabel `log_rekap_nilai`

### Pemanggilan

```sql
CALL rekap_semua_nilai();
```

---

## 2. rekap_nilai_per_mk()

### Fungsi

* Menghitung nilai mahasiswa berdasarkan mata kuliah tertentu
* Menggunakan parameter kode mata kuliah

### Pemanggilan

```sql
CALL rekap_nilai_per_mk('MK001');
```

---

# Konsep Pemrograman Basis Data yang Digunakan

## 1. Variabel

Digunakan untuk menyimpan sementara nilai tugas, nilai kuis, nilai UTS, dan nilai akhir mahasiswa.

## 2. Percabangan

Menggunakan:

```sql
IF
ELSEIF
ELSE
```

atau

```sql
CASE
```

untuk menentukan grade, bobot nilai, dan status kelulusan.

## 3. Perulangan

Menggunakan:

```sql
LOOP
WHILE
REPEAT
```

untuk memproses data mahasiswa secara berulang.

## 4. Implicit Cursor

Menggunakan:

```sql
ROW_COUNT();
```

untuk mengetahui jumlah data yang berhasil diproses.

## 5. Explicit Cursor

Menggunakan:

```sql
DECLARE CURSOR
OPEN
FETCH
CLOSE
```

untuk membaca data pada tabel `nilai_praktikum` satu per satu.

## 6. Cursor dengan Parameter

Menggunakan parameter:

```sql
kode_mk
```

untuk memfilter mata kuliah yang akan direkap.

---

# Cara Menjalankan Program

## 1. Membuat Database

```sql
CREATE DATABASE uts_pbd_kelompok_04;
```

## 2. Mengimpor File

Import file berikut:

* `database.sql`
* `data_awal.sql`
* `procedure_rekap_nilai.sql`

## 3. Menjalankan Query Pengujian

```sql
SELECT * FROM mahasiswa;
SELECT * FROM dosen;
SELECT * FROM mata_kuliah;
SELECT * FROM grade_nilai;
SELECT * FROM nilai_praktikum;
SELECT * FROM log_rekap_nilai;
```

## 4. Menjalankan Stored Procedure

```sql
CALL rekap_semua_nilai();
```

atau

```sql
CALL rekap_nilai_per_mk('MK001');
```

---

# Screenshot Hasil Program

Lampirkan screenshot berikut:

1. Struktur Database
2. Struktur Tabel
3. Data Mahasiswa
4. Data Dosen
5. Data Mata Kuliah
6. Data Grade Nilai
7. Data Nilai Praktikum
8. Hasil Stored Procedure
9. Tabel Log Rekap Nilai
10. Relasi Antar Tabel

---

# Pembagian Tugas Kelompok

| Anggota   | Tanggung Jawab                                             |
| --------- | ---------------------------------------------------------- |
| Anggota 1 | Pembuatan database, tabel, relasi, dan data awal           |
| Anggota 2 | Variabel dan perhitungan nilai akhir                       |
| Anggota 3 | Percabangan grade, bobot, status kelulusan, dan perulangan |
| Anggota 4 | Cursor dan log rekap nilai                                 |
| Anggota 5 | Dokumentasi, laporan, GitHub, dan pengujian program        |

---

# Kesimpulan

Proyek **Sistem Rekap Nilai Praktikum Mahasiswa** berhasil dikembangkan menggunakan MySQL dengan menerapkan berbagai konsep Pemrograman Basis Data, seperti variabel, percabangan, perulangan, implicit cursor, explicit cursor, cursor dengan parameter, serta stored procedure.

Sistem mampu menghitung nilai akhir mahasiswa secara otomatis, menentukan grade dan bobot nilai, menetapkan status kelulusan, serta menyimpan riwayat hasil rekap nilai ke dalam tabel log. Dengan demikian, proses pengolahan nilai praktikum menjadi lebih cepat, akurat, dan terstruktur.
