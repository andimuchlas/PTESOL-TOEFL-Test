-- ============================================================
-- CLEANUP AND RESTRUCTURE: Reduce Total Questions
-- ============================================================
-- Goal: Reduce from 550 to 330 total questions
-- New distribution:
-- - Listening: 180 (reduced from 200)
-- - Structure: 75 (Q1-25 completion, Q26-75 error identification)
-- - Reading: 75 (15 passages, 5 questions each)
-- ============================================================

-- STEP 1: Delete excess Listening questions (keep only 1-180)
-- ============================================================
DELETE FROM questions 
WHERE section = 'listening' AND question_number > 180;

-- STEP 2: Delete excess Structure questions (keep only 1-75)
-- ============================================================
DELETE FROM questions 
WHERE section = 'structure' AND question_number > 75;

-- STEP 3: Delete excess Reading questions (keep only 1-75)
-- ============================================================
DELETE FROM questions 
WHERE section = 'reading' AND question_number > 75;

-- STEP 4: Add passage_text column if not exists
-- ============================================================
ALTER TABLE questions 
ADD COLUMN IF NOT EXISTS passage_text TEXT;

CREATE INDEX IF NOT EXISTS idx_questions_passage 
ON questions(section, passage_text);

-- ============================================================
-- STRUCTURE SECTION RESTRUCTURE (75 questions)
-- ============================================================

-- Q1-25: Sentence Completion (fill in the blank)
-- ============================================================

UPDATE questions SET question_text = 'The company''s new policy _____ all employees to work from home twice a week.' WHERE section = 'structure' AND question_number = 1;
UPDATE questions SET question_text = 'Despite _____ warnings from the government, many tourists still visited the area.' WHERE section = 'structure' AND question_number = 2;
UPDATE questions SET question_text = 'The scientists discovered that the ancient artifact _____ over 3,000 years old.' WHERE section = 'structure' AND question_number = 3;
UPDATE questions SET question_text = 'Not until the 19th century _____ the importance of hygiene in medicine.' WHERE section = 'structure' AND question_number = 4;
UPDATE questions SET question_text = 'The committee decided to postpone the meeting _____ the chairman could attend.' WHERE section = 'structure' AND question_number = 5;
UPDATE questions SET question_text = 'Students _____ to submit their assignments by Friday will receive a penalty.' WHERE section = 'structure' AND question_number = 6;
UPDATE questions SET question_text = 'The museum, _____ houses rare paintings, attracts thousands of visitors annually.' WHERE section = 'structure' AND question_number = 7;
UPDATE questions SET question_text = 'Had the weather been better, we _____ to the beach for our vacation.' WHERE section = 'structure' AND question_number = 8;
UPDATE questions SET question_text = 'The manager suggested _____ the project deadline by two weeks.' WHERE section = 'structure' AND question_number = 9;
UPDATE questions SET question_text = 'Research shows that regular exercise, _____ with a balanced diet, improves health.' WHERE section = 'structure' AND question_number = 10;
UPDATE questions SET question_text = 'The architect designed a building _____ could withstand earthquakes.' WHERE section = 'structure' AND question_number = 11;
UPDATE questions SET question_text = '_____ the heavy rain, the concert was held as scheduled.' WHERE section = 'structure' AND question_number = 12;
UPDATE questions SET question_text = 'The professor explained the theory in _____ way that everyone understood it.' WHERE section = 'structure' AND question_number = 13;
UPDATE questions SET question_text = 'By the time the rescue team arrived, the survivors _____ for three days.' WHERE section = 'structure' AND question_number = 14;
UPDATE questions SET question_text = 'The company''s profits have increased significantly, _____ to expanded operations.' WHERE section = 'structure' AND question_number = 15;
UPDATE questions SET question_text = 'The new regulations _____ companies to reduce carbon emissions by 2030.' WHERE section = 'structure' AND question_number = 16;
UPDATE questions SET question_text = 'She would have attended the conference _____ she had known about it earlier.' WHERE section = 'structure' AND question_number = 17;
UPDATE questions SET question_text = 'The book, _____ was published last year, became an instant bestseller.' WHERE section = 'structure' AND question_number = 18;
UPDATE questions SET question_text = '_____ his lack of experience, he performed remarkably well in the interview.' WHERE section = 'structure' AND question_number = 19;
UPDATE questions SET question_text = 'The team needs to finish the report _____ the deadline expires.' WHERE section = 'structure' AND question_number = 20;
UPDATE questions SET question_text = 'Scientists believe that the new vaccine _____ effective against the virus.' WHERE section = 'structure' AND question_number = 21;
UPDATE questions SET question_text = 'The director insisted that all participants _____ on time for the meeting.' WHERE section = 'structure' AND question_number = 22;
UPDATE questions SET question_text = '_____ of the students passed the final examination with high marks.' WHERE section = 'structure' AND question_number = 23;
UPDATE questions SET question_text = 'The company invested heavily in technology _____ improve productivity.' WHERE section = 'structure' AND question_number = 24;
UPDATE questions SET question_text = 'By next year, the construction project _____ for five years.' WHERE section = 'structure' AND question_number = 25;

-- Q26-75: Error Identification (find the underlined error)
-- ============================================================

