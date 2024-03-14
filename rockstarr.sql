-- -- -- Sınıf tablosu
--  CREATE TABLE sinif (
--      sinif_id SERIAL PRIMARY KEY,
--     sinif_ad VARCHAR(50) NOT NULL
--  );

-- -- -- Ders tablosu
--  CREATE TABLE ders (
--      ders_id SERIAL PRIMARY KEY,
--      ders_ad VARCHAR(50) NOT NULL
--  );

-- -- -- Okul tablosu
--  CREATE TABLE okul (
--      okul_id SERIAL PRIMARY KEY,
--      okul_ad VARCHAR(100) NOT NULL,
--      adres VARCHAR(200)
--  );

-- -- -- Öğretmen tablosu
--  CREATE TABLE ogretmen (
--      ogretmen_id SERIAL PRIMARY KEY,
--      ad VARCHAR(50) NOT NULL,
--      soyad VARCHAR(50) NOT NULL,
--      email VARCHAR(100),
--      telefon VARCHAR(20)
--  );

-- -- Öğrenci tablosu
--  CREATE TABLE ogrenci (
--      ogrenci_id SERIAL PRIMARY KEY,
--      ad VARCHAR(50) NOT NULL,
--      soyad VARCHAR(50) NOT NULL,
--      dogum_tarihi DATE,
--      cinsiyet CHAR(1),
--     sinif_id INT REFERENCES sinif(sinif_id)
--  );

 -- Many-to-many ilişkisi için bağlantı tablosu (ders-öğrenci)
--  CREATE TABLE ders_ogrenci (
--      ders_id INT REFERENCES ders(ders_id),
--      ogrenci_id INT REFERENCES ogrenci(ogrenci_id),
--      PRIMARY KEY (ders_id, ogrenci_id)
--  );

-- -- Many-to-one ilişkisi için bağlantı alanları (ders-okul)
--  ALTER TABLE ders
--  ADD COLUMN okul_id INT REFERENCES okul(okul_id);

-- -- Many-to-one ilişkisi için bağlantı alanları (ders-öğretmen)
 --ALTER TABLE ders
 --ADD COLUMN ogretmen_id INT REFERENCES ogretmen(ogretmen_id);
 
 -- -- Many-to-one ilişkisi için bağlantı alanları (ogrenci-okul)
--ALTER TABLE ogrenci
--ADD COLUMN okul_id INT;

-- -- Many-to-one ilişkisi için bağlantı alanları (ders-sinif)
-- ALTER TABLE ders
-- ADD COLUMN sinif_id INT;


 
--select * from ders_ogrenci

-- INSERT INTO sinif (sinif_ad) VALUES 
-- ('10-A'),
-- ('10-B'),
-- ('11-A'),
-- ('11-B'),
-- ('12-A');

-- INSERT INTO okul (okul_ad, adres) VALUES 
-- ('Atatürk Lisesi', 'Ankara'),
-- ('Çankaya Anadolu Lisesi', 'İstanbul'),
-- ('Fen Lisesi', 'İzmir'),
-- ('Özel Şehir Koleji', 'Bursa'),
-- ('Galatasaray Lisesi', 'İstanbul');

-- INSERT INTO ogretmen (ad, soyad, email, telefon) VALUES 
-- ('Ahmet', 'Yılmaz', 'ahmet@example.com', '555-123-4567'),
-- ('Ayşe', 'Kaya', 'ayse@example.com', '555-987-6543'),
-- ('Mehmet', 'Öztürk', 'mehmet@example.com', '555-234-5678'),
-- ('Fatma', 'Demir', 'fatma@example.com', '555-876-5432'),
-- ('Mustafa', 'Koç', 'mustafa@example.com', '555-345-6789');

-- INSERT INTO ogrenci (ad, soyad, dogum_tarihi, cinsiyet, sinif_id) VALUES 
-- ('Ali', 'Yılmaz', '2005-03-15', 'E', 1),
-- ('Ayşe', 'Demir', '2006-06-20', 'K', 2),
-- ('Fatma', 'Kaya', '2005-01-10', 'K', 1),
-- ('Mehmet', 'Aksoy', '2004-08-25', 'E', 3),
-- ('Zeynep', 'Öztürk', '2006-11-30', 'K', 2);

