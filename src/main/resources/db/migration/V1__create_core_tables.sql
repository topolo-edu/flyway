-- 코어 스키마 (데이터베이스/사용자 생성은 Flyway가 아닌 외부에서 수행)
-- CREATE DATABASE / CREATE USER 는 포함하지 않습니다.

-- 참조 무결성 순서를 고려해 드롭 (idempotent하지 않아 드롭은 생략하는 것이 일반적이나 초기 구축 용도로만 참고)
-- DROP TABLE IF EXISTS enrollment;
-- DROP TABLE IF EXISTS class;
-- DROP TABLE IF EXISTS trainer;
-- DROP TABLE IF EXISTS member;

-- 1) Member
CREATE TABLE member (
                        member_id    BIGINT PRIMARY KEY AUTO_INCREMENT,
                        name         VARCHAR(50)  NOT NULL,
                        phone        VARCHAR(20)  NULL,
                        CONSTRAINT uq_member_phone UNIQUE (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) Trainer
CREATE TABLE trainer (
                         trainer_id   BIGINT PRIMARY KEY AUTO_INCREMENT,
                         name         VARCHAR(50) NOT NULL,
                         specialty    VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) Class
CREATE TABLE class (
                       class_id       BIGINT PRIMARY KEY AUTO_INCREMENT,
                       title          VARCHAR(100) NOT NULL,
                       schedule_time  DATETIME     NOT NULL,
                       trainer_id     BIGINT       NOT NULL,
                       CONSTRAINT fk_class_trainer
                           FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
                               ON UPDATE RESTRICT ON DELETE RESTRICT,
                       KEY idx_class_trainer (trainer_id),
                       KEY idx_class_time (schedule_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) Enrollment
CREATE TABLE enrollment (
                            enrollment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            member_id     BIGINT NOT NULL,
                            class_id      BIGINT NOT NULL,
                            CONSTRAINT fk_enroll_member
                                FOREIGN KEY (member_id) REFERENCES member(member_id)
                                    ON UPDATE RESTRICT ON DELETE CASCADE,
                            CONSTRAINT fk_enroll_class
                                FOREIGN KEY (class_id) REFERENCES class(class_id)
                                    ON UPDATE RESTRICT ON DELETE CASCADE,
                            CONSTRAINT uq_enroll_member_class UNIQUE (member_id, class_id),
                            KEY idx_enroll_member (member_id),
                            KEY idx_enroll_class (class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
