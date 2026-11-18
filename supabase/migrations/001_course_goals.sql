-- Run once in Supabase → SQL Editor. Safe to run twice.
-- 1) Admin-set goals per course
alter table courses add column if not exists daily_goal int not null default 3 check (daily_goal between 0 and 50);
alter table courses add column if not exists target_date date;
-- 2) Completed lessons can never be un-completed (enforced on the server too)
drop policy if exists "progress delete" on lesson_progress;
