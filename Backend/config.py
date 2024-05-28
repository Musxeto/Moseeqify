import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'mssql+pyodbc://DESKTOP-AUUEPDM\SQLEXPRESS/moseeqify?driver=ODBC+Driver+17+for+SQL+Server'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
