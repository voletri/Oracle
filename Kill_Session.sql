SET LINES 200 PAGES 5000 TIME ON;
COL SPID FORMAT A10;
COL USERNAME FORMAT A10;
COL PROGRAM FORMAT A45;

SELECT S.INST_ID, S.SID, S.SERIAL#, P.SPID, S.USERNAME, S.PROGRAM
FROM GV$SESSION S JOIN GV$PROCESS P ON P.ADDR = S.PADDR AND P.INST_ID = S.INST_ID WHERE S.TYPE != 'BACKGROUND';

ALTER SYSTEM KILL SESSION 'sid,serial#' IMMEDIATE;

kill -9 spid