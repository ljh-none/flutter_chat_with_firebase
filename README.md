# flutter_chat_with_firebase

파이어베이스를 통한 실시간 채팅 기능 구현하기

- 데이터베이스 선택
realtime database, firestore database 두 가지 구조가 있는데,
수업에 쓰인 firestore의 기능만으로 충분히 구현 가능하다.

- Firestore 데이터 모델
JSON 데이터베이스(NoSQL)
테이블이나 행이 없음
컬렉션 : Table
Document : Record
모든 항목은 JSON 객체

- 구조
프로젝트(root 컬렉션 역할인듯)
-> 문서s 
-> 필드s & 컬렉션s
            -> 문서s 
            -> 필드s & 컬렉션s
이 때 필드s는 문서에 적혀있는 내용들
컬렉션s는 생략 가능
컬렉션 ID는 지정 가능, 문서 ID는 자동으로 생성

- 현재 데이터베이스 구성
데모라서 간단하게 구성함
flutter_chat_sample (프로젝트, 컬렉션 형태)
channel_A, channel_B 채팅 채널(문서)

channel_A 문서의 데이터
user_A, user_B : 필드(데이터, 유저 닉네임)
messages : 메시지 객체?들의 집합(컬렉션)

messages 컬렉션의 문서
message 1, 2, 3 : 문서, 메시지 하나 당 문서 하나
-> message_1의 필드 : content(텍스트), writer(메시지 작성자)

stream으로 채팅방 실시간 업뎃

남은 과제
1. 채팅방 구분은 어떻게 하지?
파이어베이스 데이터베이스 구조