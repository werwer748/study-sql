-- select	
select * from member;
select id, name from member;
select id, name from member where id=1;
select * from member where id > 3;

-- null
select id, name from member where address is null;
select * from p_order where p_option is not null;
select * from p_order where p_option = '';

-- and/or
select * from p_order where substring(wt,0,10) >= '2021-03-01' and p_code = 2;
select * from p_order where p_num > 1 and userid = '1';
select * from qna where p_code = 1 or p_code = 2;
select * from p_order where substring(wt,0,10) > '2021-01-01' and (p_code = 1 or p_code = 2);

-- like
select * from member where name like '어%';
select * from p_order where address like '%강남구%';
select * from product where p_name like '파우치';
select * from product where p_name like '%필로우_';
select * from qna where content like '%\%%';

-- '
select * from qna where title like 'It''s your ''role''';



-- order by
select * from member order by name asc;
select * from member order by name asc, age desc;
select * from product order by sell_price desc;
select * from p_order order by wt desc;
select * from product order by madein asc, maker desc, name asc;
/*null ordering*/

-- paging
select * from p_order order by wt desc limit 20;/*mysql, postgresql*/
select top 20 * from p_order order by wt desc;/*mssql*/
select * from p_order order by wt desc FETCH FIRST 20 ROWS ONLY;/*mssql 12 over*/
select * from p_order order by wt desc FETCH FIRST 20 ROWS ONLY; /*oracle 12c over*/
select * from p_order order by wt desc limit 20 offset 20;/*mysql, postgresql*/
select top 20 * from p_order order by wt desc not in (select top 20 * from p_order order by wt desc);/*mssql 12 over*/
select * from p_order order by wt desc OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY;/*mssql*/
select * from p_order order by wt desc OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY; /*oracle 12c over*/



-- calculate, operator
select (p_sell_price * p_num) as price_sum from p_order;
select sum(p_num) as num_sum from p_order group by userid;
select (p_sell_price * p_num) as price_sum from p_order;
select sum(p_num) "수량합계" from p_order group by userid;
select (p_sell_price * p_num) as price_sum from p_order where (p_sell_price * p_num) > 30000;
select (p_sell_price * p_num) as price_sum from p_order where price_sum > 30000;
select (p_sell_price * p_num) as price_sum from p_order where price_sum > 30000 order by price_num desc;
/*null calc check*/

/*clause processing order*/



function
sum()
count(), avg(), min(), max(), round(), abs()
truncate(), sin(), cos(), sqrt(), log()

-- string calc
select '' + '';/*mssql*/
select '' || '';/*oracle, postgresql*/
select concat('', '');/*mysql*/
select '' + 15;/*mssql*/
select '' || 15;/*oracle, postgresql*/
select concat('', 15);/*mysql*/
/*열 문자열들을 하나로 합치기*/

-- substring
select substring('SQL서브스트링',1 , 4);
select substr('SQL서브스트링',1 , 4);

-- trim
select trim('  문자열 트림        ');
select ltrim('  문자열 트림        ');
select rtrim('  문자열 트림        ');
SELECT TRIM( '.,! ' FROM  '     #     test    .') AS Result;/*mssql, oracle*/
SELECT TRIM( BOTH '.,! ' FROM  '     #     test    .') AS Result;/*oracle leading, trailing*/


-- string length
select character_length('  문자열 트림        ');
select octet_length('  문자열 트림        ');/*ansi, mysql*/
select octet_length('문자열a');/*ansi, mysql*/
select bit_length('문자열a');/*ansi, mysql*/
select char_length('문자열a');/*character_length()와 같음*//*ansi, mysql*/
select length('  문자열 트림        ');/*oracle*/
select lengthhb('  문자열 트림        ');/*oracle*/

-- datetime
select current_timestamp; /* ansi standard*/
select current_date; /*?*/
select getdate(); /*mssql*/
select now(); /*mysql*/
select sysdate(); /*oracle*/
select to_date('2021-03-01');
select substring(wt, 0, 10) as orderdate from p_order;
select to_date('2021-03-01','YYYY-MM-DD');/*oracle*/
select cast('2021-03-01' as datetime);
datediff()
wt + interval 1 day
select date_add(now(), interval -1 year);/*mysql*/
SELECT DATEADD(year, 1, wt) from p_order;/*mssql*/



-- case
case when then else end
case when then end
case when then when then else end
coalesce() /*null이 아닌 첫번째 파라메터 반환*/
nvl(), isnull()
select coalesce(p_num, 1) from p_order;
case condition when then when then end
null condition
no else case statement

