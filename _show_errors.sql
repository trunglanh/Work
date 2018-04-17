set pagesize 9999
set linesize 9999
set heading off
set trim on

select lower(attribute) -- error or warning
  || ' '
  || line || '/' || position -- line and column
  || ' '
  || lower(name) -- file name
  || case
        when name like 'WEB%' THEN '_BD.sql'
        when name like 'TEST%' THEN '.sql'
        else '.sql'
     end
  || ' '
  || replace(text, chr(10), ' ') -- remove line breaks from error text
  as user_errors
from user_errors
where name <> 'WEB_EDUSEINFORMATION_ENTRY' and attribute = 'ERROR' 
and  ((name like 'WEB\_%' ESCAPE '\') or (name like 'TEST\_WEB\_%' ESCAPE '\'))
order by type, name, line, position;
