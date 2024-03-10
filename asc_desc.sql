use shop;

# 데이터 정렬하기

# 이름으로 정렬
select * from member order by NAME;

-- 오름차순
select * from member order by NAME asc;
-- 내림차순
select * from member order by NAME desc;
-- 문장려 데이터의 우선순위에 따라 정렬확인
select * from member order by PW asc;

# 여러 기준 열로정렬하기
-- 왼쪽에서 오른쪽, 컬럼 한개에 대한 정렬 후 값이 같은 컬럼값에 대해 다음 컬럼의 정렬이 추가 적용되는 것
select * from member order by NAME asc, NICKNAME desc, age desc;
-- 오름차순정렬시 asc 생략, 정렬 적용 명확히 확인해보기
select * from member order by AGE, NAME desc, NICKNAME;

