# 아무 말 대잔치 커뮤니티 데이터베이스 (amumal_db)

이 프로젝트는 아무 말 대잔치 커뮤니티 웹사이트를 위한 데이터베이스 스키마, 더미 데이터 및 쿼리 예제입니다. 데이터베이스 이름은 `amumal_db`입니다.

### ERDCLOUD 를 사용하여 “아무 말 대잔치” 커뮤니티 서비스를 위한 데이터베이스 설계

먼저, ERDCLOUD 로 하기 전 글로써 데이터베이스 설계 진행

1. 사용자 관련 데이터 
    - 프로필 사진
    - 이메일(ID)
    - 비밀번호
    - 닉네임
2. 게시글 관련 데이터 
    - 게시글 제목 (26자 제한)
    - 게시글 내용
        - 글
        - 사진(최대 1개, 없을 수 도 있다)
    - 작성자 닉네임
    - 작성자 프로필 사진
    - 작성 시간
    - 조회수
    - 좋아요 수
    - 댓글 수

### 1. 사용자 테이블 설계 :

Users 테이블을 설계해보았습니다. 

### **요구사항**

- 사용자 프로필 사진
- 이메일
- 비밀번호
- 닉네임

Users 테이블 : 

| 칼럼 이름 | 데이터 타입 | 설명 |
| --- | --- | --- |
| id | INT | 기본 키 (Primary Key) |
| profile_picture | VARCHAR | 프로필 사진 URL |
| email | VARCHAR | 이메일 (고유값) |
| password | VARCHAR | 비밀번호 |
| nickname | VARCHAR | 닉네임 (고유값) |
| created_at | DATETIME | 가입 일시 |
| updated_at | DATETIME | 정보 수정 일시 |

### 2. 게시글 테이블 설계

게시글에는 게시글 내용과 필요한 데이터 이외에 댓글이 있다. 한 테이블에 넣는 것은 무리라고 생각하여 게시글과 댓글 테이블로 나우었습니다. 

### **요구사항**

- 제목: 최대 26자
- 본문: LONGTEXT 타입
- 사진: 최대 1장
- 작성자 닉네임, 프로필 사진
- 작성 시간
- 조회수
- 좋아요 수
- 댓글 수

Posts 테이블 : 

| 컬럼 이름 | 데이터 타입 | 설명 |
| --- | --- | --- |
| id | INT | 기본 키 (Primary Key) |
| title | VARCHAR(26) | 게시글 제목 |
| content | LONGTEXT | 게시글 본문 |
| image | VARCHAR | 게시글 이미지 URL (nullable) |
| user_id | INT | 작성자 ID (외래 키, Users 테이블 참조) |
| created_at | DATETIME | 작성 시간 |
| view_count | INT | 조회수 |
| like_count | INT | 좋아요 수 |
| comment_count | INT | 댓글 수 |

### 3. **댓글 (Comments) 테이블 설계**

### **요구사항**

- 댓글 작성자 프로필 사진
- 댓글 작성자 닉네임
- 댓글 작성 시간
- 댓글 수정 시간
- 댓글 내용

Comments 테이블 : 

| 컬럼 이름 | 데이터 타입 | 설명 |
| --- | --- | --- |
| id | INT | 기본 키 (Primary Key) |
| post_id | INT | 게시글 ID (외래 키, Posts 테이블 참조) |
| user_id | INT | 작성자 ID (외래 키, Users 테이블 참조) |
| content | TEXT | 댓글 내용 |
| created_at | DATETIME | 댓글 작성 시간 |
| updated_at | DATETIME | 댓글 수정 시간 |

### 4. 각 테이블  관계

- Users 와 Post 는 1:N 관계로 한 사용자가 여러 개의 게시글을 작성할 수 있다.
- Users 와 Comments 는 1:N 관계로 한 사용자가 여러 개의 댓글을 작성할 수 있다.
- Posts 와 Comments 는 1:N 관계로 한 게시글에 여러 개의 댓글이 달릴 수 있다.

### 5. 테이블 요약 설명