UPDATE questions SET question_text = 'The museum <u>contains</u> many <u>historical</u> artifacts, some of <u>them</u> dating back <u>to</u> ancient times.' WHERE section = 'structure' AND question_number = 26;
UPDATE questions SET question_text = '<u>Each</u> of the students <u>were</u> required to <u>submit</u> a research paper <u>by</u> the end of the semester.' WHERE section = 'structure' AND question_number = 27;
UPDATE questions SET question_text = 'The company <u>has been</u> <u>working</u> on the project <u>since</u> three years with <u>limited</u> success.' WHERE section = 'structure' AND question_number = 28;
UPDATE questions SET question_text = '<u>Despite</u> of the heavy rain, the outdoor concert <u>was held</u> as <u>scheduled</u> without <u>any</u> delays.' WHERE section = 'structure' AND question_number = 29;
UPDATE questions SET question_text = 'The teacher <u>explained</u> the lesson <u>clear</u> enough for all students to <u>understand</u> the <u>complex</u> concepts.' WHERE section = 'structure' AND question_number = 30;
UPDATE questions SET question_text = 'The new bridge, <u>which</u> <u>construction</u> began last year, <u>is expected</u> to <u>be completed</u> by 2026.' WHERE section = 'structure' AND question_number = 31;
UPDATE questions SET question_text = '<u>Having</u> finished his homework, John <u>went</u> to the park <u>for</u> playing soccer with <u>his friends</u>.' WHERE section = 'structure' AND question_number = 32;
UPDATE questions SET question_text = 'The experiment <u>was</u> conducted <u>careful</u> by a team of <u>experienced</u> <u>researchers</u>.' WHERE section = 'structure' AND question_number = 33;
UPDATE questions SET question_text = 'She is <u>one</u> of the <u>most talented</u> musicians <u>who</u> <u>has</u> ever performed at this venue.' WHERE section = 'structure' AND question_number = 34;
UPDATE questions SET question_text = 'The report <u>must</u> be <u>submitted</u> <u>until</u> Friday, or there will be <u>penalties</u>.' WHERE section = 'structure' AND question_number = 35;
UPDATE questions SET question_text = '<u>Neither</u> the students <u>nor</u> the teacher <u>were</u> aware of the <u>schedule</u> change.' WHERE section = 'structure' AND question_number = 36;
UPDATE questions SET question_text = 'A pharmacist <u>supplies</u> prescribed medications and <u>gives</u> information <u>to patients</u> about <u>theirs</u> use.' WHERE section = 'structure' AND question_number = 37;
UPDATE questions SET question_text = 'The book <u>that</u> I borrowed from the library <u>is</u> more <u>interesting</u> <u>than</u> I expected.' WHERE section = 'structure' AND question_number = 38;
UPDATE questions SET question_text = '<u>Although</u> she studied hard, <u>but</u> she <u>did not</u> pass the <u>examination</u>.' WHERE section = 'structure' AND question_number = 39;
UPDATE questions SET question_text = 'The committee <u>has</u> <u>made</u> a decision to <u>postpone</u> the event <u>until</u> next month.' WHERE section = 'structure' AND question_number = 40;
UPDATE questions SET question_text = 'Many <u>people</u> enjoys <u>spending</u> their weekends <u>hiking</u> in the <u>mountains</u>.' WHERE section = 'structure' AND question_number = 41;
UPDATE questions SET question_text = 'The <u>conference</u>, which <u>was held</u> in Tokyo, <u>attracted</u> participants from <u>all over</u> the world.' WHERE section = 'structure' AND question_number = 42;
UPDATE questions SET question_text = 'He speaks English <u>more fluent</u> <u>than</u> anyone else <u>in</u> the <u>class</u>.' WHERE section = 'structure' AND question_number = 43;
UPDATE questions SET question_text = 'The data <u>was</u> <u>collected</u> and <u>analyzed</u> by our research <u>team</u>.' WHERE section = 'structure' AND question_number = 44;
UPDATE questions SET question_text = '<u>By</u> the time we arrived, the show <u>already started</u> and we <u>missed</u> the <u>opening</u> act.' WHERE section = 'structure' AND question_number = 45;
UPDATE questions SET question_text = 'The professor <u>suggested</u> that each student <u>submits</u> their assignments <u>before</u> the <u>deadline</u>.' WHERE section = 'structure' AND question_number = 46;
UPDATE questions SET question_text = 'This is the <u>most</u> <u>challenging</u> project that our team <u>has</u> ever <u>worked</u> on.' WHERE section = 'structure' AND question_number = 47;
UPDATE questions SET question_text = '<u>The number</u> of students <u>studying</u> abroad <u>have increased</u> <u>significantly</u> this year.' WHERE section = 'structure' AND question_number = 48;
UPDATE questions SET question_text = 'She is <u>interested</u> in <u>to learn</u> more about <u>ancient</u> <u>civilizations</u>.' WHERE section = 'structure' AND question_number = 49;
UPDATE questions SET question_text = 'The results of the survey <u>was</u> <u>published</u> in a <u>prestigious</u> <u>journal</u>.' WHERE section = 'structure' AND question_number = 50;
UPDATE questions SET question_text = '<u>Between</u> you and <u>I</u>, this is the <u>best</u> <u>opportunity</u> we have had.' WHERE section = 'structure' AND question_number = 51;
UPDATE questions SET question_text = 'The team <u>has been</u> <u>preparing</u> for the competition <u>during</u> several <u>months</u>.' WHERE section = 'structure' AND question_number = 52;
UPDATE questions SET question_text = 'She <u>denied</u> <u>to take</u> the money from the <u>safe</u> in the <u>office</u>.' WHERE section = 'structure' AND question_number = 53;
UPDATE questions SET question_text = '<u>If</u> I <u>would have</u> known about the traffic, I <u>would have left</u> <u>earlier</u>.' WHERE section = 'structure' AND question_number = 54;
UPDATE questions SET question_text = 'The documentary was <u>so</u> interesting that everyone <u>wanted</u> <u>to watch</u> it <u>again</u>.' WHERE section = 'structure' AND question_number = 55;
UPDATE questions SET question_text = '<u>Most</u> of the <u>information</u> in these reports <u>are</u> <u>outdated</u> and need revision.' WHERE section = 'structure' AND question_number = 56;
UPDATE questions SET question_text = 'The manager <u>asked</u> the employees <u>working</u> overtime to <u>complete</u> the <u>urgent</u> tasks.' WHERE section = 'structure' AND question_number = 57;
UPDATE questions SET question_text = 'She has <u>difficulty</u> <u>to understand</u> complex <u>mathematical</u> <u>equations</u>.' WHERE section = 'structure' AND question_number = 58;
UPDATE questions SET question_text = '<u>Not only</u> the manager but also the employees <u>was</u> <u>surprised</u> by the <u>announcement</u>.' WHERE section = 'structure' AND question_number = 59;
UPDATE questions SET question_text = 'The house <u>that</u> we visited yesterday <u>was</u> <u>built</u> in <u>the</u> 18th century.' WHERE section = 'structure' AND question_number = 60;
UPDATE questions SET question_text = 'He insisted <u>on</u> <u>to complete</u> the project <u>by himself</u> without <u>any help</u>.' WHERE section = 'structure' AND question_number = 61;
UPDATE questions SET question_text = '<u>Each</u> department <u>are</u> responsible for <u>maintaining</u> their own <u>records</u>.' WHERE section = 'structure' AND question_number = 62;
UPDATE questions SET question_text = 'The lecture was <u>too</u> difficult for <u>most</u> students <u>to</u> <u>understand</u>.' WHERE section = 'structure' AND question_number = 63;
UPDATE questions SET question_text = 'She wishes she <u>has</u> more time to <u>spend</u> with her <u>family</u> during the <u>holidays</u>.' WHERE section = 'structure' AND question_number = 64;
UPDATE questions SET question_text = '<u>The</u> equipment in the laboratory <u>need</u> to be <u>replaced</u> as soon as <u>possible</u>.' WHERE section = 'structure' AND question_number = 65;
UPDATE questions SET question_text = 'He <u>has been</u> <u>living</u> in Paris <u>since</u> five years and speaks French <u>fluently</u>.' WHERE section = 'structure' AND question_number = 66;
UPDATE questions SET question_text = '<u>Either</u> the teacher or the students <u>has</u> to <u>reschedule</u> the <u>meeting</u>.' WHERE section = 'structure' AND question_number = 67;
UPDATE questions SET question_text = 'The <u>news</u> about the merger <u>were</u> <u>announced</u> at yesterday''s <u>conference</u>.' WHERE section = 'structure' AND question_number = 68;
UPDATE questions SET question_text = 'She <u>avoids</u> <u>to speak</u> in public because of her <u>shyness</u> and <u>nervousness</u>.' WHERE section = 'structure' AND question_number = 69;
UPDATE questions SET question_text = '<u>Had</u> I known about the problem, I <u>would</u> <u>have helped</u> you <u>immediately</u>.' WHERE section = 'structure' AND question_number = 70;
UPDATE questions SET question_text = 'The children was <u>excited</u> about <u>going</u> to the amusement park <u>next</u> <u>weekend</u>.' WHERE section = 'structure' AND question_number = 71;
UPDATE questions SET question_text = '<u>A</u> large number of applicants <u>has</u> applied for the <u>position</u> this <u>year</u>.' WHERE section = 'structure' AND question_number = 72;
UPDATE questions SET question_text = 'The meeting will be <u>held</u> on Friday <u>morning</u> in the <u>conference</u> <u>room</u>.' WHERE section = 'structure' AND question_number = 73;
UPDATE questions SET question_text = 'She is <u>looking forward</u> to <u>meet</u> her old friends at the <u>reunion</u> <u>party</u>.' WHERE section = 'structure' AND question_number = 74;
UPDATE questions SET question_text = '<u>Neither</u> of the solutions <u>were</u> <u>acceptable</u> to the <u>management</u>.' WHERE section = 'structure' AND question_number = 75;

