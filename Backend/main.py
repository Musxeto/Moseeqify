import pyodbc
import sqlalchemy as sal
from sqlalchemy import create_engine

engine = sal.create_engine(‘mssql+pyodbc://DESKTOP-AUUEPDM\SQLEXPRESS/moseeqify?driver=SQL Server?Trusted_Connection=yes’)

