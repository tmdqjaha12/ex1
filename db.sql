SHOW DATABASES;
USE ex1_n1_service;
TRUNCATE `member`;
TRUNCATE `article`;

# 캐릭터SET 설정
SET NAMES utf8mb4;

# DB 생성
DROP DATABASE IF EXISTS ex1;
CREATE DATABASE ex1;
USE ex1;

# 회원 테이블 생성
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `loginId` CHAR(100) NOT NULL UNIQUE,
    `loginPw` CHAR(100) NOT NULL,
    `name` CHAR(100) NOT NULL, 
    `nickname` CHAR(100) NOT NULL UNIQUE,
    `email` CHAR(100) NOT NULL,
    `cellphoneNo` CHAR(30) NOT NULL,
    `level` INT(1) UNSIGNED DEFAULT 0 NOT NULL,
    `delStatus` INT(1) UNSIGNED DEFAULT 0 NOT NULL
);

# 마스터 회원 생성
INSERT INTO `member` SET
regDate = NOW(),
updateDate = NOW(),
`loginId` = 'admin',
`loginPw` = SHA2('admin', 256),
`name` = 'admin',
`nickname` = 'admin',
`email` = 'admin@admin.com',
`cellphoneNo` = '',
`level` = 10;

# 부가정보테이블 
DROP TABLE IF EXISTS attr;
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE,
    `value` TEXT NOT NULL
);

