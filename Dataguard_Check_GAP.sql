ALTER DATABASE REGISTER LOGFILE '/oradata/oracle/ts/arc109_1_655805448.arc';

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;​

SELECT * FROM V$ARCHIVE_GAP;

SELECT /*+PARALLEL(8)*/AL.THRD THREAD, ALMAX Last_Seq_Received, LHMAX Last_Seq_Appl FROM
(
  SELECT THREAD# THRD, MAX(SEQUENCE#) ALMAX
  FROM V$ARCHIVED_LOG
  WHERE RESETLOGS_CHANGE#=(SELECT RESETLOGS_CHANGE# FROM V$DATABASE)
  GROUP BY THREAD#
) AL,
(
  SELECT THREAD# THRD, MAX(SEQUENCE#) LHMAX
  FROM V$LOG_HISTORY
  WHERE FIRST_TIME=(SELECT MAX(FIRST_TIME) FROM V$LOG_HISTORY)
  GROUP BY THREAD#
) LH
WHERE AL.THRD=LH.THRD;

/*
SELECT /*+PARALLEL(8)*/ARCH.THREAD#, ARCH.SEQUENCE# Last_Seq_Received, APPL.SEQUENCE# Last_Seq_Appl,
(ARCH.SEQUENCE# - APPL.SEQUENCE#) Diff FROM
(
  SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE
  (THREAD#, FIRST_TIME)
  IN
  (SELECT THREAD#, MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)
) ARCH,
(
  SELECT THREAD#, SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME)
  IN
  (SELECT THREAD#, MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)
) APPL
WHERE ARCH.THREAD#=APPL.THREAD#;​
*/

SET LINES 200 PAGES 5000;
SELECT /*+PARALEL(4)*/THREAD#, SEQUENCE#, ARCHIVED, APPLIED, STATUS FROM V$ARCHIVED_LOG ORDER BY 2,1;

DESC V$ARCHIVED_LOG;

SELECT '/Arch/nettisdb1_'||SEQUENCE#||'_'||RESETLOGS_ID||'.dbf' NAME FROM V$ARCHIVED_LOG
WHERE DEST_ID=2 AND APPLIED='YES' AND DELETED='NO' AND FIRST_TIME<SYSDATE-2ORDER BY FIRST_TIME;