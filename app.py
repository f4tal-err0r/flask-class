from flask import Flask, render_template
import sqlite3 
app = Flask(__name__)

def get_db_connection():
    conn = sqlite3.connect('db/blog.db')
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def index():
    conn = get_db_connection()                              #connects us to the database
    posts = conn.execute("SELECT * FROM posts").fetchall()  #fetches the posts from the database
    conn.close()                                            #closes the connection to the database
    return render_template('index.html', posts=posts)

if __name__ == "__main__":
    app.run(debug=True)