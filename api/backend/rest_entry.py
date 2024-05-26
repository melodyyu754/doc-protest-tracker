from flask import Flask
from flaskext.mysql import MySQL
import customers as custs
import products as prods

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    # app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # # these are for the DB object to be able to connect to MySQL. 
    # app.config['MYSQL_DATABASE_USER'] = 'root'
    # app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    # app.config['MYSQL_DATABASE_HOST'] = 'db'
    # app.config['MYSQL_DATABASE_PORT'] = 3306
    # app.config['MYSQL_DATABASE_DB'] = 'northwind'  # Change this to your DB name

    # # Initialize the database object with the settings above. 
    # db.init_app(app)

    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the Summer 2024 Belgium DoC Boilerplate App</h1>"
    
    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(custs,   url_prefix='/c')
    app.register_blueprint(prods,    url_prefix='/p')

    # Don't forget to return the app object
    return app
    # app = Flask(__name__)

    # @app.route("/")
    # def baseRoute():
    #     return "<h1>DoC Api Is Live</h1>"

    # @app.route("/data")
    # def getData():
    #     data = {              
    #             "user1": {
    #                 "Name": "Mark Fontenot",
    #                 "Course": "CS 3200",
    #             },
    #             "user2": {
    #                 "Name": "Eric Gerber",
    #                 "Course": "DS 3000",
    #             }
    #         }
    #     return data

    # return app
