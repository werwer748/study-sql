use shop;

# 8. 집계함수와 그룹화

## 주문정보 테이블의 전체 합계금액 구하기 -> 모든 로우 수량 * 가격을 더함
select sum(P_SELL_PRICE * P_NUM) from p_order;

## 집계함수 여러 개 사용
select
    count(*) as '주문개수',
    sum(P_NUM) as '상품개수합계',
    sum(P_SELL_PRICE * P_NUM) as '매출합계'
from p_order;

## 매출합계 평균
select avg(P_SELL_PRICE * P_NUM) as '평단가' from p_order;
-- 풀어서 아래와 같이 쓸 수 있다.
select sum(P_SELL_PRICE * P_NUM) / count(*) as '평단가' from p_order;

## wishlist의 판매가 평균(가격 컬럼에 null이 들어가는 경우) -> 33083.3333 : count에 null도 포함하여 계산
select sum(P_SELL_PRICE) / count(*) as '평단가' from wishlist;
-- avg를 사용하면? -> 39700.0000 : null인 행은 계산에서 제외된다.
select avg(P_SELL_PRICE) as '평단가' from wishlist;
-- count에서 null을 제외하여 정확하게 구하기
select sum(P_SELL_PRICE) / count(P_SELL_PRICE) as '평단가' from wishlist;

## CASE 조건문을 사용해 NULL을 0으로 처리하여 값 구하기
select
    avg(
        case when P_SELL_PRICE is null then 0 else P_SELL_PRICE end
    ) as '평단가'
from wishlist;

## 주문정보 테이블에서 주문 합계 금액이 가장 큰 것과 가장 작은 금액 주문 최대 수량 구하기
select
    min(P_NUM * P_SELL_PRICE) as '최저주문액',
    max(P_NUM * P_SELL_PRICE) as '최고주문액',
    max(P_NUM) as '최대수량'
from
    p_order;

## 판매가 5만원 미만 상품중 가장 비싼 상품
select max(SELL_PRICE) from product where SELL_PRICE < 50000;
-- 위 조건 + 그 상품 이름
select
    max(SELL_PRICE) '상품가격',
    MAX(CASE WHEN SELL_PRICE = (SELECT MAX(SELL_PRICE) FROM product WHERE SELL_PRICE < 50000) THEN NAME END) AS '상품이름'
from product
where SELL_PRICE < 50000;




