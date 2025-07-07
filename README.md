# 📦 팔도마켓 (Paldo Market) - 중고거래 웹 플랫폼

> Spring Framework 기반의 중고 물품 거래 게시판 프로젝트입니다.
> https://youtu.be/aoZpLVaypK8?si=LVqQ22UvnfAVX0tM
> 
![{233252F2-FC30-4467-9B8D-1957CE8706C0}](https://github.com/user-attachments/assets/84fc74f7-7ce6-41aa-a168-fbeb6a3d0696)
> ![{CD689DA1-F61E-4BF9-AF81-C4474975A243}](https://github.com/user-attachments/assets/eee0d5e1-5059-49c2-943d-ec7307971007)
![{BDAE6D99-2E3F-40B6-B9BF-1DB948C6026D}](https://github.com/user-attachments/assets/f6985605-56ed-4f94-b98f-d3ef3b889d55)

![{E39126B6-5EF3-4D38-BFEE-9B4CE225A293}](https://github.com/user-attachments/assets/a8ddd2d5-48d7-4197-8d15-41f9f3cea242)
> ![{2BE9B2A4-D298-4E7D-B281-9F3A27294EC4}](https://github.com/user-attachments/assets/f7d63fee-53ae-4d37-8a1d-4031658d7567)
> ![{39A5B15A-F69C-4F63-B76B-BD68F6FB04E6}](https://github.com/user-attachments/assets/24f4f8b3-66cf-41f4-88eb-1a6d75cf2c1c)





---

## 🧑‍💻 개발자 소개

**김용석 (Kim Yongsuk)**  
"항상 배우고 끊임없이 도전하는 개발자입니다!"  
팀장 경험을 바탕으로 풀스택 개발 능력을 길렀으며,  
실제 사용자 중심의 기능을 설계/구현한 프로젝트입니다.

---

## 🔧 기술 스택

| 구분 | 기술 |
|------|------|
| 언어 | Java 11 |
| 프레임워크 | Spring Framework 5.2.x, Spring MVC |
| 템플릿 | JSP, JSTL, Tiles |
| ORM | MyBatis |
| 빌드 도구 | Maven (pom.xml) |
| 서버 | Tomcat (WAR 배포) |
| 기타 | Lombok, Log4j, Jackson |

---

## 📌 주요 기능

- **회원 기능**
  - 로그인, 로그아웃, 닉네임 기반 인증
  - 글 등록 시 비밀번호 확인 기능

- **중고 물품 게시판**
  - 상품 등록, 이미지 업로드
  - 제목, 설명, 브랜드, 상태, 가격 등 상세 정보 관리
  - 게시글 상세 조회 및 이미지 썸네일 제공

- **댓글 기능**
  - 게시글 별 댓글 등록/삭제

- **파일 업로드**
  - 게시물 당 여러 이미지 업로드 가능
  - 썸네일과 원본 이미지 관리 분리

- **기타**
  - 브랜드별 상품 필터링 (애플, 삼성, 소니, 기타 등)
  - Bootstrap 기반 반응형 UI
  - 관리자 없이도 셀프 게시물 관리 가능

---

## 📁 프로젝트 구조 (일부)

src/
├── main/
│ ├── java/
│ │ └── org.sample.controller/ # 컨트롤러
│ │ └── org.sample.domain/ # VO
│ │ └── org.sample.mapper/ # MyBatis 인터페이스
│ ├── resources/
│ ├── webapp/
│ │ └── views/ # JSP 페이지
│ │ └── upload/ # 업로드된 이미지


---

## 🖼️ 화면 미리보기 (추후 이미지 추가 가능)

- 메인 상품 리스트
- 게시글 상세 페이지 (이미지 + 정보 레이아웃)
- 댓글 기능
- 등록 폼 / 로그인

---

## ⚙️ 프로젝트 실행 방법

1. IntelliJ 또는 Eclipse에서 `pom.xml` 열기 (Maven 프로젝트로 import)
2. DB 연동 (MySQL 등) 후 `src/main/resources/mybatis/config.xml` 수정
3. Tomcat 설정 후 WAR 배포
4. http://localhost:8080 접속

---

## 📫 연락처

- GitHub: [https://github.com/Cr7-Ronaldo](https://github.com/Cr7-Ronaldo)
- Email: your-email@example.com

---

> 본 프로젝트는 실무형 포트폴리오로 구성되었으며, Spring MVC + MyBatis 기반 웹 애플리케이션 구조를 학습하고자 하는 개발자에게 도움이 됩니다.