--  중복 없는 선택
select distinct p_code from p_order where wt >= '2020-03-01';



--  insert
insert into member values ('어피치', 'Djvlcl1@','어피치','12345','경기도 성남시 분당구 판교동 1','010-1234-5678','apeach@kakao.com',3);
insert into member (name, pw, nickname, zipcode, address, mobile, email, age) values ('어피치', 'Djvlcl1@','어피치','12345','경기도 성남시 분당구 판교동 1','010-1234-5678','apeach@kakao.com', 3);
insert into member (name, pw, nickname) values ('어피치', 'Djvlcl1@','어피치');
insert into member (name, pw) values ('어피치', 'Djvlcl1@');
insert into member (name, pw, nickname,mobile) values ('어피치', 'Djvlcl1@','어피치',null);

-- delete
delete from member where id = 1;
delete from member;

-- update
update product set sell_price = 3500 where id = 1;
update p_order set dtdmoney = 5500 where wt >= '2021-03-02' and address like '제주%';
update p_order set coupon = 3 where coupon is null and wt = '2021-03-02';
update p_order set coupon = 3;
update product set sell_price = sell_price - 500;
update product set sell_price = 34500, image_l = 'large/newproduct.jpg', image_b = 'big/newproduct.jpg', image_m = 'middle/newproduct.jpg', image_s = 'small/newproduct.jpg' where id = 4;
-- 적용순서로 인한 문제
update product set sell_price = sell_price + 10000, sell_price = purchase_price + 5000;
update product set purchase_price = purchase_price + 5000, sell_price = purchase_price + 10000;
update wishlist set p_option = null where p_code = 2;



--  행 개수 구하기
count()
select count(id) from member;
select count(id) from product where sell_price > 30000;
select count(id) from review;
select count(id) from review where rating < 3;
select distinct count(p_code), count(distinct p_code) from p_order where wt >= '2021-03-01' and wt <= '2021-03-31';

--  열의 합 구하기
sum()
select count(id), sum(p_num) from p_order where wt >= '2021-03-01' and wt <= '2021-03-31';

--  avg()
select count(id), avg(p_num) from p_order where wt >= '2021-03-01' and wt <= '2021-03-31';/*null 에 대한 평균값 반영 여부 체크*/
select count(id), avg(p_sell_price)/avg(p_num), avg(p_num), sum(p_num)/count(p_num) from p_order where wt >= '2021-03-01' and wt <= '2021-03-31';/*null 에 대한 평균값 반영 여부 체크*/
select count(id), avg(age), avg(case when age is null then 0 else age end) from member;

--  min(), max()
select min(age), max(age) from member;
select max(p_num) from p_order where p_code = 3;



--  group by
select p_code from p_order group by p_code;
select p_code, sum(p_num) from p_order group by p_code;
select p_code, count(id) from qna group by p_code;
select p_code, userid, count(id) from p_order group by p_code, userid;

--  having // where->group by->having->select->order by
select p_code, count(p_num) from p_order where p_code = 1 group by p_code;
select p_code, count(p_num) from p_order group by p_code having count(p_num) > 1 order by count(p_num) desc;
select p_code, count(p_num) as sumcount from p_order group by p_code having count(p_num) > 1 order by sumcount desc;
select userid, p_code, count(p_num) as sumcount from p_order group by userid, p_code order by userid asc, p_code asc;



--  subquery
update product set sell = 'N' where id = (select p_code from p_order where COUPON = 3);
delete from qna where userid = (select id from member where email is null);
select * from p_order where p_code = (select id from product where madein = 'korea');
select (select count(id) from member) as mcount, (select count(distinct userid) from p_order) as ocount;
select (select count(id) from member) as mcount, (select count(distinct userid) from p_order) as ocount from dual;/*oracle*/

update p_order set p_sell_price = (select sell_price from product where id = 2) where p_code = 2;
update mypoint set point = (select sum(p_sell_price * p_num) * 0.1 as point from p_order group by userid);

select * from (select userid, sum(p_num) as sum from p_order where p_code = 2 group by userid order by sum) tbl where sum > 10 order by userid asc;/*서브쿼리 결과의 조건 결과*/

