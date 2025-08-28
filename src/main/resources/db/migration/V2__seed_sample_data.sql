-- Member
INSERT INTO member (name, phone) VALUES
                                     ('홍길동', '010-1111-2222'),
                                     ('김영희', '010-3333-4444');

-- Trainer
INSERT INTO trainer (name, specialty) VALUES
                                          ('박코치', '헬스'),
                                          ('이코치', '요가');

-- Class
INSERT INTO class (title, schedule_time, trainer_id) VALUES
                                                         ('헬스 입문반', '2025-09-01 10:00:00', 1), -- 박코치
                                                         ('요가 아침반', '2025-09-03 08:00:00', 2); -- 이코치

-- Enrollment (수강등록)
INSERT INTO enrollment (member_id, class_id) VALUES
                                                 (1, 1),
                                                 (1, 2),
                                                 (2, 2);
