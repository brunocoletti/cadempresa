import cx_Oracle # python3 -m pip install cx_Oracle --upgrade
import os
from dotenv import load_dotenv

load_dotenv()

ORCLPDB1 ='''(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = dbqa.cndgxb5man6u.us-east-2.rds.amazonaws.com)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = QA)
    )
  )'''
#-----

def conect(empresa):
    connection = cx_Oracle.connect(user=os.environ.get('USR'), password=os.environ.get('PASSWD'), dsn=ORCLPDB1,encoding="UTF-8")

    cursor = connection.cursor()
    for result in cursor.execute("select sysdate from dual"):
        print(result)

    connection.close()
conect('a')