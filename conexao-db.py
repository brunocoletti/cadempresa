import cx_Oracle # python3 -m pip install cx_Oracle --upgrade

#PARAM_DRIVER_ORCL  =oracle.jdbc.OracleDriver
#PARAM_URL_ORCL    =jdbc:oracle:thin:@dbqa.cndgxb5man6u.us-east-2.rds.amazonaws.com:1521:qa
#PARAM_USER_ORCL    =csf_own
#PARAM_PASS_ORCL    =AdM#QA2020


#con = cx_Oracle.connect('topm/topm@127.0.0.1/xe')
#con = cx_Oracle.connect('csf_own/AdM#QA2020@192.168.1.10:1521/quality')
con = cx_Oracle.connect('jdbc:oracle:thin:@dbqa.cndgxb5man6u.us-east-2.rds.amazonaws.com:1521:qa')
print (con.version)
con.close()