1. User 테이블은 사용자 정보를 저장하는 테이블로 각 사용자마다 고유한 이메일과 닉네임을 가지고 있으며, 프로필 사진, 비밀번호, 가입 일시 및  정보 수정 일시와 같은 추가 정보를 가지고 있다. 
2. Post 테이블은 게시글 정보를 저장하는 테이블로 각 게시글마다 제목, 본문, 이미지(선택적), 작성자 ID(User 테이블의 외래 키), 작성 시간, 조회수, 좋아요 수, 댓글 수를 포함한다. 
3. Comments 테이블은 댓글 정보를 저장하는 테이블로 각 댓글은 게시글 ID(Posts 테이블의 외래 키), 작성자 ID(User 테이블의 외래 키), 댓글 내용, 작성 시간 및 수정 시간을 포함한다. 

## ERDCloud

[링크](https://www.erdcloud.com/d/YDbkwZGjYCmWJWmm3)
<iframe width="600" height="336" src="https://www.erdcloud.com/p/YDbkwZGjYCmWJWmm3" frameborder="0" allowfullscreen></iframe>

## 디렉토리 구조
```
./
  /schema
    create_database.sql
    create_tables.sql
  /data
    insert_dummy_data.sql
  /queries
    join_queries.sql
    transaction_queries.sql
```

## 파일 설명

### /sql/schema/create_database.sql

- 기존 데이터베이스가 존재할 경우 삭제하고, 새로운 `amumal_db` 데이터베이스를 생성합니다.
- UTF-8 문자셋과 유니코드 대소문자 구분 규칙을 사용합니다.

```
-- 기존 데이터베이스가 있을 경우 삭제
DROP DATABASE IF EXISTS amumal_db;

-- 데이터베이스 생성
CREATE DATABASE amumal_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE amumal_db;
```
### /sql/schema/create_tables.sql
- Users, Posts, Comments 테이블을 생성합니다.
- 각 테이블의 스키마는 다음과 같습니다:
```
-- 테이블 생성
USE amumal_db;

CREATE TABLE Users (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    profile_picture VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    nickname VARCHAR(50) UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Posts (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(26),
    content LONGTEXT,
    image VARCHAR(255),
    user_id INT(11),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    view_count INT(11) DEFAULT 0,
    like_count INT(11) DEFAULT 0,
    comment_count INT(11) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Comments (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    post_id INT(11),
    user_id INT(11),
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);
```

### /sql/data/insert_dummy_data.sql
- Users, Posts, Comments 테이블에 더미 데이터를 삽입합니다.
- 각 테이블에 적절한 샘플 데이터가 포함됩니다:
```
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
```
### /sql/queries/join_queries.sql
- Users, Posts, Comments 테이블 간의 JOIN 쿼리 예제를 포함합니다:

```
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
```
### /sql/queries/transaction_queries.sql
- 트랜잭션을 사용한 쿼리 예제를 포함합니다:
```
-- 트랜잭션 쿼리 예시
USE amumal_db;

START TRANSACTION;

INSERT INTO Posts (title, content, image, user_id) 
VALUES ('네 번째 게시글', '네 번째 게시글 내용', 'post4.png', 1);

INSERT INTO Comments (post_id, user_id, content) 
VALUES (LAST_INSERT_ID(), 2, '네 번째 게시글에 대한 첫 번째 댓글');

COMMIT;
```
## 사용 방법
1. 데이터베이스 생성 및 테이블 생성

- /sql/schema/create_database.sql 스크립트를 실행하여 데이터베이스를 생성합니다.
- /sql/schema/create_tables.sql 스크립트를 실행하여 테이블을 생성합니다.
2. 더미 데이터 삽입

- /sql/data/insert_dummy_data.sql 스크립트를 실행하여 더미 데이터를 삽입합니다.
3. 쿼리 실행

- /sql/queries/join_queries.sql 스크립트를 실행하여 JOIN 쿼리 예제를 테스트합니다.
- /sql/queries/transaction_queries.sql 스크립트를 실행하여 트랜잭션 쿼리 예제를 테스트합니다.
