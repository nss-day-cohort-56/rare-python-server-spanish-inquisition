-- -- *** KEEP THESE HERE ***
-- DROP TABLE IF EXISTS PostReactions;
-- DROP TABLE IF EXISTS PostTags;
-- DROP TABLE IF EXISTS Subscriptions;
-- DROP TABLE IF EXISTS Comments;
-- DROP TABLE IF EXISTS Posts;
-- DROP TABLE IF EXISTS Categories;
-- DROP TABLE IF EXISTS Tags;
-- DROP TABLE IF EXISTS Reactions;
-- DROP TABLE IF EXISTS Users;

CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);

CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Data Science');
INSERT INTO Categories ('label') VALUES ('Machine Learning');
INSERT INTO Categories ('label') VALUES ('Relationships');
INSERT INTO Categories ('label') VALUES ('Health');
INSERT INTO Categories ('label') VALUES ('Self');

INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');


INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (1, 1, 'Cake macaroon chocolate shortbread tart sugar plum.');
INSERT INTO PostReactions ('user_id', 'reaction_id', 'post_id') VALUES (1, 1, 1);
INSERT INTO PostTags ('post_id', 'tag_id') VALUES (1, 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (1, 1, 'Sweets', 'Thu Jul 21 2022 15:06:52', 'https://storcpdkenticomedia.blob.core.windows.net/media/recipemanagementsystem/media/recipe-media-files/recipes/retail/x17/16714-birthday-cake-600x600.jpg?ext=.jpg)', 'Gummi bears halvah soufflé tootsie roll tart sugar plum. Shortbread lollipop cotton candy apple pie tart caramels cupcake caramels icing. Pudding gummi bears sesame snaps toffee pie.', 1);
INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') VALUES (1, 2, 'Thu Jul 21 2022 15:06:52');
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', active) VALUES ('Slinky', 'Dog', 'slinky@dog.com', 'Dog from Toy Story', 'slinky', 'dog', 'https://pngtree.com/so/happy', 'Thu Jul 21 2022 15:06:52', 1);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', active) VALUES ('Marki', 'Plier', 'Markiplier@gamin.com', 'Famous gamer and youtuber', 'Markiplier', 'Vibin', 'https://i.kym-cdn.com/entries/icons/facebook/000/014/221/ikin.jpg', 'Thu Jul 21 2022 15:06:52', 1);


INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Health');
INSERT INTO Categories ('label') VALUES ('Relationships');
INSERT INTO Categories ('label') VALUES ('Machine Learning');
INSERT INTO Categories ('label') VALUES ('Data Science');
INSERT INTO Categories ('label') VALUES ('Self');

INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (2, 1, 'Love this.');
INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (2, 1, 'Commenting for better reach.');
INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (2, 1, 'What stale bread.');

INSERT INTO Tags ('label') VALUES ('Startup');
INSERT INTO Tags ('label') VALUES ('Life');
INSERT INTO Tags ('label') VALUES ('Travel');
INSERT INTO Tags ('label') VALUES ('Education');