insert into stat (ym, userid, buysum) select substring(wt,0,7) as ym, userid, sum(p_sell_price * p_num) as buysum from p_order group by substring(wt,0,7);
insert into stat (ym, userid, buysum) select '2021-03', 3, 0;
insert into mycoupon (userid, couponid) select distinct userid, 12 as couponid from p_order where wt > DATE_ADD(now(), interval -1 month);

--  exists
update member set dormancy = 'Y' where exists (select a.id from (select id from member where lastlogin < '2020-03-01') a);
update member set dormancy = 'Y' where not exists (select a.id from (select * from member where lastlogin < DATE_ADD(now(), interval -1 year)) a);
update mypoint set point = 0 where not exists (select distinct userid from p_order where wt >= DATE_ADD(now(), interval -12 month));
delete from review a where not exists (select userid from p_order b where a.p_code = b.p_code and a.userid = b.userid);/*상관 서브 쿼리*/

--  in
select * from member where id in (select userid from qna where substring(wt,0,10) >= substring(now(), 0, 0));/*null 주의*/
select * from product where id in (1,2);
select * from product where id in (select p_code from p_order where wt >= DATE_ADD(now(), interval -1 day));



--  create table
show tables from shop;
show columns from log;
DESCRIBE log;

CREATE TABLE log(
	id INT NOT NULL,
	userid BIGINT NOT NULL,
	wt DATE
);

--  drop table
DROP TABLE log;

--  alter table
alter table log add p_code bigint;
alter table log add url varchar(255) not null default '';
alter table log modify url varchar(100) null default '';
alter table log change wt visit datetime;
alter table log drop url;

--  constraint 컬럼 제약 조건 설정
alter table log add constraint pkey_log primary key(id);
alter table log drop constraint pkey_log;/*mssql oracle*/
alter table log drop primary key;
alter table log add p_code bigint not null;

create table log(
	id INT NOT NULL,
	userid BIGINT NOT NULL,
	wt DATE,
	constraint pkey_log primary key(id)
);

--  pk, fk 삭제 처리
SHOW CREATE TABLE product;
ALTER TABLE product MODIFY id INT NOT NULL;
ALTER TABLE product DROP PRIMARY KEY;
ALTER TABLE product DROP FOREIGN KEY product_ibfk_1;
ALTER TABLE  product DROP PRIMARY KEY, ADD PRIMARY KEY (  `id` );



--  index
create index i_product on product(name);
create index i_product2 on product(maker);
drop index i_product on product;
drop index i_product2 on product;
explain select * from product where name = '쿠션';
explain select * from product where name like '%쿠션';
explain select * from product where id > 2;


--  view
create view v_product_korea as select * from product where madein = 'korea';
drop view v_product_korea;
select * from v_product_korea where sell_price > 20000;
select * from (select * from product where madein = 'korea') a where sell_price > 20000;



--  union
/*오늘 리뷰와 q&a글만 모아서 보기*/
(select userid, title, content, 0 as rating from qna where substring(wt,0,10) = substring(now(),0,10))
union all
(select userid, title, content, rating from review where substring(wt,0,10) = substring(now(),0,10)) order by userid;

/*장바구니와 찜해놓기 합친 결과*/
select userid, p_code, p_sell_price, a.p_option from basket a left join product b on a.p_code = b.id
union
select userid, p_code, p_sell_price, a.p_option from wishlist a left join product b on a.p_code = b.id;

select b.name from p_order a left join product b on a.p_code = b.id where a.userid = '라이언' or a.userid = '어피치';
select a.*, b.name from p_order a left join member b on a.userid = b.id where substring(wt,0,10) > '2021-03-01';

--  inner join
select * from product, inventory;
select * from product, inventory where product.id = inventory.p_code;
select * from product a, inventory b where a.id = b.p_code and a.category = 101;

select * from product a inner join inventory b on a.id = b.p_code and a.category = 101;
select a.id, a.name, sum(b.point), sum(c.p_sell_price*p_num) from member a inner join mypoint b on a.id = b.userid inner join p_order c on a.id = c.userid group by a.id;

--  outer join //null data join
select a.*, b.name, b.mobile from p_order a left join member b on a.userid = b.id;
select b.*, a.point from mypoint a right join member b on a.userid = b.id;
select a.*, b.name from product a left join maker b on a.maker = b.id;
select * from product a left join inventory b on a.id = b.p_code and a.category = 101;



