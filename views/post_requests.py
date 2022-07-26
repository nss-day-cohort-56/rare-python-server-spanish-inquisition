import sqlite3
import json

def create_post(new_post):
    """this method will add a new post to the Posts table, using post data provided by user via post form in react.
    """ 
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        INSERT INTO Posts
            ( user_id, category_id, title, publication_date, image_url, content, approved )
        VALUES
            ( ?, ?, ?, ?, ?, ?, ?)
        """, (new_post['user_id'], new_post['category_id'], new_post['title'],
            new_post['publication_date'], new_post['image_url'],
            new_post['content'], new_post['approved'], ))

        postId = db_cursor.lastrowid

        new_post['id'] = postId

        return json.dumps(new_post)