use shopshop;

CREATE TABLE CartItem (
   id int primary key auto_increment,
   user_id int,
   variant_id int,
   quantity int
);