--  transaction
START TRANSACTION;
insert into p_order (userid, p_code, p_num, p_sell_price, p_option, dtdmoney, mobile, address, zipcode) 
values (3, 2, 2, 25000, '블루', 2500, 010-1234-5678, '경기도 성남시 분당구 판교동 1', '12345');
update inventory, (select p_code, p_num from basket where userid = 3) a set stock = stock - p_num where inventory.p_code = a.p_code ;
delete from basket where userid = 3;
COMMIT;
ROLLBACK;



--  스토어드 프로시져
/*품절상품목록*/
DELIMITER $$ /*기본 구분자 $$로 변경*/
create procedure sp_getOutOfStock()
begin
	select a.id, a.name, b.stock from product a left join inventory b on a.id = b.p_code where b.stock = 0;
end$$
DELIMITER ; /*구분자 ;로 복구*/
show warnings; /*mysql 전용?*/
call sp_getOutOfStock();
drop procedure if exists sp_getOutOfStock;
/*최저재고랑이하상품목록*/
DELIMITER $$ /*기본 구분자 $$로 변경*/
create procedure sp_warnOutOfStock(IN minstock int unsigned)
begin
	select a.id, a.name, b.stock from product a left join inventory b on a.id = b.pcode where b.stock < minstock;
end$$
DELIMITER ; /*구분자 ;로 복구*/
/*특정상품월매출합*/
DELIMITER $$
create procedure sp_getTotalSaleProduct(IN pcode bigint, IN salemonth varchar(7), OUT sum int unsigned)
begin
	select sum(p_sell_price*p_num) into sum  from p_order where p_code = pcode and wt like concat(salemonth,'%');
end$$
DELIMITER ;

set @sum = 0;
select sum(p_sell_price*p_num) into @sum  from p_order where p_code = 1 and wt like '2021-03%';


call sp_getTotalSaleProduct(3, @sum);
select sum;

/*회원아이디최대값*/
DELIMITER $$ /*기본 구분자 $$로 변경*/
create procedure sp_getMaxId(INOUT maxid bigint)
begin
	select max(id) into maxid from member;
end$$
DELIMITER ; /*구분자 ;로 복구*/
set @maxid = 5;
call sp_getMaxId(@maxid);

call sp_getTotalSaleProduct(3, @sum);
select sum;
/*구매탑3아이디만*/
DELIMITER $$
create procedure sp_getTop3SaleVip()
begin
	declare ids varchar(100) default '';
    declare done int default 0;
    declare userid bigint default 0;
    declare summoney int default 0;
	declare result cursor for select id, sum(p_sell_price*p_num) as sum from p_order order by sum desc limit 3;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    open result;
    
    cursorloop:loop
		if done = true then
			leave cursorloop;
        end if;
		fetch result into userid, summoney;
		set ids = concat(ids, userid, ',');
	end loop cursorloop;
    close result;
	select ids;
end$$
DELIMITER ;

/*홀수합*/
DELIMITER $$
set @num = 10;
create procedure sp_oddList10(IN num int)
begin
	declare odds varchar(100) default '';
	declare count int default 1;
	repeat
		if count % 2 = 0 then
			set odds = concat(odds, ',', count);
		end if;
	until count <= num
	end repeat;
	select odds;
end$$
DELIMITER ;

/*더미데이터 삽입*/
delimiter $$
CREATE PROCEDURE insertdummy()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO visitor (visit, userid, ip, url) VALUES (now(), i%5, '255.255.255.255', '/mypage/orderlist?2021-03-01');
        SET i = i + 1;
    END WHILE;
END$$
delimiter ;

call insertdummy();
drop procedure if exists insertdummy;

select * from visitor;
delete from visitor;


--  커서
delimiter $$
create procedure getOrderList()
begin
	declare username varchar(30) default '';
	declare p_num integer default 0;
	declare done integer default 0;
	declare msg varchar(100) default '';

	DECLARE result cursor for select b.name as username, p_num from p_order a left join member b on a.userid = b.id where p_code = 3;
	declare continue handler for not found set done = 1;

	open result;
	getInfo: LOOP
	fetch result into username, p_num;
	if done = 1 then
		leave getInfo;
	else
		set msg = concat(msg, username, ' 회원이 ', p_num, '개 주문\n');
	end if;
	END LOOP getInfo;
	close result;
end$$
delimiter ;




--  트리거
/*주문 등록시 sms 발송 등록*/
delimiter $$
create trigger tr_after_insert_Regist_Sms
	after insert
	on p_order for each row
	begin
		insert into sms (mobile, content) values (NEW.mobile,'주문이 접수되었습니다.');
	end$$
delimiter ;

