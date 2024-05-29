-- JOIN 쿼리 예시
USE amumal_db;

SELECT 
    u.nickname AS 사용자_닉네임,
    p.title AS 게시글_제목,
    c.content AS 댓글_내용,
    c.created_at AS 댓글_작성_시간
FROM 
    Users u
JOIN 
    Posts p ON u.id = p.user_id
JOIN 
    Comments c ON p.id = c.post_id
ORDER BY 
    c.created_at DESC;
