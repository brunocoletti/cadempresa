import cx_Oracle # python3 -m pip install cx_Oracle --upgrade

#PARAM_DRIVER_ORCL  =oracle.jdbc.OracleDriver
#PARAM_URL_ORCL    =jdbc:oracle:thin:@dbqa.cndgxb5man6u.us-east-2.rds.amazonaws.com:1521:qa
#PARAM_USER_ORCL    =csf_own
#PARAM_PASS_ORCL    =AdM#QA2020

ORCLPDB1 ='''(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = dbqa.cndgxb5man6u.us-east-2.rds.amazonaws.com)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = QA)
    )
  )'''
#-----

def conect(empresa):
    connection = cx_Oracle.connect(user="csf_own", password="AdM#QA2020", dsn=ORCLPDB1,encoding="UTF-8")

    cursor = connection.cursor()
    for result in cursor.execute("select sysdate from dual"):
        print(result)

    connection.close()
