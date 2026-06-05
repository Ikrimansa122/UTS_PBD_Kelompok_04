CREATE DATABASE uts_pbd_kelompok_04;
USE uts_pbd_kelompok_04;

CREATE TABLE dosen (
    kode_dosen VARCHAR(10) PRIMARY KEY,
    nama_dosen VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE mahasiswa (
    nim VARCHAR(15) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    kelas VARCHAR(20),
    angkatan YEAR
);

CREATE TABLE mata_kuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    semester INT,
    kode_dosen VARCHAR(10),
    FOREIGN KEY (kode_dosen)
    REFERENCES dosen(kode_dosen)
);

CREATE TABLE grade_nilai (
    grade VARCHAR(2) PRIMARY KEY,
    bobot DECIMAL(3,2),
    nilai_bawah DECIMAL(5,2),
    nilai_atas DECIMAL(5,2)
);

CREATE TABLE nilai_praktikum (
    id_nilai INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(15),
    kode_mk VARCHAR(10),
    nilai_tugas DECIMAL(5,2),
    nilai_kuis DECIMAL(5,2),
    nilai_uts DECIMAL(5,2),
    nilai_akhir DECIMAL(5,2),
    grade VARCHAR(2),
    bobot DECIMAL(3,2),
    status_lulus VARCHAR(20),

    FOREIGN KEY (nim)
    REFERENCES mahasiswa(nim),

    FOREIGN KEY (kode_mk)
    REFERENCES mata_kuliah(kode_mk),

    FOREIGN KEY (grade)
    REFERENCES grade_nilai(grade)
);

CREATE TABLE log_rekap_nilai (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(15),
    kode_mk VARCHAR(10),
    nilai_akhir DECIMAL(5,2),
    grade VARCHAR(2),
    bobot DECIMAL(3,2),
    status_lulus VARCHAR(20),
    keterangan VARCHAR(255),
    waktu_proses DATETIME DEFAULT CURRENT_TIMESTAMP
);