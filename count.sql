use shop;

# 8. 집계함수와 그룹화

## 주문정보중 오늘 등록된 전체 주문 개수
-- CURRENT_TIMESTAMP: 현재 시각을 가져오는 함수
-- 오늘 0시 ~ 내일 0시 사이인지 확인하는 구문
-- str_to_date(substring(current_timestamp, 1, 10), '%Y-%m-%d'): 오늘 날짜의 자정
-- str_to_date(substring(current_timestamp + interval 1 day, 1, 10), '%Y-%m-%d'): 내일 날짜의 자정
select
    count(*)
from p_order
where
    str_to_date(substring(current_timestamp, 1, 10), '%Y-%m-%d') <= WT
    and WT < str_to_date(substring(current_timestamp + interval 1 day, 1, 10), '%Y-%m-%d');

## MOBILE 컬럼으로 개수
-- MOBILE 의 값이 NULL인 컬럼은 제외한 갯수가 출력됨
select count(MOBILE) from p_order;

## 컬럼값 별칭으로 지정하기
select count(*) as ordercount from p_order;

