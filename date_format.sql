use shop;

# 날짜 연산

## STR_TO_DATE(날짜 문자열, 문자열 날짜 포맷) 문자열 => 날짜
select '15/09/13';
select STR_TO_DATE('15/09/13', '%d/%m/%y');

## DATE_FORMAT(날짜객체/컬럼, 포맷)
## CURRENT_TIMESTAMP, NOW(), SYSDATE() 현재 시각 알기
select date_format(current_timestamp, '%d/%m/%y');
select now();

### 현재 시각에 1년을 더한 날짜
## interval 더할숫자 기간타입(year, month, day, hours, minutes..)
select current_timestamp + interval 1 year;
### 현재 시각에 1년을 빼기 날짜
select current_timestamp - interval 1 year;

### 두 날짜 사이의 일수차이 구하기
## DATEDIFF(param1, param2) => param1 - param2의 일수 반환 param2가 클경우 음수
select datediff(str_to_date('2024-03-14', '%Y-%m-%d'), current_timestamp); # -54
## 문자열 비교로 일 수 차이 구하기
select datediff('2024-05-07', '2024-03-01'); # 67

## 오늘날짜 예제 구현을 위해 업데이트
update p_order
set
    WT = current_timestamp - interval 6 day
where ID > 5;
### 오늘부터 일주일 전까지의 주문정보 + 날짜의 차이
select
    *,
    datediff(current_timestamp, WT) as datediff
from p_order
where datediff(current_timestamp, WT) < 7