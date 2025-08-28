-- 1) 컬럼 추가
ALTER TABLE class
    ADD COLUMN room VARCHAR(50) AFTER schedule_time;

-- 2) 기존 데이터 보정(예시)
UPDATE class SET room = 'A-101호' WHERE class_id = 1;
UPDATE class SET room = 'GX룸'   WHERE class_id = 2;
