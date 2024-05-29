-- 더미 데이터 삽입
USE amumal_db;

INSERT INTO Users (profile_picture, email, password, nickname)
VALUES 
('profile1.png', 'user1@example.com', 'password1', '사용자1'),
('profile2.png', 'user2@example.com', 'password2', '사용자2'),
('profile3.png', 'user3@example.com', 'password3', '사용자3');

INSERT INTO Posts (title, content, image, user_id)
VALUES 
('첫 번째 게시글', '첫 번째 게시글 내용', 'post1.png', 1),
('두 번째 게시글', '두 번째 게시글 내용', 'post2.png', 2),
('세 번째 게시글', '세 번째 게시글 내용', 'post3.png', 3);

INSERT INTO Comments (post_id, user_id, content)
VALUES 
(1, 2, '첫 번째 게시글에 대한 첫 번째 댓글'),
(1, 3, '첫 번째 게시글에 대한 두 번째 댓글'),
(2, 1, '두 번째 게시글에 대한 첫 번째 댓글');