-- ============================================================
-- READING SECTION RESTRUCTURE (75 questions, 15 passages)
-- ============================================================

-- Passage 1: Coral Reefs (Q1-5)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Coral reefs are among the most diverse and valuable ecosystems on Earth. These underwater structures are built by colonies of tiny animals called coral polyps, which secrete calcium carbonate to form hard skeletons. Over thousands of years, these skeletons accumulate to create massive reef structures that provide habitat for countless marine species.

Coral reefs cover less than 1% of the ocean floor, yet they support approximately 25% of all marine life. They serve as breeding grounds, nurseries, and feeding areas for thousands of species of fish, invertebrates, and other organisms. The complex three-dimensional structure of reefs creates numerous niches and hiding places, contributing to their exceptional biodiversity.

Beyond their ecological importance, coral reefs provide significant economic benefits to human communities. They protect coastlines from erosion and storm damage, support fishing industries, and attract tourism. However, coral reefs face numerous threats including climate change, ocean acidification, pollution, and destructive fishing practices. Scientists estimate that without intervention, most coral reefs could disappear within the next few decades.',
  question_text = 'What is the primary building material of coral reefs?'
WHERE section = 'reading' AND question_number = 1;

UPDATE questions SET question_text = 'According to the passage, what percentage of marine life do coral reefs support?' WHERE section = 'reading' AND question_number = 2;
UPDATE questions SET question_text = 'The word "niches" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 3;
UPDATE questions SET question_text = 'Which of the following is NOT mentioned as a benefit of coral reefs?' WHERE section = 'reading' AND question_number = 4;
UPDATE questions SET question_text = 'What can be inferred about the future of coral reefs?' WHERE section = 'reading' AND question_number = 5;

