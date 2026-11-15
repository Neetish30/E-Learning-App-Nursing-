-- Optional: sample course so the app isn't empty. Run after schema.sql.
do $$
declare c uuid; m1 uuid; m2 uuid; a uuid;
begin
  insert into courses (title, description, category, emoji)
  values ('Fundamentals of Nursing', 'Core nursing concepts: patient safety, vital signs and infection control.', 'Beginner', '🩺')
  returning id into c;

  insert into modules (course_id, title, position) values (c, 'Module 1: Patient Safety', 1) returning id into m1;
  insert into modules (course_id, title, position) values (c, 'Module 2: Vital Signs', 2) returning id into m2;

  insert into lessons (course_id, module_id, title, type, body, minutes, position) values
   (c, m1, 'Why patient safety matters', 'text',
    E'# Patient safety\n\nPatient safety means preventing errors and harm during care.\n\n- Always verify patient identity with two identifiers\n- Perform hand hygiene before and after contact\n- Report incidents and near-misses\n\nSafe care is **everyone''s** responsibility.', 5, 1);

  insert into lessons (course_id, module_id, title, type, url, minutes, position) values
   (c, m1, 'Hand hygiene (video)', 'video', 'https://www.youtube.com/watch?v=IisgnbMfKvI', 4, 2);

  insert into lessons (course_id, module_id, title, type, cards, minutes, position) values
   (c, m2, 'Normal adult vital signs', 'flashcards',
    '[{"q":"Normal adult resting heart rate?","a":"60–100 beats per minute"},
      {"q":"Normal adult respiratory rate?","a":"12–20 breaths per minute"},
      {"q":"Normal adult body temperature?","a":"36.1–37.2 °C (97–99 °F)"},
      {"q":"Normal SpO2?","a":"95–100%"}]'::jsonb, 6, 1);

  insert into assessments (course_id, title, description, pass_mark)
  values (c, 'Quiz: Nursing basics', 'Check what you learned in Modules 1 and 2.', 70) returning id into a;

  insert into questions (assessment_id, prompt, options, correct, explanation, position) values
   (a, 'How many patient identifiers should you check before giving care?', '["One","Two","Three","None"]', 1, 'Use at least two identifiers, e.g. name and date of birth.', 1),
   (a, 'Normal adult resting heart rate is…', '["30–50 bpm","60–100 bpm","110–140 bpm","150+ bpm"]', 1, '60–100 beats per minute.', 2),
   (a, 'When should hand hygiene be performed?', '["Only before surgery","Only after contact","Before and after patient contact","Never"]', 2, 'Before AND after every patient contact.', 3);
end $$;
