require 'bundler/setup'
require 'pg'
require 'pry'


db = PG.connect(dbname: "project_2")



db.exec("DROP TABLE IF EXISTS votes")
db.exec("DROP TABLE IF EXISTS comments")
db.exec("DROP TABLE IF EXISTS projects")
#db.exec("DROP TABLE IF EXISTS users")
#remember, these must always be on the top and you should organize them in relation to one another.
#you won't be able to drop them if they depend on one another. Interesting.

# conn.exec("CREATE TABLE users(
#      id SERIAL PRIMARY KEY,
#      username VARCHAR NOT NULL,
#      password VARCHAR(255) NOT NULL,
#      email VARCHAR(255) NOT NULL,
#      picturelink VARCHAR,
#      aboutMe VARCHAR(500) NOT NULL
#    )")

     #user_id INTEGER REFERENCES users(id),

db.exec("CREATE TABLE projects(
     id SERIAL PRIMARY KEY,
     title VARCHAR NOT NULL,
     description TEXT NOT NULL,
     url VARCHAR
   )")

db.exec("CREATE TABLE comments(
     project_id INTEGER REFERENCES projects(id),
     id SERIAL PRIMARY KEY,
     content VARCHAR NOT NULL
   )")


db.exec("CREATE TABLE votes(
     comment_id INTEGER REFERENCES comments(id),
     project_id INTEGER REFERENCES projects(id),
     id SERIAL PRIMARY KEY,
     value VARCHAR NOT NULL
   )")
