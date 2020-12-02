
SELECT *
FROM NOT_EXISTS_IN_PRD;

TRUNCATE TABLE IMAGE_ANALYSIS;
TRUNCATE TABLE REPET_ANALYSIS;
TRUNCATE TABLE KEYWORD_MATCHING;
TRUNCATE TABLE KEYWORD_ANALYSIS;
TRUNCATE TABLE HABIT_ANALYSIS;
TRUNCATE TABLE VOICE_ANALYSIS;
TRUNCATE TABLE HABIT;
TRUNCATE TABLE KEYWORD;
TRUNCATE TABLE TALENT;
TRUNCATE TABLE ANSWER;
TRUNCATE TABLE QUESTION_GB;
TRUNCATE TABLE INTERVIEW;
TRUNCATE TABLE QUESTION;
TRUNCATE TABLE SAMPLE_QUESTION;
TRUNCATE TABLE PLAN_USE;
TRUNCATE TABLE PLAN;
TRUNCATE TABLE MESSAGE;
TRUNCATE TABLE SPEACH_TEST;
TRUNCATE TABLE SCRIPT;
TRUNCATE TABLE SCRIPT_GB;
TRUNCATE TABLE SCRIPT_TEST;
TRUNCATE TABLE REPLY;
TRUNCATE TABLE ATTACHMENT;
TRUNCATE TABLE BOARD;
TRUNCATE TABLE BOARD_GB;
TRUNCATE TABLE CATEGORY_GB;
TRUNCATE TABLE CATEGORY;
TRUNCATE TABLE MEMBER;

-- MEMBER
INSERT INTO MEMBER VALUES('TEST_ID','TEST_PW','Y','Y','TEST_ALIAS','TEST_NAME','010-1234-5678','TEST_ADDR1','TEST_ADDR2',12345,'NEWCOMER','UNIVERSITY GRADUATION','F','KAKAO','DEVELOPER','2020-10','COMPUTER ARCHITECTURE','brown.png','D:\brown.png');
INSERT INTO MEMBER VALUES('TEST_ID2','TEST_PW','Y','Y','TEST_ALIAS','TEST_NAME','010-1234-5678','TEST_ADDR1','TEST_ADDR2',12345,'NEWCOMER','UNIVERSITY GRADUATION','F','KAKAO','DEVELOPER','2020-10','COMPUTER ARCHITECTURE','brown.png','D:\brown.png');
INSERT INTO MEMBER VALUES('TEST_ID3','TEST_PW','Y','Y','TEST_ALIAS','TEST_NAME','010-1234-5678','TEST_ADDR1','TEST_ADDR2',12345,'NEWCOMER','UNIVERSITY GRADUATION','F','KAKAO','DEVELOPER','2020-10','COMPUTER ARCHITECTURE','brown.png','D:\brown.png');

--BOARD_GB
INSERT INTO BOARD_GB VALUES(1,'공지사항','Y');
INSERT INTO BOARD_GB VALUES(2,'스터디모집','Y');
INSERT INTO BOARD_GB VALUES(3,'면접후기','Y');
INSERT INTO BOARD_GB VALUES(4,'포트폴리오','Y');

--CATEGORY_GB
INSERT INTO CATEGORY_GB VALUES(1, '공지사항 말머리', 'Y',1);
INSERT INTO CATEGORY_GB VALUES(2, '스터디모집 말머리', 'Y',2);
INSERT INTO CATEGORY_GB VALUES(3, '면접후기 말머리', 'Y',3);
INSERT INTO CATEGORY_GB VALUES(4, '포트폴리오 말머리', 'Y',4);

--CATEGORY
INSERT INTO CATEGORY VALUES(1,'자랑하기','Y',4);
INSERT INTO CATEGORY VALUES(2,'공유하기','Y',4);
INSERT INTO CATEGORY VALUES(3,'피드백','Y',4);
INSERT INTO CATEGORY VALUES(4,'점검공지','Y',1);
INSERT INTO CATEGORY VALUES(5,'서버공지','Y',1);

--BOARD
INSERT INTO BOARD(BOARD_SQ,BOARD_GB_SQ,BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_ST, GROUP_NO, MEM_ID) VALUES(1,4,'처음 써본 포트폴리오 평가좀요', '평가부탁드려요', SYSDATE, 'Y', 1, 'TEST_ID');
INSERT INTO BOARD(BOARD_SQ,BOARD_GB_SQ,BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_ST, GROUP_NO, MEM_ID) VALUES(2,4,'포트폴리오 피드백 부탁드립니다', '많은 댓글 감사합니다.', SYSDATE, 'Y', 1, 'TEST_ID');
INSERT INTO BOARD(BOARD_SQ,BOARD_GB_SQ,BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_ST, GROUP_NO, MEM_ID) VALUES(3,4,'디자인 포트폴리오 어떤가요', '너무 과한가요?', SYSDATE, 'Y', 1, 'TEST_ID');

