-- 트랜잭션 쿼리 예시
USE amumal_db;

START TRANSACTION;

INSERT INTO Posts (title, content, image, user_id) 
VALUES ('네 번째 게시글', '네 번째 게시글 내용', 'post4.png', 1);

INSERT INTO Comments (post_id, user_id, content) 
VALUES (LAST_INSERT_ID(), 2, '네 번째 게시글에 대한 첫 번째 댓글');

COMMIT;
