use shop;

-- 회원목록 조회
SELECT * FROM member;
# * 은 테이블의 모든 컬럼을 선택한다는 약속된 키워드.

-- 원하는 열의 데이터만 가져오기
SELECT id, name, NICKNAME FROM member;
# 쿼리문의 모든 예약어와 객체 일므은 대소문자를 구분하지 않는다.

-- 테이블 구조 알아보기
desc member;
desc p_order;

/*
아하!ㅃ
여러줄 주석!!
*/

-- where절 사용
select
    id,
    name,
    nickname
from
    member
where id > 3;

select
    name,
    nickname,
    id,
    id
from
    member
where name = '라이언';

-- where절 + 고정된 값을 가진 컬럼을 추가.
select
    name,
    nickname,
    id,
    '친구들'
from
    member
where id >= 3;

select
    id, name
from member
where name <> nickname;

-- null 비교하기
select
    id,
    name,
    nickname
from
    member
where email is null;

select
    *
from
    member
where email is not null;

-- where절에 2개 이상의 비교조건식 사용하기
# 논리연산자로 결합해야 한다.

-- 한달동안 등록된 주문목록 보기
select
    *
from p_order
where
    '2021-03-01' <= wt # 시:분:초.000 은 자동 캐스팅(날짜타입 컬럼 비교이므로)
    and wt <= '2021-04-01'; # 월말 날짜보다 다음달 초로 제한하는게 조금 더 보기 쉬움

-- 배송비가 있는 상품 중 상품 개수가 1개인 주문
select
    *
from p_order
where
    DTDMONEY <> 0 # 0이 아닌 값을 찾게 되어있다. - 컬럼에 0 이상만 들어가도록 데이터 형을 양의정수로 잡거나 제약조건이 잘 설정되어있어야 한다.
    and P_NUM = 1;

-- 휴대폰 번호가 없거나 배송 주소가 없는 경우
select
    *
from p_order
where
    mobile is null
    or ADDRESS is null;

-- 배송비가 0원이 아닌 주문
select
    *
from p_order
where not(dtdmoney = 0);
select
    *
from p_order
where dtdmoney <> 0;

-- 2개 이상의 조건식을 NOT 연산자와 조합할 때(연산자 우선 순위에 따라 다르게 처리됨)
-- 배송비가 0원이거나 주문 상품 개수가 1개가 아닌 주문만 가져오기
select
    *
from p_order
where
    not (DTDMONEY <> 0 and P_NUM = 1); # not(DTDMONEY <> 0)not(and)not(P_NUM = 1) => 이렇게 처리된다.
# 괄호로 묶지 않으면 DTDMONEY <> 0의 not 그리고 P_NUM = 1 인 주문목록을 가져옴

select
    *
from p_order
where # not 없이
    DTDMONEY = 0 or P_NUM <> 1;

-- 날짜조건 지정하기
-- 오늘 자정부터 오늘밤 23시59분59초보다 작은 주문
select
    *
from p_order
where
    '2021-03-27 00:00:00' <= wt
#     and wt <= '2021-03-27 23:59:59';
    and wt < '2021-03-28 00:00:00';  # 밀리세컨드 단위를 고려한다면 이렇게 수정되야 맞다

-- 조건 패턴 매칭
-- 신상품 문자열이 포함된 상품 목록
select
    *
from product
where DESCRIPTION like '%신상품%';

select
    *
from product
where DESCRIPTION like '%신_상품%'; # 신상품 문자열 사이에 공백이나 기타 다른문자가 들어가있을때 이처럼 대응함.

select
    *
from product
where DESCRIPTION like '%2021%신상품%';
# 2개 이상의 키워드 단어가 모두 들어있는 문자열 검색에 사용
# 단 이경우 신상품이 앞에 2021이 뒤에 나오는 상품은 검색 결과에서 제외된다. - 문자열이 나오는 순서에 따라 키워드가 매칭된다

select
    *
from product
where DESCRIPTION like '생일%';
# 찾는 패턴 문자열로 시작하거나 끝나는 검색 결과를 찾으려면 %를 앞이나 뒤에 하나만 표시하면 된다.

-- 문자열 검색에 따옴표 사용하기
select
    *
from product
where DESCRIPTION like '%I''m back%';

-- %, _는 역슬래시와 조합해서 이스케이프 문자로 표현
select
    *
from product
where DESCRIPTION like '%2021%\%%';