/*닉네임 입력 여부 체크해서 대체 적용*/
delimiter $$
create trigger tr_after_insert_check_nickname
	after insert on member for each row
	begin
		if new.nickname = '' then
			set new.nickname = new.name;
		end if;
	end$$
delimiter ;

show triggers from shop;
show triggers from shop where table = 'member';
drop trigger if exists shop.tr_after_insert_regist_sms;

/*카테고리 매핑*/
delimiter $$
create trigger tr_before_insert_map_category
	before insert on product for each row
	begin
		if new.category = '103' then
			set new.category = '109';
		end if;
	end$$
delimiter ;

delimiter $$
create trigger tr_after_insert_product
	after insert on product for each row
	begin
		insert into inventory (p_code, stock) values(new.id, 0);
	end $$
delimiter ;
delimiter $$
create trigger tr_after_insert_order
	after insert on p_order for each row
	begin
		update inventory set stock = stock - new.p_num;
	end $$
delimiter ;

/*주문취소후재고복구*/
delimiter $$
create trigger tr_after_update_order
	after update on p_order for each row
	begin
		if NEW.cancel = 'C' then
			update inventory set stock = stock + OLD.p_num;
			update p_order set cancel = 'Y' where id = OLD.id;
		end if;
	end $$
delimiter ;
	
delimiter $$
create trigger tr_before_delete_product
	before delete on product for each row
	begin
		declare msg varchar(255);
		declare remain int default 0;
		select stock into remain from inventory where OLD.id = p_code;
		if remain = 0 then
			delete from inventory where p_code = OLD.id;
		else
			set msg = '재고남음';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		end if;
	end $$
delimiter ;


--  시퀀스
CREATE TABLE IF NOT EXISTS friends (
  ID bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NAME varchar(30) NOT NULL,
  PW varchar(30) NOT NULL
);
insert into friends (name, pw) values ('어피치','1234@');
insert into friends (name, pw) values('라이언','abcd#');
update friends set id = 3 where id = 1;
delete from friends where id = 1;
update friends set id = 5 where id = 3;
insert into friends (name, pw) values ('라이언','abcd#');


CREATE TABLE IF NOT EXISTS friends (
  ID varchar(8) NOT NULL PRIMARY KEY,
  NAME varchar(30) NOT NULL,
  PW varchar(30) NOT NULL
);
/*문자열아이디반환시퀀스*/
DROP TRIGGER IF EXISTS insert_seq;
DELIMITER $$
CREATE TRIGGER insert_seq
BEFORE INSERT ON friends
FOR EACH ROW
BEGIN
	DECLARE seqid INT;
	SET seqid = (SELECT COUNT(*) FROM friends);
	SET NEW.ID = CONCAT('KAKAO', LPAD(seqid+1, 3, '0'));
END$$
DELIMITER ;
insert into friends (name, pw) values ('어피치','1234@');


	
--  백업과 복원
mysqldump -u root -p shop > C:\Backup\shop_20210308_01.sql /*mysql*/
mysqldump -u root -p –no-data shop > C:\Backup\shop_schema_20210308_01.sql /*mysql*/
mysql -u root -p shop < C:\Backup\shop_20210308_01.sql

/*mssql*/
DECLARE @name NVARCHAR(256);
/*db*/
set @name='c:\DBBackup\shop_' + CONVERT(VARCHAR(8), GETDATE(), 112) + '_' + right ('00'+ltrim(str( DATENAME(hh, GETDATE()))),2 ) + right ('00'+ltrim(str( DATENAME(mi, GETDATE()))),2 ) + right ('00'+ltrim(str( DATENAME(ss, GETDATE()))),2 ) + '.bak';
Backup Database newmsoul To Disk = @name;
/*log*/
set @name='c:\DBBackup\shop_' + CONVERT(VARCHAR(8), GETDATE(), 112) + '_' + right ('00'+ltrim(str( DATENAME(hh, GETDATE()))),2 ) + right ('00'+ltrim(str( DATENAME(mi, GETDATE()))),2 ) + right ('00'+ltrim(str( DATENAME(ss, GETDATE()))),2 ) + '.trn';
Backup LOG newmsoul To Disk = @name;

/*oracle with recovery manager RMAN*/
rman target /
CONFIGURE CHANNEL DEVICE TYPE DISK clear;
show all;
run {
	allocate channel disk1 device type disk format 'c:\_download\FULL_%d_%T_%s_%p.bak';
	backup database plus archivelog;
	release channel disk1;
}