-- Passage 2: Ancient Rome (Q6-10)
-- ============================================================
UPDATE questions SET 
  passage_text = 'The Roman Empire, at its height, was one of the most powerful and influential civilizations in human history. Spanning from Britain to North Africa and from Spain to the Middle East, Rome controlled vast territories and diverse populations. The success of Roman expansion was due to several factors, including superior military organization, advanced engineering, and effective administrative systems.

Roman engineering achievements were particularly remarkable. The construction of roads, aqueducts, and buildings demonstrated sophisticated understanding of architecture and materials. Roman roads, built with multiple layers of materials and designed with proper drainage, connected the empire and facilitated trade, communication, and military movement. Many of these roads are still in use today, testament to their quality.

The Roman legal system also had lasting impact on Western civilization. Roman law introduced concepts such as the presumption of innocence and the right to a fair trial. The development of written laws that applied to all citizens represented a significant advance in governance. These legal principles influenced the development of legal systems throughout Europe and continue to shape modern law in many countries.',
  question_text = 'What is the main topic of the passage?'
WHERE section = 'reading' AND question_number = 6;

UPDATE questions SET question_text = 'According to paragraph 1, what contributed to Roman expansion?' WHERE section = 'reading' AND question_number = 7;
UPDATE questions SET question_text = 'The word "testament" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 8;
UPDATE questions SET question_text = 'What does the passage suggest about Roman law?' WHERE section = 'reading' AND question_number = 9;
UPDATE questions SET question_text = 'Which statement best describes Roman roads?' WHERE section = 'reading' AND question_number = 10;

-- Passage 3: Climate Change (Q11-15)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Climate change represents one of the most significant challenges facing humanity in the 21st century. The overwhelming scientific consensus indicates that Earth''s climate is warming primarily due to human activities, particularly the emission of greenhouse gases from burning fossil fuels. Temperature records show that the planet has warmed by approximately 1.1°C since pre-industrial times, with most of this warming occurring in recent decades.

The effects of climate change are already evident worldwide. Glaciers and ice sheets are melting at accelerating rates, contributing to rising sea levels. Extreme weather events, including hurricanes, droughts, and heat waves, are becoming more frequent and intense. Changes in precipitation patterns affect agriculture and water supplies, while warming oceans threaten marine ecosystems and coastal communities.

Addressing climate change requires coordinated global action. The Paris Agreement, signed by nearly 200 countries, aims to limit global temperature increase to well below 2°C above pre-industrial levels. Achieving this goal necessitates transitioning to renewable energy sources, improving energy efficiency, protecting forests, and developing new technologies to reduce emissions. While the challenge is immense, many experts believe that with sufficient political will and technological innovation, the worst impacts of climate change can still be avoided.',
  question_text = 'What is the primary cause of current climate change according to the passage?'
WHERE section = 'reading' AND question_number = 11;

UPDATE questions SET question_text = 'How much has Earth''s temperature increased since pre-industrial times?' WHERE section = 'reading' AND question_number = 12;
UPDATE questions SET question_text = 'The word "consensus" in paragraph 1 is closest in meaning to' WHERE section = 'reading' AND question_number = 13;
UPDATE questions SET question_text = 'What is the goal of the Paris Agreement?' WHERE section = 'reading' AND question_number = 14;
UPDATE questions SET question_text = 'The author''s attitude toward addressing climate change can best be described as' WHERE section = 'reading' AND question_number = 15;

-- Passage 4: Memory and Learning (Q16-20)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Human memory is a complex system involving multiple brain regions and processes. Psychologists typically divide memory into three main types: sensory memory, short-term memory, and long-term memory. Sensory memory holds information from our senses for just a few seconds, allowing us to perceive the world as continuous rather than as a series of disconnected snapshots. Information that receives attention is transferred to short-term memory, which can hold approximately seven items for about 20-30 seconds.

Long-term memory has essentially unlimited capacity and can store information for years or even a lifetime. This type of memory is further divided into explicit memory (conscious memories of facts and events) and implicit memory (unconscious memories such as skills and habits). The process of consolidating memories from short-term to long-term storage involves the hippocampus, a brain structure critical for learning and memory formation.

Research has identified several strategies that enhance memory and learning. Spaced repetition, where information is reviewed at gradually increasing intervals, is more effective than cramming. Elaborative encoding, which involves connecting new information to existing knowledge, strengthens memory formation. Sleep also plays a crucial role in memory consolidation, as the brain processes and stores information during sleep. Understanding these mechanisms helps educators develop more effective teaching methods and enables individuals to optimize their learning.',
  question_text = 'How many main types of memory does the passage describe?'
WHERE section = 'reading' AND question_number = 16;

UPDATE questions SET question_text = 'According to the passage, how long can short-term memory typically hold information?' WHERE section = 'reading' AND question_number = 17;
UPDATE questions SET question_text = 'The word "consolidating" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 18;
UPDATE questions SET question_text = 'What is the role of the hippocampus?' WHERE section = 'reading' AND question_number = 19;
UPDATE questions SET question_text = 'Which learning strategy is mentioned as MORE effective than cramming?' WHERE section = 'reading' AND question_number = 20;

-- Passage 5: Renaissance Art (Q21-25)
-- ============================================================
UPDATE questions SET 
  passage_text = 'The Renaissance, spanning roughly from the 14th to the 17th century, marked a period of extraordinary cultural and artistic achievement in Europe. This era saw a revival of interest in classical Greek and Roman culture, combined with new techniques and perspectives that revolutionized art. Renaissance artists developed linear perspective, a mathematical system for creating the illusion of three-dimensional space on a flat surface, fundamentally changing how artists represented the world.

