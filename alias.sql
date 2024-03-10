use shop;

# 컬럼에 별칭 사용하기 - 결과값의 재사용을 위해서...
select id, address as recipient_address from p_order;
-- 한글도 사용 가능
select id as 주문키, address as 배송주소 from p_order;

# 테이블 이름에 별칭 사용
select * from p_order as po where po.WT >= '2023-11-25 00:00:00:000';
-- join시 편하게 사용가능한 것이 장점
-- 별칭없이
select
    p_order.ID as 주문코드,
    product.ID as 상품코드
from
    p_order
left join
        product on p_order.P_CODE = product.ID
where p_order.WT >= '2021-03-01';

-- 별칭사용
select
    po.ID as 주문코드,
    p.ID as 상품코드
from
    p_order as po
left join
        product as p
            on po.P_CODE = p.ID
where po.WT >= '2021-03-01';
