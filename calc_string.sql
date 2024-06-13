use shop;

# 9. 데이터 타입과 연산하기
## 문자열 연산

## 문자열 길이
select char_length('hello'); -- character_length()와 같음, 표준 SQL 함수명은 char_length
-- 컬럼 문자길이
select
    char_length(NICKNAME)
from member;

## 문자열 바이트수 확인해보기
select octet_length('한글1글자당길이 1증가. alphabet과 공백도 1씩 증가'); -- 표준 SQL 함수명은 octet_length
select length('안녕하세요. 한글입니다.'); -- octet_length축약형

## 문자열 앞뒤의 공백 제거
select trim(' 앞에 공백이 있고 뒤도 공백이 있는 문자열 '); ##결과를 비교해 볼것
select ltrim(' 앞에 공백만 제거 ');
select rtrim(' 뒤에 공백만 제거 ');
select ' 앞에 공백이 있고 뒤도 공백이 있는 문자열 ';

## 문자열의 일부만 가져오기
select substring('This is a string!', 4, 3); -- 4번째 위치에서부터 3개의 문자를 가져오기

## 문자열 합기치
select concat('문자열', ' 합치기');

## 배송지, 우편번호 합치기
select
    concat(ADDRESS, '[', ZIPCODE, ']') as '배송주소'
from p_order
where ADDRESS is not null;

## 구분자를 이용해 문자열을 하나로 합치기
select concat_ws(',', '주문일', '주문자', '합계금액', '배송주소');
select concat_ws(' ', '피카츄', '라이츄', '파이리', '꼬부기');

## 주문정보를 csv 파일로 저장하기 위해 주문 행을 쉼표로 구분한 문자열로 생성
## 컬럼 데이터 안에 쉼표가 있는 경우를 대비해 큰 따옴표로 각 열을 감싸서 안전한 CSV 파일을 생성
select
    concat(
    '"',
    concat_ws('", "', ID, P_CODE, P_NUM, MOBILE, ADDRESS, ZIPCODE),
    '"'
    ) as csvrow
from p_order
where CANCEL <> 'Y';