Leonardo da Vinci, Michelangelo, and Raphael are often considered the three greatest masters of the High Renaissance. Leonardo''s works, including the Mona Lisa and The Last Supper, demonstrate his mastery of sfumato, a technique creating soft, almost imperceptible transitions between colors and tones. Michelangelo''s sculptures, such as David, and his frescoes in the Sistine Chapel showcase his profound understanding of human anatomy and emotion. Raphael''s paintings, characterized by clarity of form and ease of composition, epitomize the harmony and balance that defined Renaissance ideals.

The Renaissance also saw significant changes in the social status of artists. Previously considered mere craftsmen, artists increasingly gained recognition as intellectuals and creative geniuses. Wealthy patrons, including the Medici family in Florence and various popes in Rome, commissioned major works and supported artists financially. This patronage system enabled artists to devote themselves fully to their craft and produce masterpieces that continue to inspire and influence art today.',
  question_text = 'What was one of the key technical innovations of Renaissance art?'
WHERE section = 'reading' AND question_number = 21;

UPDATE questions SET question_text = 'The word "epitomize" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 22;
UPDATE questions SET question_text = 'According to the passage, what was sfumato?' WHERE section = 'reading' AND question_number = 23;
UPDATE questions SET question_text = 'How did the social status of artists change during the Renaissance?' WHERE section = 'reading' AND question_number = 24;
UPDATE questions SET question_text = 'Who were major patrons of Renaissance art?' WHERE section = 'reading' AND question_number = 25;

-- Passage 6: Ocean Currents (Q26-30)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Ocean currents are continuous movements of water driven by various forces including wind, temperature differences, salinity gradients, and the Earth''s rotation. These currents play a vital role in regulating global climate by redistributing heat from the equator toward the poles. Surface currents, driven primarily by wind, affect the upper 400 meters of the ocean, while deep ocean currents, driven by differences in water density, circulate water throughout the ocean depths.

The Gulf Stream is one of the most powerful ocean currents, transporting warm water from the Gulf of Mexico along the eastern coast of North America and across the Atlantic toward Europe. This current has significant effects on climate, keeping Western European temperatures considerably warmer than other regions at similar latitudes. Without the Gulf Stream, countries like Britain and Norway would experience much harsher winters.

Understanding ocean currents is crucial for multiple reasons. They influence weather patterns, affect marine ecosystems by transporting nutrients and organisms, and impact commercial shipping routes. Climate scientists closely monitor these currents because changes in their strength or direction could indicate broader shifts in global climate patterns. Some research suggests that climate change may be altering major ocean currents, with potentially far-reaching consequences for weather, marine life, and human societies.',
  question_text = 'What are the main forces that drive ocean currents?'
WHERE section = 'reading' AND question_number = 26;

UPDATE questions SET question_text = 'How deep do surface currents typically extend?' WHERE section = 'reading' AND question_number = 27;
UPDATE questions SET question_text = 'What would happen to Western Europe without the Gulf Stream?' WHERE section = 'reading' AND question_number = 28;
UPDATE questions SET question_text = 'The word "monitor" in paragraph 3 is closest in meaning to' WHERE section = 'reading' AND question_number = 29;
UPDATE questions SET question_text = 'Why is understanding ocean currents important?' WHERE section = 'reading' AND question_number = 30;

-- Passage 7: Photosynthesis (Q31-35)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Photosynthesis is the fundamental process by which plants, algae, and certain bacteria convert light energy into chemical energy stored in glucose. This process not only sustains the organisms that perform it but also produces oxygen as a byproduct, making Earth''s atmosphere breathable for animals and humans. Photosynthesis occurs primarily in the chloroplasts of plant cells, specifically in structures called thylakoids where the green pigment chlorophyll captures light energy.

The process consists of two main stages: light-dependent reactions and light-independent reactions (also called the Calvin cycle). During light-dependent reactions, chlorophyll absorbs light energy, which is used to split water molecules, releasing oxygen and generating energy-carrying molecules ATP and NADPH. These energy carriers then power the Calvin cycle, where carbon dioxide from the atmosphere is converted into glucose through a series of chemical reactions.

The efficiency and rate of photosynthesis are affected by several environmental factors. Light intensity, carbon dioxide concentration, and temperature all influence the process. Plants have evolved various adaptations to optimize photosynthesis in different environments. For instance, cacti have developed a special pathway that allows them to perform photosynthesis efficiently in hot, dry conditions while minimizing water loss. Understanding photosynthesis is crucial not only for plant biology but also for addressing challenges in agriculture and developing sustainable energy solutions.',
  question_text = 'Where does photosynthesis primarily occur in plant cells?'
WHERE section = 'reading' AND question_number = 31;

UPDATE questions SET question_text = 'What are the two main stages of photosynthesis?' WHERE section = 'reading' AND question_number = 32;
UPDATE questions SET question_text = 'The word "captures" in paragraph 1 is closest in meaning to' WHERE section = 'reading' AND question_number = 33;
UPDATE questions SET question_text = 'What is produced during the light-dependent reactions?' WHERE section = 'reading' AND question_number = 34;
UPDATE questions SET question_text = 'Why is understanding photosynthesis important beyond plant biology?' WHERE section = 'reading' AND question_number = 35;

-- Passage 8: Urban Planning (Q36-40)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Urban planning is the process of designing and organizing the physical, social, and economic aspects of urban areas to create functional, sustainable, and livable cities. As global urbanization accelerates, with more than half the world''s population now living in cities, effective urban planning has become increasingly critical. Planners must balance competing demands for housing, transportation, commercial development, green spaces, and infrastructure while considering environmental sustainability and quality of life.

