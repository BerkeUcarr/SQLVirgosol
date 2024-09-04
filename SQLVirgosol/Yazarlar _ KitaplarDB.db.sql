-- kitaplar veritabanındaki tüm verileri tablo halinde çektik
SELECT *  FROM kitaplar; 

-- yazarlar veritabanındaki tüm verileri tablo halinde çektik
SELECT * FROM yazarlar; 

-- Sadece yazar ismi ve soyismini çektik
SELECT yazar_isim, soyisim From yazarlar; 

-- ismi orhan olan veriyi getir
SELECT * FROM yazarlar WHERE 
yazar_isim='orhan'; 

-- ismi orhan olana 1 olmayana 0 yazdırır
SELECT yazar_isim='orhan' FROM yazarlar; 

-- birden fazla olan veriyi silip bütün verileri tek bir kere yazdırır
SELECT DISTINCT yazar_isim FROM yazarlar; 

-- logic AND kullanımı
SELECT * FROM kitaplar WHERE 
yil='2002' AND fiyat=25; 

-- ismi orhan veya isa olanların sadece isim ve yaşını listeledik
SELECT yazar_isim, yas FROM yazarlar WHERE 
yazar_isim='orhan' OR yazar_isim='isa'; 

-- yas ismini yazarın_yası olarak çevirdik
SELECT yazar_isim, soyisim, yas AS 'yazarın_yası' FROM yazarlar; 

-- yazar adı ve soyadını birleştirip tek bir ad soyad olarak yazdırıp listeledik
SELECT yazar_isim||' '||soyisim AS 'ad soyad', yas FROM yazarlar; 

-- yazarlar db'inde o harfi ile başlayan yazarları listele
SELECT * FROM yazarlar WHERE 
yazar_isim LIKE 'O%';

-- sayfasayılarını 200 ile 400 arasındakileri listele
SELECT kitap_isim, sayfa FROM kitaplar WHERE 
sayfa BETWEEN 200 AND 400;

-- kitap adı x olan kitabı veritabanından çektik
SELECT * FROM kitaplar WHERE 
kitap_isim='sakli ev' OR 
kitap_isim='son moda' Or 
kitap_isim='bir umut';

-- başka şekilde yapacak olursak
SELECT * FROM kitaplar WHERE 
kitap_isim IN ('sakli ev', 'son moda', 'bir umut');

-- kitap ismi s veya b ile başlayanları listele
SELECT * FROM kitaplar WHERE 
kitap_isim LIKE 's%' OR 
kitap_isim LIKE 'b%';

-- (adı orhan ve soyadı erdem) veya (adı ekrem ve id 1) id soyisim ve isim olarak listele 
SELECT id, soyisim, yazar_isim FROM yazarlar WHERE 
(yazar_isim='orhan' AND soyisim='erdem') OR 
(yazar_isim='ekrem' AND id=1);

-- basım yılı 2007 veya 2008 olıp fiyatı 12 lira olan kitabı listeliyoruz
SELECT * FROM kitaplar WHERE
(yil=2007 OR yil=2008) AND
fiyat=12;

-- basım yılı 1990 2005 arası olan kitapları listele
SELECT * FROM kitaplar WHERE yil BETWEEN 
1990 AND 2005;

-- basım yılı 1990 2005 arasında ve fiyatı 20den fazla olan kitapları listele
SELECT * FROM kitaplar WHERE
(yil BETWEEN 1990 AND 2005) AND 
fiyat > 20;

-- kitapları fiyata göre listeledik
SELECT * FROM kitaplar order by fiyat;

-- yazar ismini alfabetik olarak sırala
SELECT yazar_isim, soyisim FROM yazarlar ORDER BY yazar_isim, soyisim;

-- fiyatı 15ten fazla olan kitapları sayfa sayısı küçükten büyüğe doğru sırala
SELECT * FROM kitaplar WHERE 
fiyat > 15 ORDER BY
sayfa ASC; 

-- Kitaplar tablosundaki ilk 3 kayıtı listele
SELECT * FROM kitaplar LIMIT 3;

-- ilk 3 kaydın kitap adı, sayfa ve fiyat bilgisini (fiyat ismini fiyat_bilgisi olarak) listele
SELECT kitap_isim, sayfa, fiyat AS 'fiyat_bilgisi' from kitaplar LIMIT 3;

-- sayfa sayısı en fazla olan kitabı listele
SELECT * FROM kitaplar ORDER BY sayfa DESC LIMIT 1;

-- sayfa sayısı en fazla olan kitabı listele
SELECT kitap_isim, yil, MAX(sayfa), fiyat FROM kitaplar;

-- en genç yazarı listele
SELECT * from yazarlar ORDER BY yas ASC LIMIT 1;

-- en genç yazarı listele
SELECT yazar_isim, soyisim, MIN(yas) AS 'yas' From yazarlar;

-- orhanların en yaşlısını yazdır
SELECT * From yazarlar WHERE
yazar_isim='orhan' ORDER BY yas DESC LIMIT 1;

-- soyadının ikinci harfi e olan yazarı listele
SELECT * FROM yazarlar WHERE
soyisim LIKE '_e%';

-- kitapları yazarid'ye göre sırala
SELECT * from kitaplar ORDER BY yazarid;

-- kitapları her sorgulamada farklı olacak şekilde rastgele listele
SELECT * FROM kitaplar ORDER BY random();

-- yazarlar tablosuna kemal uyumaz adlı yazarı ekle
INSERT INTO yazarlar (id, yazar_isim, soyisim, yas) VALUES (5, 'kemal', 'uyumaz', 31);

-- ekleyip eklemediğini kontrol ediyoruz
SELECT * FROM yazarlar WHERE yazar_isim LIKE '%kemal%';

-- soyisim eklemeden veritabanına yazar ekle
INSERT INTO yazarlar (id, yazar_isim, yas) VALUES (6, 'mehmet', 60);

-- (id 7 yas 29 çağlar üzümcü)
-- (id 8 yas 34 leyla alagöz)
-- (id 9 yas 32 ayşe bektaş) tek sorguda ekleme
INSERT INTO yazarlar (id, yazar_isim, soyisim, yas) VALUES 
(7, 'çağlar', 'üzümcü', 29), 
(8, 'leyla', 'alagöz', 34), 
(9, 'ayşe', 'bektaş', 32);

-- kitaplar tablosundaki bir satırın kitap_isim ve id alanlarını demo tablosundaki name ve hint alanlarına yazdırma
SELECT name, hint FROM demo;

INSERT INTO demo (name, hint) SELECT id, kitap_isim FROM kitaplar LIMIT 1;

-- demo tablosunda name kolonu delete olan satırın hint kolonundaki açıklamayı "Silme işlemi yapar" olarak güncelle
UPDATE demo SET hint='Silme işlemi yapar' WHERE
name='DELETE';

SELECT hint FROM demo WHERE name='DELETE';

-- demo tablosunda name kolonu içinde sql terimi geçen tüm satırların hint alanını sql terimi içerir şeklinde güncelle
UPDATE demo SET hint='sql terimi içerir' WHERE name LIKE '%sql%';

SELECT hint, name FROM demo WHERE name LIKE '%sql%';

-- demo tablosundaki hint alanındaki tüm değerlere 95 yazdırın sonrasında 5 arttırın
UPDATE demo SET hint= 95;
UPDATE demo SET hint=hint+5;
SELECT hint from demo;

-- demo tablosundaki 12 ve 17 numaralı idleri önce listele sonra sil
SELECT * FROM demo WHERE id IN (12,17);
DELETE FROM demo WHERE id IN (12,17);