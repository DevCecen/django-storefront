-- 1. ADIM: Bağımsız Tablolar (Hiçbir yere bağlı olmayanlar)
-- Önce Promosyonlar ve Koleksiyonlar (Kategoriler) oluşturulmalı.
-- (Collection içindeki featured_product_id şimdilik NULL bırakılır çünkü ürünler henüz ortada yok)

INSERT INTO store_promotion (id, description, discount) VALUES 
(1, 'Yaz İndirimi', 15.5),
(2, 'Black Friday', 40.0),
(3, 'Yeni Üye Fırsatı', 10.0);

INSERT INTO store_collection (id, title, featured_product_id) VALUES 
(1, 'Elektronik', NULL),
(2, 'Giyim', NULL),
(3, 'Ev ve Yaşam', NULL);

-- 2. ADIM: 1. Derece Bağımlı Tablolar (Koleksiyonlara ve Müşterilere bağlı olanlar)
-- Artık Koleksiyonlarımız olduğu için Ürünleri (Product), Müşterilerimiz olduğu için Adres ve Siparişleri (Order) ekleyebiliriz.

INSERT INTO store_product (id, title, slug, description, unit_price, inventory, collection_id) VALUES 
(1, 'MacBook Pro', 'macbook-pro', 'M2 Çipli harika bilgisayar', 1999.99, 50, 1),
(2, 'iPhone 15', 'iphone-15', 'Son model akıllı telefon', 999.99, 150, 1),
(3, 'Erkek T-Shirt', 'erkek-tshirt', 'Yüzde yüz pamuk', 19.99, 300, 2),
(4, 'Kadın Kot Pantolon', 'kadin-kot-pantolon', 'Mavi renk dar kesim', 39.99, 200, 2),
(5, 'Kahve Makinesi', 'kahve-makinesi', 'Filtre kahve makinesi', 89.99, 45, 3);

-- Adresler (Doğrudan customer_id'ye bağlı - Sende 1, 2, 3 ID'li müşteriler olduğu için onlara bağlıyoruz)
INSERT INTO store_address (customer_id, street, city) VALUES 
(1, 'Ataturk Caddesi No:1', 'Istanbul'),
(2, 'Cumhuriyet Bulvari No:45', 'Ankara'),
(3, 'İstiklal Sokak No:12', 'Izmir');

-- Siparişler (Sende 10, 15 ve 20 numaralı müşterilerin olduğunu varsayarak rastgele onlara sipariş atıyoruz)
-- Tarih formatı PostgreSQL için standarttır.
INSERT INTO store_order (id, placed_at, payment_status, customer_id) VALUES 
(1, '2026-04-07 10:30:00', 'C', 10),
(2, '2026-04-07 11:15:00', 'P', 15),
(3, '2026-04-07 14:45:00', 'F', 20);

-- Sepetler (Cart tablosunun kimseye bağımlılığı yok, direkt oluşturulur)
INSERT INTO store_cart (id, created_at) VALUES 
(1, '2026-04-07 09:00:00'),
(2, '2026-04-07 09:15:00');


-- 3. ADIM: 2. Derece Bağımlı Tablolar (Ürünlere ve Siparişlere bağlı olanlar)
-- Sipariş Kalemleri (OrderItems), Sepet Kalemleri (CartItems) ve Ürün-Promosyon İlişkisi (ManyToMany)

-- Hangi siparişte hangi ürünlerden kaç tane alınmış?
INSERT INTO store_orderitem (id, order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 1, 1, 1999.99), -- 1 nolu siparişte 1 tane MacBook Pro
(2, 1, 3, 2, 19.99),   -- 1 nolu siparişte 2 tane T-Shirt
(3, 2, 2, 1, 999.99),  -- 2 nolu siparişte 1 tane iPhone
(4, 3, 5, 1, 89.99);   -- 3 nolu siparişte 1 tane Kahve Makinesi

-- Hangi sepette hangi ürün var?
INSERT INTO store_cartitem (id, cart_id, product_id, quantity) VALUES 
(1, 1, 4, 3), -- 1 nolu sepette 3 tane Pantolon
(2, 2, 1, 1); -- 2 nolu sepette 1 tane MacBook

-- ManyToMany İlişkisi (Hangi ürünlerde hangi promosyonlar geçerli?)
-- Django bu tabloyu senin yerine arka planda oluşturur: store_product_promotions
INSERT INTO store_product_promotions (id, product_id, promotion_id) VALUES 
(1, 1, 1), -- MacBook için Yaz İndirimi geçerli
(2, 3, 2), -- T-Shirt için Black Friday geçerli
(3, 2, 3); -- iPhone için Yeni Üye Fırsatı geçerli

-- 4. ADIM (OPSİYONEL GÜNCELLEME): Koleksiyonların Vitrin Ürünlerini (featured_product) belirleme
UPDATE store_collection SET featured_product_id = 1 WHERE id = 1;
UPDATE store_collection SET featured_product_id = 4 WHERE id = 2;