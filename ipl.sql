SELECT * FROM new_schema.ipl;
# how many run scored by V Kohali in His 50th,100th, and last match
select t.* from(
select concat('match-',row_number() over(order by ID)) sino,
sum(batsman_run),
sum(sum(batsman_run))over(rows between unbounded preceding and current row) totalrun  from new_schema.ipl
where batter='V Kohli'
group by ID) t
where t.sino='match-50' or t.sino='match-100' or sino='match-141';


# who score hight run in whole ipl
select batter,sum(batsman_run) totalrun from new_schema.ipl
group by batter
order by totalrun desc
limit 5;

# who score highest run team wise ?
select t.* from (
select  batter,BattingTeam,sum(batsman_run) totalrun,
dense_rank()over(partition by BattingTeam order by sum(batsman_run) desc) rankteam from new_schema.ipl
group by batter,BattingTeam) t
where  t.rankteam<5; 

#which batsman hit highest no of six
select batter,BattingTeam,count(batsman_run) totalsix from new_schema.ipl
where batsman_run=6
group by batter,BattingTeam
order by totalsix desc
limit 10;
#which batsman hit highest no of six team wise
select t.* from (
select batter,BattingTeam,count(batsman_run) totalsix,
dense_rank()over(partition by BattingTeam order by count(batsman_run) desc) mostsix from new_schema.ipl
where batsman_run=6
group by batter,BattingTeam) t
where mostsix<5;

# who hit more noumber of fours in ipl
select batter,count(batsman_run) totalfour from new_schema.ipl
where batsman_run=4
group by batter
order by totalfour desc;
# best wicket tecketr boller in ipl
select * from ipl;
select bowler,sum(isWicketDelivery) totalwicket from ipl
where isWicketDelivery=1
group by bowler
order by totalwicket desc;

#which boller has best bolling avarage

select t.* from(
select bowler,sum(total_run),sum(isWicketDelivery) totalwick,round(count(ballnumber)/sum(isWicketDelivery)) avgarage from ipl
group by bowler) t
where t.totalwick>100
order by t.avgarage desc


