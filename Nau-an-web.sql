-- Cấu trúc bảng người dùng
CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100)
);

INSERT INTO users (id, username, email, password)
VALUES (001, 'user1', 'user1@gmail.com', '123');

INSERT INTO users (id, username, email, password)
VALUES (002, 'user2', 'user2@gmail.com', '12345');

INSERT INTO users (id, username, email, password)
VALUES (003, 'user3', 'user3@gmail.com', '123123');

-- Cấu trúc phần tương tác
CREATE TABLE interacts (
    id INT PRIMARY KEY,
    user_id INT,
    comment_id INT,
    recipe_id INT,
    recipe INT,
    queue INT,
    images VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (comment_id) REFERENCES comments (id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id)
);

-- Cấu trúc phần bình luận
CREATE TABLE comments (
    id INT PRIMARY KEY,
    user_id INT,
    recipe_id INT,
    content TEXT NOT NULL,
    rating INT,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id)
);

-- Cấu trúc phần công thức
CREATE TABLE recipes (
    id INT PRIMARY KEY,
    dish VARCHAR(100),
    instructions TEXT
);

-- Cấu trúc phần nguyên liệu
CREATE TABLE ingredients (
    id INT PRIMARY KEY,
    ingredient VARCHAR(100)
);

-- Cấu trúc tra cứu
CREATE TABLE searches (
    id INT PRIMARY KEY,
    ingredient_id INT,
    recipe_id INT,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id)
);

-- Chọn tất cả người dùng
SELECT * FROM users;

-- Chọn tất cả các công thức
SELECT * FROM recipes;

-- Chọn tất cả bình luận từ 1 người dùng cụ thể
SELECT * FROM comments WHERE user_id = 1;

-- Chọn tất cả công thức và nguyên liệu liên quan
SELECT recipes.dish, ingredients.ingredient
FROM
    searches
    JOIN recipes ON searches.recipe_id = recipes.id
    JOIN ingredients ON searches.ingredient_id = ingredients.id;

-- Lấy thông tin của người dùng đã đăng bình luận
SELECT users.username, comments.content
FROM users
    INNER JOIN comments ON user_id = comments.user_id
WHERE
    comments.recipe_id = 1;

-- Tìm kiếm công thức theo tên
SELECT * FROM recipes WHERE dish LIKE '%tôm chiên%';
-- VD Tìm các công thức có chứa từ "tôm chiên"
-- Cập nhập email của người dùng
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;

-- Cập nhập nội dung của bình luận
UPDATE comments
SET
    content = 'Nội dung mới của bình luận'
WHERE
    id = 1;

-- Xóa 1 người dùng
DELETE FROM users WHERE id = 1;

-- Xóa 1 bình luận
DELETE FROM comments WHERE id = 1;
