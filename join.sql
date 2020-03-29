/*Modify it to show the matchid and player name for all goals scored by Germany. */
SELECT matchid, player FROM goal 
  WHERE teamid='GER'

/*Show id, stadium, team1, team2 for just game 1012*/
SELECT id,stadium,team1,team2 FROM game WHERE id=1012

/*Modify it to show the player, teamid, stadium and mdate for every German goal.*/
SELECT player,teamid,stadium,mdate FROM goal JOIN game ON (id=matchid) WHERE teamid='GER'

/*Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/
SELECT team1, team2, player FROM game JOIN goal ON (matchid=id) WHERE player LIKE 'Mario%'

/*Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10*/
SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON (id=teamid) WHERE gtime<=10

/*List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.*/
SELECT mdate, teamname FROM game JOIN eteam ON (eteam.id=team1) WHERE coach='Fernando Santos'

/*List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'*/
SELECT player FROM goal JOIN game ON (matchid=id) WHERE stadium='National Stadium, Warsaw'

/*Instead show the name of all players who scored a goal against Germany.*/
SELECT DISTINCT(player)
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid<>'GER'

/*Show teamname and the total number of goals scored.*/
SELECT teamname, COUNT(teamid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname

/*Show the stadium and the number of goals scored in each stadium.*/
SELECT stadium, COUNT(matchid) FROM game JOIN goal ON matchid=id GROUP BY stadium

/*For every match involving 'POL', show the matchid, date and the number of goals scored.
*/
SELECT matchid,mdate,COUNT(matchid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid

/*For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'*/
SELECT matchid, mdate, COUNT(matchid) FROM game JOIN goal ON matchid=id WHERE (team1='GER' OR team2='GER') AND teamid='GER' GROUP BY matchid

/*Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. Y*/
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY mdate, matchid, team1, team2