# attr 테이블에서 name 을 4가지 칼럼으로 나누기
ALTER TABLE `attr` DROP COLUMN `name`,
ADD COLUMN `relTypeCode` CHAR(20) NOT NULL AFTER `updateDate`,
ADD COLUMN `relId` INT(10) UNSIGNED NOT NULL AFTER `relTypeCode`,
ADD COLUMN `typeCode` CHAR(30) NOT NULL AFTER `relId`,
ADD COLUMN `type2Code` CHAR(30) NOT NULL AFTER `typeCode`,
CHANGE `value` `value` TEXT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL AFTER `type2Code`,
DROP INDEX `name`; 

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`); 

##관리자 attr적용
INSERT INTO  attr SET
regDate = NOW(),
updateDate = NOW(),
relTypeCode = 'member',
relId = 1,
typeCode = 'extra',
type2Code = 'emailAuthed',
`value` = 'admin@admin.com';

INSERT INTO  attr SET
regDate = NOW(),
updateDate = NOW(),
relTypeCode = 'member',
relId = 1,
typeCode = 'extra',
type2Code = 'lastPasswordChangeDate',
`value` = '2020-08-31 11:06:18';

INSERT INTO  attr SET
regDate = NOW(),
updateDate = NOW(),
relTypeCode = 'member',
relId = 1,
typeCode = 'extra',
type2Code = 'emailAuthCode',
`value` = 'dadadwda-adq1-vvva-1212-ava41g4t5tdd';

# article 테이블 세팅
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	boardId INT(10) UNSIGNED NOT NULL,
	memberId INT(10) UNSIGNED NOT NULL,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);

# article 테이블에 테스트 데이터 삽입
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '테스트 제목',
`body` = '테스트 내용',
boardId = 3,
memberId = 1,
displayStatus = 1;


# 게시판 테이블 추가
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
	`name` CHAR(20) NOT NULL UNIQUE
);

#기본 게시판 생성
INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'notice',
`name` = '공지';

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'update',
`name` = '업데이트';

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'question',
`name` = '문의';

/* 파일 테이블 생성 */
CREATE TABLE `file` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	relTypeCode CHAR(50) NOT NULL,
	relId INT(10) UNSIGNED NOT NULL,
    originFileName VARCHAR(100) NOT NULL,
    fileExt CHAR(10) NOT NULL,
    typeCode CHAR(20) NOT NULL,
    type2Code CHAR(20) NOT NULL,
    fileSize INT(10) UNSIGNED NOT NULL,
    fileExtTypeCode CHAR(10) NOT NULL,
    fileExtType2Code CHAR(10) NOT NULL,
    fileNo TINYINT(2) UNSIGNED NOT NULL,
    `body` LONGBLOB
);

# 파일 테이블에 유니크 인덱스 추가
ALTER TABLE `file` ADD UNIQUE INDEX (`relId`, `relTypeCode`, `typeCode`, `type2Code`, `fileNo`); 

# 파일 테이블의 기존 인덱스에 유니크가 걸려 있어서 relId가 0 인 동안 충돌이 발생할 수 있다. 그래서 일반 인덱스로 바꾼다.
ALTER TABLE `file` DROP INDEX `relId`, ADD INDEX (`relId` , `relTypeCode` , `typeCode` , `type2Code` , `fileNo`); 



#############

# articleReply 테이블에 테스트 데이터 삽입
DROP TABLE IF EXISTS `articleReply`;
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `articleReply` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
    memberId INT(10) UNSIGNED NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    `body` TEXT NOT NULL
);

INSERT INTO articleReply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
articleId = 10,
displayStatus = 1,
`body` = '내용1';

/* 게시물 댓글을 범용 댓글 테이블로 변경 */
RENAME TABLE `articleReply` TO `reply`;

ALTER TABLE `reply` ADD COLUMN `relTypeCode` CHAR(50) NOT NULL AFTER `memberId`,
CHANGE `articleId` `relId` INT(10) UNSIGNED NOT NULL;

ALTER TABLE `ex1`.`reply` ADD INDEX (`relId`, `relTypeCode`);
UPDATE reply
SET relTypeCode = 'article'
WHERE relTypeCode = '';


ALTER TABLE board ADD COLUMN boardApply INT(10) UNSIGNED DEFAULT 0 NOT NULL
ALTER TABLE board CHANGE boardApply applyStatus INT(10) UNSIGNED DEFAULT 0 NOT NULL;
ALTER TABLE `board` ADD COLUMN memberId INT(10) UNSIGNED DEFAULT 0 NOT NULL;
ALTER TABLE `board` DROP applyStatus;


ALTER TABLE article ADD COLUMN hit INT(10) UNSIGNED DEFAULT 0 NOT NULL

# 좋아요
CREATE TABLE `articleLike` (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  regDate DATETIME NOT NULL,
  articleId INT(10) UNSIGNED NOT NULL,
  memberId INT(10) UNSIGNED NOT NULL,
  `point` TINYINT(1) UNSIGNED NOT NULL
);

# 게시판 신청서
DROP TABLE IF EXISTS `boardApplyDoc`;
CREATE TABLE boardApplyDoc (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    regDate DATETIME, 
    updateDate DATETIME, 
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	applyStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	memberId INT(10) UNSIGNED NOT NULL,
    `name` CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);

ALTER TABLE `boardApplyDoc` ADD COLUMN boardId INT(10) UNSIGNED DEFAULT 0 NOT NULL;
		
#검색
SELECT A.*, 
M.nickname AS extra__writer,
IFNULL(SUM(AL.point), 0) AS extra__likePoint,
IFNULL(SUM(RL.displayStatus), 0) AS extra__applyPoint
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN articleLike AS AL
ON A.id = AL.articleId
LEFT JOIN reply AS RL
ON A.id = RL.relId
WHERE A.displayStatus = 1
AND A.delStatus = 0
AND M.delStatus = 0
AND A.title LIKE CONCAT('%' , '', '%')
AND A.body LIKE CONCAT('%' , '', '%')
GROUP BY A.id
ORDER BY A.id DESC
LIMIT 0, 10


## MyPageArticleList #커뮤니티이름, 번호, 제목, 날짜
SELECT A.*,
B.name AS extra__boardName
FROM article AS A
INNER JOIN board AS B
ON A.boardId = B.id
WHERE B.delStatus = 0
AND A.memberId = 1
AND A.delStatus = 0
AND A.displayStatus = 1
GROUP BY A.id
ORDER BY A.id DESC
LIMIT 0, 5

## MyPageBoardApplyDocList #날짜, 이름, 승인여부
SELECT *
FROM boardApplyDoc 
WHERE memberId = ~~~

## MyPageReplyList #댓글, 글, 커뮤니티 del=0 id code까지, 번호, 날짜, 내용, x댓글좋아요
SELECT R.*,
B.code AS extra__boardCode,
A.id AS extra__articleId
FROM reply AS R
INNER JOIN article AS A
ON R.relId = A.id
INNER JOIN board AS B
ON A.boardId = B.id
WHERE R.memberId = 1
AND R.delStatus = 0
AND A.delStatus = 0
AND B.delStatus = 0