-- INSERT INTO ders (ders_ad, okul_id, ogretmen_id) VALUES 
-- ('Matematik', 1, 1),
-- ('Fizik', 1, 2),
-- ('Kimya', 2, 3),
-- ('Tarih', 2, 4),
-- ('Biyoloji', 3, 5);


-- insert into ders_ogrenci (ders_id, ogrenci_id) values
-- (14, 5), -- Matematik dersinin ders_id'si 11, Ali'nin ogrenci_id'si 1
-- (15, 5); -- Tarih dersinin ders_id'si 14, Ali'nin ogrenci_id'si 1


--SELECT COUNT(*) AS kayitli_ders_sayisi
--FROM ders_ogrenci
--WHERE ogrenci_id = (SELECT ogrenci_id FROM ogrenci WHERE ad = 'Fatma' AND soyad = 'Kaya');
--(öğrencinin kaç derse kayıtlı olup olmadığını göster)

--SELECT COUNT(*) AS ogrenci_sayisi
--FROM ders_ogrenci
--WHERE ders_id = (SELECT ders_id FROM ders WHERE ders_ad = 'Matematik');
--(belirli bir dersin kaç öğrenci tarafından alındığını gösterir)



-- SELECT s.sinif_ad, COUNT(dog.ogrenci_id) AS ogrenci_sayisi
-- FROM sinif s
-- JOIN ogrenci o ON s.sinif_id = o.sinif_id
-- JOIN ders_ogrenci dog ON o.ogrenci_id = dog.ogrenci_id
-- JOIN ders d ON dog.ders_id = d.ders_id
-- WHERE d.ders_ad = 'Kimya'
-- GROUP BY s.sinif_ad;
--(belirli bir dersin alındığı sınıfları ve bu sınıflardaki öğrenci sayılarını bulmaya yöneliktir. )

--SELECT ogretmen.ad, ogretmen.soyad, ders.ders_ad, okul.okul_ad
--FROM ogretmen
--JOIN ders ON ogretmen.ogretmen_id = ders.ogretmen_id
--JOIN okul ON ders.okul_id = okul.okul_id;
--(Bir öğretmenin hangi dersleri verdiğini ve hangi okulda çalıştığını bulma)

--SELECT COUNT(ogrenci_id) AS ogrenci_sayisi
--FROM ders_ogrenci
--WHERE ders_id = (SELECT ders_id FROM ders WHERE ders_ad = 'Biyoloji');
--(Bir okuldaki belirli bir derse kayıtlı olan öğrenci sayısını bulma)

--SELECT ders.ders_ad
--FROM ders_ogrenci
--JOIN ders ON ders_ogrenci.ders_id = ders.ders_id
--JOIN ogrenci ON ders_ogrenci.ogrenci_id = ogrenci.ogrenci_id
--WHERE ogrenci.ad = 'Zeynep' AND ogrenci.soyad = 'Öztürk';
--(bir öğrencinin hangi derse kayıtlı olduğunu bulma)

--SELECT s.sinif_ad, d.ders_ad
--FROM ders d
--JOIN ders_ogrenci dog ON d.ders_id = dog.ders_id
--JOIN ogrenci o ON dog.ogrenci_id = o.ogrenci_id
--JOIN sinif s ON o.sinif_id = s.sinif_id
--WHERE o.ad = 'Ali' AND o.soyad = 'Yılmaz';
--(Belirli bir öğrencinin hangi sınıfta olduğunu ve bu sınıfta aldığı dersleri bulmak için)

--SELECT s.sinif_ad, COUNT(o.ogrenci_id) AS ogrenci_sayisi
--FROM sinif s
--LEFT JOIN ogrenci o ON s.sinif_id = o.sinif_id
--GROUP BY s.sinif_ad
--ORDER BY COUNT(o.ogrenci_id) DESC
--LIMIT 1;
--(en fazla öğrenciye sahip olan sınıfı bulmak)

--SELECT s.sinif_ad, COUNT(o.ogrenci_id) AS ogrenci_sayisi
--FROM sinif s
--LEFT JOIN ogrenci o ON s.sinif_id = o.sinif_id
--GROUP BY s.sinif_ad;
--(her sınıfın toplam öğrenci sayısını bulan bir sorgu)