--REPLY
INSERT INTO REPLY VALUES(1,1,'오우 정말 멋진데요?',SYSDATE,'Y','TEST_ID');
INSERT INTO REPLY VALUES(2,1,'진짜 잘 만드셨어요',SYSDATE,'Y','TEST_ID2');
INSERT INTO REPLY VALUES(3,1,'제가 보기엔 조금 과해요',SYSDATE,'Y','TEST_ID3');
INSERT INTO REPLY VALUES(4,2,'자료 공유 가능할까요',SYSDATE,'Y','TEST_ID');

-- ATTACHMENT
INSERT INTO ATTACHMENT VALUES(1,1,'D:\brown.png','brown.png');
INSERT INTO ATTACHMENT VALUES(2,2,'D:\sally.png','sally.png');
INSERT INTO ATTACHMENT VALUES(3,3,'D:\cony.png','cony.png');

-- SCRIPT_GB
INSERT INTO SCRIPT_GB VALUES(1,'영어','Y');
INSERT INTO SCRIPT_GB VALUES(2,'일본어','Y');
INSERT INTO SCRIPT_GB VALUES(3,'러시아어','Y');
INSERT INTO SCRIPT_GB VALUES(4,'한국어','Y');

-- SCRIPT
INSERT INTO SCRIPT VALUES(1,'동해물과 백두산이 마르고 닳도록','Y',4);
INSERT INTO SCRIPT VALUES(2,'간장공장 공장장은 강공장장이다.','Y',4);
INSERT INTO SCRIPT VALUES(3,'내가 그린 기린 그림은 긴 기린그림이다.','Y',4);
INSERT INTO SCRIPT VALUES(4,'치키치키 차카차카 초코초코 초','Y',4);
INSERT INTO SCRIPT VALUES(5,'私は前転をよくします','Y',2);
INSERT INTO SCRIPT VALUES(6,'We are the one','Y',1);

-- SCRIPT_TEST
INSERT INTO SCRIPT_TEST VALUES(1,100,'치키치키 차카차카 초코초코 초',SYSDATE,'TEST_ID',4);
INSERT INTO SCRIPT_TEST VALUES(2,60,'We are the one',SYSDATE,'TEST_ID2',6);

-- SPEACH_TEST
INSERT INTO SPEACH_TEST VALUES(1,'TEST_ID',70, 'I have a pen.',SYSDATE);
INSERT INTO SPEACH_TEST VALUES(2,'TEST_ID2',80, 'I have a apple.',SYSDATE);

-- MESSAGE
INSERT INTO MESSAGE VALUES(1,'혹시 이거 챗봇인가요..?',SYSDATE, 'TEST_ID','TEST_ID2');
INSERT INTO MESSAGE VALUES(2,'아닙니다ㅎㅎ',SYSDATE, 'TEST_ID2','TEST_ID');
INSERT INTO MESSAGE VALUES(3,'앗 감사합니다..',SYSDATE, 'TEST_ID','TEST_ID2');

-- PLAN
INSERT INTO PLAN (PLAN_SQ,PLAN_NM,PLAN_PRICE,PLAN_EXPLAIN,PLAN_ST,PLAN_PERIOD) VALUES (1,'1일 이용권',5000,'짧고 굵게, 단기간에 집중력을 발휘해 보세요.','Y',1);
INSERT INTO PLAN (PLAN_SQ,PLAN_NM,PLAN_PRICE,PLAN_EXPLAIN,PLAN_ST,PLAN_PERIOD) VALUES (2,'3일 이용권',9900,'다양한 질문들과 함께 나의 면접을 다듬어 보세요.','Y',3);
INSERT INTO PLAN (PLAN_SQ,PLAN_NM,PLAN_PRICE,PLAN_EXPLAIN,PLAN_ST,PLAN_PERIOD) VALUES (3,'7일 이용권',15900,'취업은 마라톤! 꾸준하고 오랜 노력을 이길것은 없습니다.','Y',7);

-- PLAN_USE
INSERT INTO PLAN_USE (USE_SQ,START_DATE,END_DATE,MEM_ID,PLAN_SQ) VALUES (1,TO_DATE('2020/11/30','YYYY/MM/DD'),TO_DATE('2020/11/30','YYYY/MM/DD'),'TEST_ID',1);
INSERT INTO PLAN_USE (USE_SQ,START_DATE,END_DATE,MEM_ID,PLAN_SQ) VALUES (2,TO_DATE('2020/11/30','YYYY/MM/DD'),TO_DATE('2020/12/01','YYYY/MM/DD'),'TEST_ID2',3);

-- TALENT
INSERT INTO TALENT VALUES(1,'유능한 인재','Y');
INSERT INTO TALENT VALUES(2,'열정적인 인재','Y');
INSERT INTO TALENT VALUES(3,'대기만성형 인재','Y');