One major challenge in urban planning is managing transportation and mobility. Traffic congestion wastes time, increases pollution, and reduces quality of life. Many cities are implementing multimodal transportation systems that integrate public transit, cycling infrastructure, and pedestrian-friendly designs. Complete streets, designed to accommodate all users including pedestrians, cyclists, motorists, and public transit, represent a shift from automobile-centric planning toward more inclusive and sustainable approaches.

Another crucial aspect of modern urban planning is creating environmentally sustainable cities. This involves reducing carbon emissions, managing water resources, preserving green spaces, and designing energy-efficient buildings. Some cities are adopting "green infrastructure" such as rain gardens, green roofs, and urban forests to manage stormwater, reduce heat island effects, and improve air quality. The concept of "15-minute cities," where residents can access most daily necessities within a 15-minute walk or bike ride, aims to reduce transportation needs while creating more vibrant, connected communities.',
  question_text = 'What is the main purpose of urban planning according to the passage?'
WHERE section = 'reading' AND question_number = 36;

UPDATE questions SET question_text = 'What does "multimodal transportation" refer to?' WHERE section = 'reading' AND question_number = 37;
UPDATE questions SET question_text = 'The word "implementing" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 38;
UPDATE questions SET question_text = 'What is the purpose of green infrastructure in cities?' WHERE section = 'reading' AND question_number = 39;
UPDATE questions SET question_text = 'What is the concept of "15-minute cities"?' WHERE section = 'reading' AND question_number = 40;

-- Passage 9: Antibiotics (Q41-45)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Antibiotics are powerful medicines that fight bacterial infections by either killing bacteria or preventing their reproduction. The discovery of penicillin by Alexander Fleming in 1928 marked the beginning of the antibiotic era, revolutionizing medicine and saving millions of lives. Before antibiotics, even minor infections could prove fatal, and surgical procedures carried enormous risk. The introduction of antibiotics transformed healthcare, making previously deadly diseases treatable and enabling the development of modern surgery and cancer treatments.

However, the effectiveness of antibiotics is threatened by antibiotic resistance, which occurs when bacteria evolve mechanisms to survive exposure to antibiotics. This resistance develops through natural selection: when antibiotics kill susceptible bacteria, resistant bacteria survive and multiply, passing resistance genes to their offspring and sometimes to other bacteria. Overuse and misuse of antibiotics in human medicine and agriculture accelerate this process. Some bacteria have developed resistance to multiple antibiotics, creating "superbugs" that are extremely difficult to treat.

Addressing antibiotic resistance requires coordinated action on multiple fronts. Healthcare providers must prescribe antibiotics only when necessary and ensure patients complete their full course of treatment. Agriculture should reduce antibiotic use in livestock. Pharmaceutical companies need to develop new antibiotics, though this is challenging due to scientific and economic factors. Public health campaigns educate people about appropriate antibiotic use. Additionally, researchers are exploring alternative treatments such as bacteriophages (viruses that infect bacteria) and developing rapid diagnostic tests to identify bacterial infections and determine which antibiotics will be effective.',
  question_text = 'When was penicillin discovered?'
WHERE section = 'reading' AND question_number = 41;

UPDATE questions SET question_text = 'How do antibiotics work against bacteria?' WHERE section = 'reading' AND question_number = 42;
UPDATE questions SET question_text = 'The word "susceptible" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 43;
UPDATE questions SET question_text = 'What are "superbugs"?' WHERE section = 'reading' AND question_number = 44;
UPDATE questions SET question_text = 'Which alternative treatment to antibiotics is mentioned in the passage?' WHERE section = 'reading' AND question_number = 45;

-- Passage 10: Sleep (Q46-50)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Sleep is a vital biological process that affects virtually every aspect of physical and mental health. Despite spending approximately one-third of our lives sleeping, scientists are still uncovering the full range of sleep''s functions. Research has established that sleep is essential for memory consolidation, immune function, emotional regulation, and cellular repair. During sleep, the brain processes and stores information from the day, while the body performs crucial maintenance and repair work.

Sleep occurs in cycles, each lasting about 90 minutes and consisting of different stages. Non-REM sleep includes three stages of progressively deeper sleep, during which heart rate and breathing slow, muscles relax, and the body performs physical restoration. REM (Rapid Eye Movement) sleep, the stage when most dreaming occurs, is characterized by increased brain activity, rapid eye movements, and temporary muscle paralysis. Adults typically cycle through four to six sleep cycles per night, with REM periods lengthening toward morning.

Chronic sleep deprivation has serious consequences for health and well-being. Short-term effects include impaired cognitive function, decreased alertness, and mood disturbances. Long-term sleep deficiency is associated with increased risk of obesity, diabetes, cardiovascular disease, and mental health disorders. Modern lifestyle factors including artificial lighting, electronic devices, irregular schedules, and stress contribute to widespread sleep problems. Sleep experts recommend maintaining consistent sleep schedules, creating dark and quiet sleep environments, limiting screen time before bed, and avoiding caffeine and alcohol close to bedtime to improve sleep quality.',
  question_text = 'What happens during sleep according to the passage?'
WHERE section = 'reading' AND question_number = 46;

UPDATE questions SET question_text = 'How long does each sleep cycle typically last?' WHERE section = 'reading' AND question_number = 47;
UPDATE questions SET question_text = 'The word "impaired" in paragraph 3 is closest in meaning to' WHERE section = 'reading' AND question_number = 48;
UPDATE questions SET question_text = 'What characterizes REM sleep?' WHERE section = 'reading' AND question_number = 49;
UPDATE questions SET question_text = 'Which of the following is NOT mentioned as a recommendation for better sleep?' WHERE section = 'reading' AND question_number = 50;

