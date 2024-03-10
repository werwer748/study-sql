use shop;

# 7. 결과 행 수 제한과 페이징

## LIMIT을 사용해 최근 날짜 기준 10행만 가져오기
-- 별도의 정렬이 없을 경우 테이블에 저장된 순서대로 최근행을 가져오게 됨
select * from sms order by WT desc limit 10;

# 결과 시작 행 위치 지정
-- limit절은 처음 행 위치부터 개수만큼, offset은 건너뛰는 행 수

## 최근날짜순의 발송 로그 데이터의 페이지당 10개 데이터의 2페이지
select * from sms order by WT desc limit 10, 10;
-- 쉼표 대신 offset을 사용
-- 오프셋 값이 없으면 0과 같이 취급
select * from sms order by WT desc limit 10 offset 10;

-- LIMIT은 ANSI SQL 표준 문법이 아님...
## 표준 문법으로 최근날짜기준 10행 가져오기 - FETCH FIRST, ROWS ONLY(mysql에서는 사용 못함)
# select * from sms order by WT desc FETCH FIRST 10 ROWS ONLY;
## 10개 페이지의 2 페이지 - OFFSET, ROWS FETCH NEXT, ROWS ONLY
# select * from sms order by WT desc OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

## Paging(페이징)
-- 페이징은 큰 데이터를 일정한 크기의 조각으로 쪼개서 현재 필요한 조각을 가져와 표시, 또는 사용하는 기법
-- 페이지번호 page, 페이지 1개에 가져오는 데이터 갯수를 pagesize라고 가정함(변수가 없어 실행할수는 없음)
# select * from sms order by WT limit pagesize offset (page - 1) * pagesize;
-- pagesize가 10이고 1페이지라면?
select * from sms order by WT limit 10 offset 0;
-- 다음페이지?
select * from sms order by WT limit 10 offset 10;