-- KEYWORD
INSERT INTO KEYWORD VALUES(1, '꾸준함','Y');
INSERT INTO KEYWORD VALUES(2, '적응력','Y');
INSERT INTO KEYWORD VALUES(3, '추진력','Y');
INSERT INTO KEYWORD VALUES(4, '열심','Y');

-- KEYWORD_MATCHING
INSERT INTO KEYWORD_MATCHING VALUES(3,1);
INSERT INTO KEYWORD_MATCHING VALUES(3,2);
INSERT INTO KEYWORD_MATCHING VALUES(2,3);
INSERT INTO KEYWORD_MATCHING VALUES(2,4);

-- QUESTION_GB
INSERT INTO QUESTION_GB VALUES(1,'개발','Y');
INSERT INTO QUESTION_GB VALUES(2,'기획','Y');
INSERT INTO QUESTION_GB VALUES(3,'영업','Y');
INSERT INTO QUESTION_GB VALUES(4,'연구','Y');

-- SAMPLE_QUESTION
INSERT INTO SAMPLE_QUESTION VALUES(1,'개발자에게 필요한 역량은 무엇이라고 생각하십니까?','Y', 1);
INSERT INTO SAMPLE_QUESTION VALUES(2,'개발시간과 개발의 정확성,둘 중 무엇이 더 중요하다고 생각하나요?','Y', 1);
INSERT INTO SAMPLE_QUESTION VALUES(3,'영업분야에 지원하게 된 동기는 무엇입니까?','Y', 3);

-- INTERVIEW
INSERT INTO INTERVIEW VALUES(1,'하반기 대비 면접',SYSDATE,'TEST_ID');
INSERT INTO INTERVIEW VALUES(2,'카카오 면접',SYSDATE,'TEST_ID2');
INSERT INTO INTERVIEW VALUES(3,'첫 면접',SYSDATE,'TEST_ID');
INSERT INTO INTERVIEW VALUES(4,'이름 없는 면접',SYSDATE,'TEST_ID3');

-- QUESTION
INSERT INTO QUESTION VALUES(1,'개발자에게 필요한 역량은 무엇이라고 생각하십니까?',2, 1);
INSERT INTO QUESTION VALUES(2,'개발시간과 개발의 정확성,둘 중 무엇이 더 중요하다고 생각하나요?',2, 2);

-- ANSWER
INSERT INTO ANSWER VALUES(1,'음 꾸준함과 흥미라고 생각합니다.','D:\test\test1.wav',20,4,1);
INSERT INTO ANSWER VALUES(2,'물론 둘 다 중요하지만 하나를 꼽자면,저는 정확성이라고 생각합니다. 정확성이 중요한 이유는~','D:\test\test2.wav',40,5,2);

-- KEYWORD_ANALYSIS
INSERT INTO KEYWORD_ANALYSIS VALUES(1,1,1);
INSERT INTO KEYWORD_ANALYSIS VALUES(2,2,0);

-- VOICE ANALYSIS
INSERT INTO VOICE_ANALYSIS VALUES(1,80,70,1);
INSERT INTO VOICE_ANALYSIS VALUES(2,85,60,2);

-- HABIT
INSERT INTO HABIT VALUES(1,'음','Y');
INSERT INTO HABIT VALUES(2,'물론','Y');
INSERT INTO HABIT VALUES(3,'저는','Y');
INSERT INTO HABIT VALUES(4,'그게','Y');
INSERT INTO HABIT VALUES(5,'어','Y');

-- HABIT ANALYSIS
INSERT INTO HABIT_ANALYSIS VALUES(1,1,1);
INSERT INTO HABIT_ANALYSIS VALUES(2,2,1);
INSERT INTO HABIT_ANALYSIS VALUES(3,2,1);

-- REPET ANALYSIS
INSERT INTO REPET_ANALYSIS VALUES(1,2,'정확성',2);

-- IMAGE ANALYSIS
INSERT INTO IMAGE_ANALYSIS VALUES(1,1,1,1,1,1,1,1,1,1,1,1,2,1,1);
INSERT INTO IMAGE_ANALYSIS VALUES(2,1,2,1,1,1,1,2,1,1,1,1,1,1,1);
INSERT INTO IMAGE_ANALYSIS VALUES(3,1,1,3,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO IMAGE_ANALYSIS VALUES(4,1,1,2,4,1,1,1,1,1,1,1,1,1,1);
INSERT INTO IMAGE_ANALYSIS VALUES(5,1,1,6,1,1,5,1,1,1,1,1,3,1,1);
INSERT INTO IMAGE_ANALYSIS VALUES(6,1,1,1,1,1,1,1,1,1,1,1,1,1,2);
INSERT INTO IMAGE_ANALYSIS VALUES(7,1,1,1,1,3,5,1,1,1,1,1,1,1,2);
INSERT INTO IMAGE_ANALYSIS VALUES(8,1,1,3,1,1,1,1,1,1,2,1,1,1,2);
INSERT INTO IMAGE_ANALYSIS VALUES(9,1,1,4,1,1,1,1,1,1,1,1,1,1,2);


COMMIT;
