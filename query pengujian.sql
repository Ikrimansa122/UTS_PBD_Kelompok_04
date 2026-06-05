USE uts_pbd_kelompok_04;

SELECT * FROM mahasiswa;
SELECT * FROM dosen;
SELECT * FROM mata_kuliah;
SELECT * FROM grade_nilai;
SELECT * FROM nilai_praktikum;
SELECT * FROM log_rekap_nilai;

CALL rekap_semua_nilai();

SELECT * FROM nilai_praktikum;
SELECT * FROM log_rekap_nilai;

SELECT COUNT(*) AS jumlah_lulus
FROM nilai_praktikum
WHERE status_lulus='LULUS';

SELECT COUNT(*) AS jumlah_tidak_lulus
FROM nilai_praktikum
WHERE status_lulus='TIDAK LULUS';

SELECT kode_mk,
AVG(nilai_akhir) AS rata_rata_nilai
FROM nilai_praktikum
GROUP BY kode_mk;