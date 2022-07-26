import sqlite3
import json
from models import Post, User, Category


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


def get_posts_by_user_id(user_id):
    """Find posts belonging to a user
    """
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Write the SQL query to get the information you want
        db_cursor.execute("""
        SELECT * FROM Posts p
        JOIN Users u ON u.id = p.user_id
        JOIN Categories c ON c.id = p.category_id
        WHERE p.user_id = ?
        """, (user_id, ))

        # # Initialize an empty list to hold all entry representations
        posts = []

        # Convert rows of data into a Python list
        dataset = db_cursor.fetchall()

        # Set representations
        posts = create_from_query_dict_post_list(dataset)

    # Use `json` package to properly serialize list as JSON
    return json.dumps(posts)


def get_all_posts():
    """Get all Posts
    """
    # Open a connection to the database
    with sqlite3.connect("./db.sqlite3") as conn:

        # Just use these. It's a Black Box.
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Write the SQL query to get the information you want
        db_cursor.execute("""
		SELECT
        *
        FROM Posts p
        JOIN Users u ON u.id = p.user_id
        JOIN Categories c ON c.id = p.category_id
        ORDER BY p.publication_date ASC
        """)

        # Convert rows of data into a Python list
        dataset = db_cursor.fetchall()

        # Set representations
        posts = create_from_query_dict_post_list(dataset)

    # Use `json` package to properly serialize list as JSON
    return json.dumps(posts)


def get_single_post(id):
    """Get single Post
    """
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Use a ? parameter to inject a variable's value
        # into the SQL statement.
        db_cursor.execute("""
        SELECT * FROM Posts p
        JOIN Users u ON u.id = p.user_id
        JOIN Categories c ON c.id = p.category_id
        WHERE p.id = ?
        """, (id, ))

        # Load the single result into memory
        row = db_cursor.fetchone()

        if row is None:
            return False

        post = create_from_query_dict_post(row)

        # Add the dictionary representation of the cat
        return json.dumps(post)


def create_from_query_dict_post_list(dataset):
    """Return list of Post dictionary objects"""

    posts = []
    # Iterate list of data returned from database
    for row in dataset:
        # Set representations
        post_dict_with_all_relationships = create_from_query_dict_post(row)

        # Add the dictionary representation of the post to the list
        posts.append(post_dict_with_all_relationships)

    return posts


def create_from_query_dict_post(row):
    """Returns Post dictionary object"""

    # Create an entry instance from the current row.
    # Note that the database fields are specified in
    # exact order of the parameters defined in the
    # Entry class above.
    post = Post(row['id'], row['title'],
                row['publication_date'], row['image_url'], row['content'], row['approved'], row['user_id'], row['category_id'])

    # Create an User instance from the current row
    user = User(row['user_id'],
                row['first_name'],
                row['last_name'],
                row['email'],
                row['bio'],
                row['username'],
                row['profile_image_url'],
                row['created_on'],
                row['active'])

    # Add the dictionary representation of the user to the post
    post.user = user.__dict__

    # Create a Category instance from the current row
    category = Category(row['category_id'],
                        row['label'])
    # Add the dictionary representation of the category to the post
    post.category = category.__dict__

    return post.__dict__


def update_post(id, updated_post):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        UPDATE Posts
            SET
                user_id = ?,
                category_id = ?,
                title = ?,
                publication_date = ?,
                image_url = ?,
                content = ?,
                approved = ?
        WHERE id = ?
        """, (updated_post['user_id'], updated_post['category_id'], updated_post['title'], updated_post['publication_date'], updated_post['image_url'], updated_post['content'], updated_post['approved'],  id, ))

        # Were any rows affected?
        # Did the client send an `id` that exists?
        rows_affected = db_cursor.rowcount

    if rows_affected == 0:
        # Forces 404 response by main module
        return False
    else:
        # Forces 204 response by main module
        return True
