import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'mssql+pyodbc://DESKTOP-AUUEPDM\SQLEXPRESS/moseeqify?driver=ODBC+Driver+17+for+SQL+Server'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Manually set CORS headers
    @staticmethod
    def init_app(app):
        @app.after_request
        def after_request(response):
            response.headers.add('Access-Control-Allow-Origin', 'http://localhost:5173')
            response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
            response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
            return response
