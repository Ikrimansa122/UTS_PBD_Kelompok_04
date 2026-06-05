USE uts_pbd_kelompok_04;

DELIMITER //

CREATE PROCEDURE rekap_semua_nilai()
BEGIN

DECLARE selesai BOOLEAN DEFAULT FALSE;

DECLARE v_id INT;
DECLARE v_nim VARCHAR(15);
DECLARE v_kode_mk VARCHAR(10);

DECLARE v_tugas DECIMAL(5,2);
DECLARE v_kuis DECIMAL(5,2);
DECLARE v_uts DECIMAL(5,2);

DECLARE v_nilai_akhir DECIMAL(5,2);
DECLARE v_grade VARCHAR(2);
DECLARE v_bobot DECIMAL(3,2);
DECLARE v_status VARCHAR(20);

DECLARE cur CURSOR FOR
SELECT id_nilai,nim,kode_mk,
nilai_tugas,nilai_kuis,nilai_uts
FROM nilai_praktikum;

DECLARE CONTINUE HANDLER FOR NOT FOUND
SET selesai = TRUE;

OPEN cur;

ulang: LOOP

FETCH cur INTO
v_id,v_nim,v_kode_mk,
v_tugas,v_kuis,v_uts;

IF selesai THEN
LEAVE ulang;
END IF;

SET v_nilai_akhir =
(v_tugas * 0.30) +
(v_kuis * 0.30) +
(v_uts * 0.40);

IF v_nilai_akhir >= 93 THEN
SET v_grade='A'; SET v_bobot=4.00;
ELSEIF v_nilai_akhir >=85 THEN
SET v_grade='A-'; SET v_bobot=3.75;
ELSEIF v_nilai_akhir >=81 THEN
SET v_grade='B+'; SET v_bobot=3.50;
ELSEIF v_nilai_akhir >=75 THEN
SET v_grade='B'; SET v_bobot=3.25;
ELSEIF v_nilai_akhir >=71 THEN
SET v_grade='B-'; SET v_bobot=3.00;
ELSEIF v_nilai_akhir >=66 THEN
SET v_grade='C+'; SET v_bobot=2.75;
ELSEIF v_nilai_akhir >=61 THEN
SET v_grade='C'; SET v_bobot=2.50;
ELSEIF v_nilai_akhir >=56 THEN
SET v_grade='C-'; SET v_bobot=2.00;
ELSEIF v_nilai_akhir >=40 THEN
SET v_grade='D'; SET v_bobot=1.00;
ELSE
SET v_grade='E'; SET v_bobot=0.00;
END IF;

IF v_grade IN ('A','A-','B+','B','B-','C+','C') THEN
SET v_status='LULUS';
ELSE
SET v_status='TIDAK LULUS';
END IF;

UPDATE nilai_praktikum
SET nilai_akhir=v_nilai_akhir,
grade=v_grade,
bobot=v_bobot,
status_lulus=v_status
WHERE id_nilai=v_id;

INSERT INTO log_rekap_nilai(
nim,kode_mk,nilai_akhir,
grade,bobot,status_lulus,
keterangan,waktu_proses
)
VALUES(
v_nim,v_kode_mk,v_nilai_akhir,
v_grade,v_bobot,v_status,
'Rekap Semua Nilai',
NOW()
);

END LOOP;

CLOSE cur;

SELECT ROW_COUNT() AS jumlah_data_diproses;

END //

DELIMITER ;