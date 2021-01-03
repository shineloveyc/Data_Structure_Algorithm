WITH ch_count AS
    (SELECT h.hacker_id as id, h.name as name,COUNT(c.challenge_id) AS num_ch
    FROM hackers h
    JOIN challenges c
    ON h.hacker_id = c.hacker_id
    GROUP BY 1,2),

max_count AS (SELECT MAX(num_ch)
             FROM ch_count)

SELECT id, name, num_ch
FROM ch_count t1
JOIN ON ch_count t2
ON t1.num_ch != t2.num_ch AND t1.num_ch>(SELECT * FROM max_count);

select a.hacker_id,a.name,count(b.hacker_id)
    from Hackers a, Challenges b
    WHERE a.hacker_id = b.hacker_id
    GROUP BY a.hacker_id,a.name
    HAVING count(b.hacker_id) not in (select  distinct count(hacker_id) from Challenges
    WHERE hacker_id <> a.hacker_id
    group by hacker_id
    having count(hacker_id) < (select max(x.challenge_count)
    from (select count(b.challenge_id) as challenge_count from Challenges b GROUP BY b.hacker_id) as x ))
    ORDER BY count(b.hacker_id) desc, a.hacker_id;