--SELECT o.ad, o.soyad, COUNT(d.ders_id) AS verilen_ders_sayisi
--FROM ogretmen o
--LEFT JOIN ders d ON o.ogretmen_id = d.ogretmen_id
--GROUP BY o.ad, o.soyad
--ORDER BY COUNT(d.ders_id) DESC;
--(her öğretmenin verdiği ders sayısı)
 
--SELECT o.ad, o.soyad
--FROM ogrenci o
--JOIN ders_ogrenci dog ON o.ogrenci_id = dog.ogrenci_id
--JOIN ders d ON dog.ders_id = d.ders_id
--WHERE d.ders_ad = 'Matematik' AND o.ogrenci_id = '1';
--(Öğrencinin belirli dersi alıp almadığını kontro eder)

--Select * from ders

--SELECT dogum_tarihi
--FROM ogrenci
--WHERE ad = 'Ali' AND soyad = 'Yılmaz';
--(istenilen öğrencinin doğum tarihini yazdıran sorgu)

--SELECT cinsiyet, COUNT(*) AS ogrenci_sayisi
--FROM ogrenci
--GROUP BY cinsiyet;
--(öğrencilerin cinsiyetlerinin kaç kız kaç erkek olduğunu yazdıran)

--SELECT *
--FROM okul
--WHERE adres = 'İstanbul';
--(belirli bir adresde bulunan okuları listeleyen sorgu)

--SELECT okul_ad, adres
--FROM okul
--WHERE okul_ad = 'Atatürk Lisesi';
--(hangi okulun hangi adresde oduğunu yazdıran sorgu)


--SELECT ogrenci.ad, ogrenci.soyad, okul.okul_ad
--FROM ogrenci, okul
--WHERE ogrenci.okul_id = okul.okul_id;

--(hangi öğrencinin hangi okula gittiğini gösteren sorgu)

-- SELECT email
-- FROM ogretmen
-- WHERE ad = 'Mustafa' AND soyad = 'Koç';

--(istenilen öğretmenin e-mailini yazdıran sorgu)

--SELECT ogretmen.ad, ogretmen.soyad, sinif.sinif_ad
--FROM ders
--INNER JOIN ogretmen ON ders.ogretmen_id = ogretmen.ogretmen_id
--INNER JOIN sinif ON ders.sinif_id = sinif.sinif_id;

--(hangi öğretmenin hangi sınıfa derse girdiğini yazdıran sorgu)


-- CREATE VIEW ogrenci_view AS
-- SELECT ad,soyad,cinsiyet
-- FROM ogrenci
-- WHERE cinsiyet='E';

--SELECT * FROM ogrenci_view;

--(Cinsiyeti erkek olan öğrencilerin ismini yazdır )

--CREATE VIEW ogretmen_email_view AS
--SELECT email
--FROM ogretmen
--WHERE ogretmen_id > 2;

--SELECT * FROM ogretmen_email_view;
--(id si 2 den büyük olan ogretmenlerin e-mailini yazdıran program)

--  CREATE VIEW ders_view2 AS
--  SELECT ders_ad,okul_id
--  FROM ders
--  WHERE okul_id=2;

--SELECT * FROM ders_view2; 

--(okul id si 2 olan derslerin isimlerini yazdır)

-- CREATE OR REPLACE FUNCTION ogrenci_ekleme_trigger_function()
-- RETURNS TRIGGER AS $$
-- BEGIN

--      IF NEW.ad = 'Ahmet' THEN
         
--         INSERT INTO log_table (message) VALUES ('Yeni öğrenci eklendi: Ahmet');
--      END IF;
    
--      RETURN NEW;
--  END;
--  $$ LANGUAGE plpgsql;

--  CREATE TRIGGER ogrenci_ekleme_trigger
--  AFTER INSERT ON ogrenci
--  FOR EACH ROW
--  EXECUTE FUNCTION ogrenci_ekleme_trigger_function();

--SELECT * FROM log_table

--CREATE TABLE log_table (
    --id SERIAL PRIMARY KEY,
    --message TEXT
--);
