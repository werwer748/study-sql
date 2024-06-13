use shop;

# 9. 데이터 타입과 연산하기
## 컬럼 값 연산

## 주문 합계 금액
select
    ID,
    P_SELL_PRICE,
    P_NUM,
    P_SELL_PRICE * P_NUM as sum
from p_order order by WT desc;
-- sum을 한글로
select
    ID,
    P_SELL_PRICE,
    P_NUM,
    P_SELL_PRICE * P_NUM as "합계"
from p_order order by WT desc;

## where절에 컬럼 연산 결과를 검색 조건으로 설정하기
-- 주문합계금액이 30000원 이상인 주문 찾기
select * from p_order where P_SELL_PRICE * P_NUM >= 30000;
-- 조건을 추가하여 찾아보기
select
    *,
    P_SELL_PRICE * P_NUM as `합계`
from p_order
where P_SELL_PRICE * P_NUM >= 30000
and WT >= '2021-03-14'
and WT < '2021-03-15';

## order by 절에 컬럼 계산 결과를 기준으로 정렬
select
    *,
    P_SELL_PRICE * P_NUM as `합계`
from p_order
order by P_SELL_PRICE * P_NUM desc;