-- Passage 11: Artificial Intelligence (Q51-55)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Artificial Intelligence (AI) refers to computer systems capable of performing tasks that typically require human intelligence, such as visual perception, speech recognition, decision-making, and language translation. The field of AI has experienced remarkable progress in recent years, driven by advances in machine learning, increased computing power, and the availability of vast amounts of data. Today, AI applications range from virtual assistants like Siri and Alexa to autonomous vehicles, medical diagnosis systems, and sophisticated game-playing programs.

Machine learning, a subset of AI, enables computers to learn from data without being explicitly programmed. Deep learning, a type of machine learning based on artificial neural networks, has proven particularly effective for tasks involving pattern recognition in complex data. These systems can identify objects in images, transcribe speech, translate languages, and even generate realistic text and images. The success of deep learning in competitions and real-world applications has sparked tremendous interest and investment in AI research and development.

Despite its impressive capabilities, AI also raises important concerns. Questions about job displacement as automation increases worry many workers and policymakers. Bias in AI systems, often reflecting biases in training data, can perpetuate discrimination. Privacy concerns arise from AI''s ability to collect and analyze personal data. The potential for AI to be used in autonomous weapons systems raises ethical and security issues. Addressing these challenges requires thoughtful regulation, ethical guidelines, and ongoing dialogue between technologists, policymakers, and society.',
  question_text = 'What is the main topic of the passage?'
WHERE section = 'reading' AND question_number = 51;

UPDATE questions SET question_text = 'According to the passage, what has driven recent progress in AI?' WHERE section = 'reading' AND question_number = 52;
UPDATE questions SET question_text = 'The word "perpetuate" in paragraph 3 is closest in meaning to' WHERE section = 'reading' AND question_number = 53;
UPDATE questions SET question_text = 'What is deep learning based on?' WHERE section = 'reading' AND question_number = 54;
UPDATE questions SET question_text = 'Which concern about AI is NOT mentioned in the passage?' WHERE section = 'reading' AND question_number = 55;

-- Passage 12: Volcanic Activity (Q56-60)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Volcanoes form when molten rock, gases, and debris escape to Earth''s surface, causing eruptions of lava and ash. Most volcanoes are located along tectonic plate boundaries, where plates either collide or separate. The "Ring of Fire," encircling the Pacific Ocean, contains about 75% of the world''s active volcanoes. Volcanic eruptions can be explosive or effusive, depending on magma composition and gas content. Explosive eruptions occur when thick, gas-rich magma builds up pressure, while effusive eruptions involve relatively fluid lava flowing from the volcano.

Volcanic eruptions, while dangerous, also provide benefits to the environment and human societies. Volcanic ash enriches soil with minerals, making volcanic regions highly fertile for agriculture. Many civilizations have thrived in volcanic areas, including parts of Italy, Indonesia, and Central America. Volcanic activity also creates geothermal energy resources that can be harnessed for electricity and heating. Additionally, volcanic islands provide unique habitats for diverse species and serve as natural laboratories for studying evolution and ecology.

Scientists monitor volcanoes using various techniques to predict eruptions and protect communities. Seismometers detect earthquakes that often precede eruptions. Gas sensors measure changes in volcanic gas emissions. Satellite imagery tracks ground deformation and heat signatures. Despite these tools, predicting volcanic eruptions with precision remains challenging. The time between warning signs and eruption can range from hours to months, making evacuation decisions difficult. However, improved monitoring and early warning systems have saved countless lives in volcanic regions.',
  question_text = 'Where are most volcanoes located?'
WHERE section = 'reading' AND question_number = 56;

UPDATE questions SET question_text = 'What causes explosive volcanic eruptions?' WHERE section = 'reading' AND question_number = 57;
UPDATE questions SET question_text = 'The word "harnessed" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 58;
UPDATE questions SET question_text = 'What benefit of volcanoes is mentioned in the passage?' WHERE section = 'reading' AND question_number = 59;
UPDATE questions SET question_text = 'Why is predicting volcanic eruptions difficult?' WHERE section = 'reading' AND question_number = 60;

-- Passage 13: Renewable Energy (Q61-65)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Renewable energy sources, including solar, wind, hydroelectric, and geothermal power, offer sustainable alternatives to fossil fuels. Unlike coal, oil, and natural gas, which take millions of years to form and release greenhouse gases when burned, renewable sources are naturally replenished and produce little or no emissions. The transition to renewable energy is considered essential for addressing climate change and ensuring energy security for future generations.

Solar and wind power have experienced dramatic cost reductions and efficiency improvements in recent years. Solar photovoltaic panels now convert sunlight to electricity at costs competitive with fossil fuels in many regions. Wind turbines, particularly offshore installations, generate significant amounts of electricity with minimal environmental impact. However, both solar and wind energy are intermittent, producing power only when the sun shines or wind blows. This variability necessitates energy storage solutions and grid management systems to ensure reliable power supply.

Hydroelectric power, while renewable, raises environmental concerns related to dam construction, which can disrupt river ecosystems and displace communities. Geothermal energy, which taps heat from Earth''s interior, provides reliable baseload power but is limited to geologically suitable locations. Biomass energy uses organic materials like wood and agricultural waste, but must be managed sustainably to avoid environmental harm. The future energy system will likely involve a mix of renewable sources, complemented by energy storage technologies and smart grids that balance supply and demand efficiently.',
  question_text = 'What is the main advantage of renewable energy over fossil fuels?'
WHERE section = 'reading' AND question_number = 61;

