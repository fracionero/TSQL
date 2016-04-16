select 
mp.spid,
sql1.text  as Blocked_Proc_Text,
mp.blocked as Blocked_By,
sp.text
from sysprocesses mp
cross apply sys.dm_exec_sql_text(mp.sql_handle) as sql1
left join (Select p.spid,sql2.text from sysprocesses p
		cross apply sys.dm_exec_sql_text(p.sql_handle) sql2 ) as sp on mp.blocked=sp.spid
where mp.blocked !=0