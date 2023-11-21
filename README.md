# flutter_chat_with_firebase

파이어베이스를 통한 채팅 기능 구현

- 데이터베이스 선택
realtime database, firestore database 두 가지 구조가 있는데,
수업에 쓰인 firestore의 기능만으로 충분히 구현 가능하다.
(참고) Firestore 데이터 모델
    JSON 데이터베이스(NoSQL)
    테이블이나 행이 없음
    컬렉션 : Table
    Document : Record
    모든 항목은 JSON 객체

- 구조
root
프로젝트 컬렉션
-> 문서s 
-> 필드s & 컬렉션s
            -> 문서s 
            -> 필드s & 컬렉션s
이 때 필드s는 문서에 적혀있는 내용들
컬렉션s는 생략 가능
컬렉션 ID는 지정 가능, 문서 ID는 자동으로 생성

- 현재 데이터베이스 구성
데모라서 간단하게 구성함
flutter_chat_demo_2 : 컬렉션(root컬렉션 느낌?). 문서 하나만 생성
    -> 하위 문서 : chat_room_list

chat_room_list : 문서. 하나밖에 없으므로 편하게 쓰기 위해 이름 지정
    -> 필드 : 없음
    -> 하위 컬렉션 : pat_mat, tom_jerry

pat_mat, tom_jerry : 컬렉션들. 채팅방 ID처럼 사용하기 위해 유저 두 명의 이름으로 컬렉션 생성.
    -> 하위 문서 : 문서s. 문서 이름 자동 생성.

문서s : 메시지 하나 당 문서 하나. 엄청 많으므로 문서 이름 자동 생성.
    -> 필드 : content, sender

streambuilder로 채팅방 실시간 업뎃

남은 과제
1. message객체를 위한 클래스 생성
2. 유저 객체와 연동성 구축
3. 뒤죽박죽인 순서 해결
4. UI 다듬기
5. 2명만 채팅하도록 제한