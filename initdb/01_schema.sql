CREATE SCHEMA IF NOT EXISTS SALAM AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS SALAM.mahasiswas (
    id BIGSERIAL PRIMARY KEY,
    nim CHAR(10) NOT NULL,
    nama_lengkap VARCHAR(150) NOT NULL,
    surel VARCHAR(160) NOT NULL,
    tahun_masuk INTEGER NOT NULL,
    indeks_prestasi NUMERIC(3,2) NOT NULL DEFAULT 0.00,
    dibuat_pada TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    diubah_pada TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unik_nim_mahasiswa UNIQUE (nim),
    CONSTRAINT unik_surel_mahasiswa UNIQUE (surel),
    CONSTRAINT format_nim_harus_valid CHECK (nim ~ '^[0-9]{10}$'),
    CONSTRAINT batas_ipk CHECK (indeks_prestasi BETWEEN 0.00 AND 4.00),
    CONSTRAINT rentang_tahun_masuk CHECK (tahun_masuk >= 2018 AND tahun_masuk <= 2030)
);

CREATE OR REPLACE FUNCTION SALAM.perbarui_diubah_pada() RETURNS TRIGGER AS $$
BEGIN
    NEW.diubah_pada := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_perbarui_mahasiswa ON SALAM.mahasiswas;

CREATE TRIGGER trg_perbarui_mahasiswa
BEFORE UPDATE ON SALAM.mahasiswas
FOR EACH ROW
EXECUTE FUNCTION SALAM.perbarui_diubah_pada();

INSERT INTO SALAM.mahasiswas (nim, nama_lengkap, surel, tahun_masuk, indeks_prestasi)
VALUES 
('2310456789', 'Rizky Ananda', 'rizky.ananda@example.com', 2021, 3.75),
('2310456790', 'Lestari Widya', 'lestari.widya@example.com', 2020, 3.40);
