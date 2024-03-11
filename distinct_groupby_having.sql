use shop;

# 8. 집계함수와 그룹화

## 주문정보에서 중복되는 회원 제거한 회원 수
select count(distinct USERID) as userid from p_order;

## 상품 코드 목록을 중복없이 가져오기
select P_CODE from p_order group by P_CODE;
-- distinct로 목록 가져오기
select distinct P_CODE from p_order;

## 상품 코드별로 주문개수가 몇개인지, 총 상품 합계가 얼마인지 구하기 그리고 합계 수량을 기준으로 내림차순 정렬
select
    P_CODE as '상품코드',
    count(P_CODE) as '주문개수',
    sum(P_NUM) as '합계수량'
from p_order
group by P_CODE; -- 그룹화 컬럼으로 p_code 지정
-- ORDER BY절로 정렬하기
select
    P_CODE as '상품코드',
    count(P_CODE) as '주문개수',
    sum(P_NUM) as '합계수량'
from p_order
group by P_CODE
order by 합계수량 desc;
-- WHERE에 월 단위 조건까지 설정하기
select
    P_CODE as '상품코드',
    count(P_CODE) as '주문개수',
    sum(P_NUM) as '합계수량'
from p_order
where
    str_to_date('2021-03-01', '%Y-%m-%d') <= WT
#     and WT < str_to_date(date_add('2021-03-01', interval 1 month), '%Y-%m-%d')
    and WT < str_to_date('2021-04-01', '%Y-%m-%d')
group by P_CODE
order by 합계수량 desc;

SELECT str_to_date('2021-03-01', '%Y-%m-%d');
select str_to_date(date_add('2021-03-01', interval 1 month), '%Y-%m-%d'); -- 2021-04-01

## 주문 상품의 집계 합계가 1보다 큰 상품만 가져오기
select
    P_CODE as 상품코드,
    count(P_CODE) as 주문개수,
    sum(P_NUM) as 합계수량
from p_order
-- where SUM(P_NUM) > 1 -- 에러발생: 집계 함수를 HAVING절에 사용하거나 하위 쿼리로 집계를 구한것이 아니면 WHERE절에 집계함수를 사용할 수 없다.
group by P_CODE;

/*
## SELECT문의 각 절 실행 순서
# WHERE > GROUP BY > SELECT > ORDER BY

SELECT절에서 값을 얻는 집계 함수는 GROUP BY절로 그룹 단위로 행들을 묶은 후에 가능합니다.
GROUP BY절로 그룹화를 하지 않은 데이터에 집계 함수를 사용할 수는 없습니다.
따라서 가장 먼저 실행되는 WHERE절에는 집계 함수를 사용할 수 없습니다.

HAVING절은 GROUP BY절 실행 후 실행되는 부가 조건절입니다.
GROUP BY절 전용의 WHERE절로 이해하면 되며, GROUP BY절이 없으면 HAVING절은 사용할 수 없습니다.
테이블 자체에 조건절 비교를 하려면 WHERE절에 조건식을 표현하고,
집계된 결과 테이블에 조건절 비교를 하려면 HAVING절을 사용한다고 생각하면 됩니다.
HAVING절이 있는 SELECT문의 실행 순서는 다음과 같아집니다.

WHERE >  GROUP BY > HAVING > SELECT > ORDER BY
*/
-- HAVING을 이용해 에러가 발생한 쿼리문 수정
select
    P_CODE as 상품코드,
    count(P_CODE) as 주문개수,
    sum(P_NUM) as 합계수량
from p_order
group by P_CODE
having sum(P_NUM) > 1;
-- HAVING절에 별칭
select
    P_CODE as 상품코드,
    count(P_CODE) as 주문개수,
    sum(P_NUM) as 합계수량
from p_order
group by P_CODE
having 합계수량 > 1;
-- MySQL은 group by 실행뒤에 having절 실행에 앞서 select절의 별칭이 매핑이 되기 떄문에 컬림이름이 정상 인식된다. 다른 db는 안됨.

## 복수열로 그룹화
SELECT
    ID,
    MOBILE,
    P_CODE AS '상품코드',
    SUM(P_NUM) AS '합계수량'
FROM p_order
GROUP BY ID, MOBILE, P_CODE; -- 여기에 ID, MOBILE빠지면 정상작동하지 않음
SELECT
    MAX(ID) AS ID,
    MAX(MOBILE) AS MOBILE,
    P_CODE AS '상품코드',
    SUM(P_NUM) AS '합계수량'
FROM p_order
GROUP BY P_CODE;  -- 컬럼별 꼼수..