UPDATE questions SET question_text = 'Why are solar and wind energy considered intermittent?' WHERE section = 'reading' AND question_number = 62;
UPDATE questions SET question_text = 'The word "dramatically" in paragraph 2 is closest in meaning to' WHERE section = 'reading' AND question_number = 63;
UPDATE questions SET question_text = 'What concern is mentioned about hydroelectric power?' WHERE section = 'reading' AND question_number = 64;
UPDATE questions SET question_text = 'According to the passage, what will the future energy system likely include?' WHERE section = 'reading' AND question_number = 65;

-- Passage 14: Ancient Egyptian Civilization (Q66-70)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Ancient Egyptian civilization, one of the world''s oldest and most enduring cultures, flourished along the Nile River for over 3,000 years. The Nile''s annual flooding deposited rich silt on the riverbanks, creating fertile land that supported agriculture and enabled population growth. This agricultural abundance allowed Egyptian society to develop complex social structures, monumental architecture, and sophisticated arts and sciences.

The pyramids of Giza stand as perhaps the most iconic symbols of ancient Egypt. Built as tombs for pharaohs, these massive structures demonstrate remarkable engineering skill and organizational capacity. The Great Pyramid of Khufu, constructed around 2560 BCE, remained the world''s tallest man-made structure for nearly 4,000 years. The precision with which the pyramids were built, along with the logistics of quarrying, transporting, and placing millions of stone blocks, continues to fascinate researchers.

Egyptian religion profoundly influenced all aspects of life and culture. Egyptians believed in many gods and goddesses, with the pharaoh serving as a divine intermediary between gods and humans. The concept of the afterlife was central to Egyptian belief, leading to elaborate burial practices including mummification to preserve bodies for the next world. Hieroglyphics, the Egyptian writing system using pictorial symbols, recorded religious texts, administrative documents, and literary works. The decipherment of hieroglyphics in the 19th century opened a window into understanding this ancient civilization.',
  question_text = 'What made the Nile River valley suitable for agriculture?'
WHERE section = 'reading' AND question_number = 66;

UPDATE questions SET question_text = 'When was the Great Pyramid of Khufu built?' WHERE section = 'reading' AND question_number = 67;
UPDATE questions SET question_text = 'The word "enduring" in paragraph 1 is closest in meaning to' WHERE section = 'reading' AND question_number = 68;
UPDATE questions SET question_text = 'What role did the pharaoh play in Egyptian religion?' WHERE section = 'reading' AND question_number = 69;
UPDATE questions SET question_text = 'Why did Egyptians practice mummification?' WHERE section = 'reading' AND question_number = 70;

-- Passage 15: Biodiversity (Q71-75)
-- ============================================================
UPDATE questions SET 
  passage_text = 'Biodiversity refers to the variety of life on Earth at all levels, from genes to ecosystems. It encompasses the diversity of species, the genetic variation within species, and the variety of ecosystems that species form. High biodiversity is essential for ecosystem health and resilience, as diverse systems are better able to withstand environmental changes and disturbances. Biodiversity also provides numerous benefits to humans, including food, medicine, clean water, and climate regulation.

Tropical rainforests contain the greatest biodiversity of any terrestrial ecosystem, housing an estimated 50% of all species despite covering only about 6% of Earth''s land surface. Coral reefs, often called the "rainforests of the sea," support similarly high biodiversity in marine environments. These biodiversity hotspots face severe threats from deforestation, climate change, pollution, and overexploitation. Scientists estimate that species are currently going extinct at rates 100 to 1,000 times higher than natural background rates, a phenomenon sometimes called the "sixth mass extinction."

Conservation efforts aim to protect biodiversity through various strategies. Protected areas like national parks and nature reserves preserve critical habitats. International agreements such as the Convention on Biological Diversity promote cooperation on conservation issues. Sustainable resource management practices seek to balance human needs with ecosystem health. Ex situ conservation efforts, including seed banks and captive breeding programs, provide insurance against extinction. However, effective biodiversity conservation requires addressing underlying drivers of biodiversity loss, including unsustainable consumption patterns, population growth, and economic systems that fail to account for environmental costs.',
  question_text = 'What does biodiversity encompass according to the passage?'
WHERE section = 'reading' AND question_number = 71;

UPDATE questions SET question_text = 'What percentage of Earth''s land surface do tropical rainforests cover?' WHERE section = 'reading' AND question_number = 72;
UPDATE questions SET question_text = 'The word "resilience" in paragraph 1 is closest in meaning to' WHERE section = 'reading' AND question_number = 73;
UPDATE questions SET question_text = 'What is meant by the "sixth mass extinction"?' WHERE section = 'reading' AND question_number = 74;
UPDATE questions SET question_text = 'Which conservation strategy is NOT mentioned in the passage?' WHERE section = 'reading' AND question_number = 75;

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check total questions per section
-- SELECT section, COUNT(*) as total 
-- FROM questions 
-- GROUP BY section 
-- ORDER BY section;

-- Expected result:
-- listening: 180
-- structure: 75
-- reading: 75
-- TOTAL: 330

-- Verify Structure section format
-- SELECT question_number, LEFT(question_text, 80) as preview
-- FROM questions 
-- WHERE section = 'structure' 
-- AND question_number IN (1, 25, 26, 75)
-- ORDER BY question_number;

-- Verify Reading passages
-- SELECT question_number, 
--        CASE WHEN passage_text IS NOT NULL THEN 'HAS PASSAGE' ELSE 'NO PASSAGE' END as status,
--        LEFT(question_text, 60) as question_preview
-- FROM questions 
-- WHERE section = 'reading' 
-- ORDER BY question_number;
