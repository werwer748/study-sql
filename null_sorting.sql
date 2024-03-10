use shop;

# null 정렬 기준
## 널은 특별 취급되어 예외처리를 하게 됨 - DB종류에 따라 처리 방법이 다름
### MySQL은 널 값을 가장 작은 값으로 예외 처리를 한다.
select * from member order by NICKNAME; -- nickname이 null일 로우가 제일 위로 올라옴
