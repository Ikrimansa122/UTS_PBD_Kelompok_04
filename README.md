# Sistem Rekap Nilai Praktikum Mahasiswa

## Nama Kelompok

Kelompok 04

---

## Daftar Anggota

| No | Nama                   | NIM       |
| -- | ---------------------- | --------- |
| 1  | Ikrimansa              | IK2411021 |
| 2  | Aulia                  | IK2411008 |
| 3  | Tiara Nuriani          | IK2411024 |
| 4  | Nadya Pratiwi Riswanto | IK2411049 |
| 5  | Magfakhrani            | IK2411050 |

---

## Deskripsi Sistem

Sistem Rekap Nilai Praktikum Mahasiswa merupakan aplikasi basis data yang dibuat menggunakan MySQL melalui XAMPP/phpMyAdmin.

Fungsi sistem:

* Menyimpan data mahasiswa
* Menyimpan data dosen
* Menyimpan data mata kuliah
* Menyimpan data nilai praktikum
* Menghitung nilai akhir mahasiswa
* Menentukan grade nilai
* Menentukan bobot nilai
* Menentukan status kelulusan
* Menyimpan hasil rekap ke tabel log

---

## Struktur Tabel

### Tabel Mahasiswa

| Field    | Tipe Data    |
| -------- | ------------ |
| nim      | VARCHAR(15)  |
| nama     | VARCHAR(100) |
| kelas    | VARCHAR(20)  |
| angkatan | YEAR         |

### Tabel Dosen

| Field      | Tipe Data    |
| ---------- | ------------ |
| kode_dosen | VARCHAR(10)  |
| nama_dosen | VARCHAR(100) |
| email      | VARCHAR(100) |

### Tabel Mata Kuliah

| Field      | Tipe Data    |
| ---------- | ------------ |
| kode_mk    | VARCHAR(10)  |
| nama_mk    | VARCHAR(100) |
| sks        | INT          |
| semester   | INT          |
| kode_dosen | VARCHAR(10)  |

### Tabel Grade Nilai

| Field       | Tipe Data    |
| ----------- | ------------ |
| grade       | VARCHAR(2)   |
| bobot       | DECIMAL(3,2) |
| nilai_bawah | DECIMAL(5,2) |
| nilai_atas  | DECIMAL(5,2) |

### Tabel Nilai Praktikum

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

### Tabel Log Rekap Nilai

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

---

## Cara Menjalankan Program

### 1. Membuat Database

```sql
CREATE DATABASE uts_pbd_kelompok_04;
```

### 2. Import File

* database.sql
* data_awal.sql
* procedure_rekap_nilai.sql

### 3. Jalankan Query Pengujian

```sql
SELECT * FROM mahasiswa;
SELECT * FROM dosen;
SELECT * FROM mata_kuliah;
SELECT * FROM grade_nilai;
SELECT * FROM nilai_praktikum;
SELECT * FROM log_rekap_nilai;
```

### 4. Jalankan Stored Procedure

```sql
CALL rekap_semua_nilai();
```

atau

```sql
CALL rekap_nilai_per_mk('MK001');
```

---

## Daftar Stored Procedure

### 1. rekap_semua_nilai()

Fungsi:

* Menghitung nilai akhir seluruh mahasiswa
* Menentukan grade
* Menentukan bobot
* Menentukan status kelulusan
* Menyimpan hasil ke log rekap nilai

Pemanggilan:

```sql
CALL rekap_semua_nilai();
```

### 2. rekap_nilai_per_mk()

Fungsi:

* Rekap nilai berdasarkan mata kuliah tertentu

Pemanggilan:

```sql
CALL rekap_nilai_per_mk('MK001');
```

---

## Pembagian Tugas Anggota

| Anggota                 | Tugas                                       |
| ---------               | ------------------------------------------- |
| Ikrimansa               | Database, tabel, relasi, data awal          |
| Aulia                   | Variabel dan perhitungan nilai akhir        |
| Nadya Pratiwi Riswanto  | Percabangan, grade, bobot, status kelulusan |
| Magfakhrani Nur Fauzia  | Cursor dan log rekap nilai                  |
|Tiara Nuriani            | Dokumentasi, GitHub, laporan dan pengujian  |

---

## Screenshot Hasil Program

Tambahkan screenshot berikut:

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
