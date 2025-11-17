-- Full Reading Section Restructure
-- Create 10 passages with 4-5 questions each (Total: 50 questions)

-- ============================================
-- PASSAGE 1: Coral Reefs (Questions 1-5)
-- ============================================

UPDATE questions SET passage_text = 
'Coral reefs are among the most diverse and productive ecosystems on Earth, rivaling tropical rainforests in their biological complexity. These underwater structures are built by colonies of tiny animals called coral polyps, which secrete calcium carbonate to form hard skeletons. Over thousands of years, these skeletons accumulate to create the massive reef structures we see today.

The relationship between corals and zooxanthellae algae is crucial to reef survival. These microscopic algae live within coral tissues and provide up to 90% of the coral''s energy through photosynthesis. In return, the coral provides the algae with protection and access to sunlight. This symbiotic relationship is so vital that when stressed by environmental changes, corals expel their algae in a process called bleaching, often leading to coral death.

Coral reefs support approximately 25% of all marine species, despite covering less than 1% of the ocean floor. They provide essential services including coastal protection, fish habitat, and tourism revenue. However, reefs face unprecedented threats from climate change, ocean acidification, pollution, and destructive fishing practices. Scientists estimate that without significant intervention, most coral reefs could disappear within the next century.'
WHERE section = 'reading' AND question_number = 1;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 1)
WHERE section = 'reading' AND question_number IN (2, 3, 4, 5);

UPDATE questions SET question_text = 'What is the main topic of the passage?'
WHERE section = 'reading' AND question_number = 1;

UPDATE questions SET question_text = 'The word "intricate" in paragraph 1 is closest in meaning to'
WHERE section = 'reading' AND question_number = 2;

UPDATE questions SET question_text = 'According to the passage, zooxanthellae algae provide corals with'
WHERE section = 'reading' AND question_number = 3;

UPDATE questions SET question_text = 'What can be inferred about coral bleaching?'
WHERE section = 'reading' AND question_number = 4;

UPDATE questions SET question_text = 'According to the passage, which of the following threatens coral reefs?'
WHERE section = 'reading' AND question_number = 5;

-- ============================================
-- PASSAGE 2: Ancient Rome (Questions 6-10)
-- ============================================

UPDATE questions SET passage_text =
'Ancient Rome was one of the most influential civilizations in history, lasting for over a thousand years from its legendary founding in 753 BCE until the fall of the Western Roman Empire in 476 CE. Rome began as a small city-state in central Italy but eventually grew to control a vast empire stretching from Britain to North Africa and from Spain to the Middle East.

The Roman Republic, established around 509 BCE, introduced political innovations that influenced later democratic systems. The Republic was governed by elected officials, including consuls and senators, though power was largely held by wealthy patrician families. Over time, conflicts between patricians and plebeians (common citizens) led to reforms that gave plebeians more political rights, though true democracy remained elusive.

Roman engineering and architecture were remarkably advanced. The Romans built an extensive network of roads that facilitated trade, military movement, and communication across their empire. They also constructed impressive aqueducts, public baths, and monumental buildings. Many Roman engineering principles and architectural styles continue to influence modern construction. The Latin language, Roman law, and administrative practices have left an enduring legacy that shapes Western civilization to this day.'
WHERE section = 'reading' AND question_number = 6;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 6)
WHERE section = 'reading' AND question_number IN (7, 8, 9, 10);

UPDATE questions SET question_text = 'What is the main idea of the passage?'
WHERE section = 'reading' AND question_number = 6;

UPDATE questions SET question_text = 'According to the passage, the Roman Republic was established around'
WHERE section = 'reading' AND question_number = 7;

UPDATE questions SET question_text = 'The word "elusive" in paragraph 2 is closest in meaning to'
WHERE section = 'reading' AND question_number = 8;

UPDATE questions SET question_text = 'Why does the author mention Roman roads?'
WHERE section = 'reading' AND question_number = 9;

UPDATE questions SET question_text = 'Which of the following best describes the author''s attitude toward Roman civilization?'
WHERE section = 'reading' AND question_number = 10;

-- ============================================
-- PASSAGE 3: Climate Change (Questions 11-15)
-- ============================================

UPDATE questions SET passage_text =
'Global climate change, driven primarily by human activities, has become one of the most pressing challenges facing humanity. The burning of fossil fuels for energy releases carbon dioxide and other greenhouse gases into the atmosphere, where they trap heat that would otherwise escape into space. Since the Industrial Revolution, atmospheric CO2 levels have increased by over 40%, leading to a global temperature rise of approximately 1.1°C.

The effects of climate change are already visible worldwide. Glaciers and polar ice caps are melting at accelerating rates, contributing to sea level rise that threatens coastal communities. Weather patterns are becoming more extreme, with increased frequency of heat waves, droughts, floods, and intense storms. These changes affect agriculture, water resources, and natural ecosystems, potentially displacing millions of people and causing trillions of dollars in economic damage.

Scientists use multiple lines of evidence to study climate change, including ice core samples that reveal atmospheric conditions from hundreds of thousands of years ago, tree ring data, and modern temperature measurements. Climate models project future scenarios based on different emission pathways. While the challenges are significant, solutions exist: transitioning to renewable energy, improving energy efficiency, protecting forests, and developing sustainable agricultural practices can all help mitigate climate change impacts.'
WHERE section = 'reading' AND question_number = 11;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 11)
WHERE section = 'reading' AND question_number IN (12, 13, 14, 15);

UPDATE questions SET question_text = 'What is the passage mainly about?'
WHERE section = 'reading' AND question_number = 11;

UPDATE questions SET question_text = 'According to the passage, atmospheric CO2 levels have increased by'
WHERE section = 'reading' AND question_number = 12;

UPDATE questions SET question_text = 'The word "mitigate" in paragraph 3 is closest in meaning to'
WHERE section = 'reading' AND question_number = 13;

UPDATE questions SET question_text = 'Which of the following is NOT mentioned as an effect of climate change?'
WHERE section = 'reading' AND question_number = 14;

UPDATE questions SET question_text = 'What does the author suggest about climate change solutions?'
WHERE section = 'reading' AND question_number = 15;

-- ============================================
-- PASSAGE 4: Memory and Learning (Questions 16-20)
-- ============================================

UPDATE questions SET passage_text =
'Human memory is a complex cognitive process that involves encoding, storing, and retrieving information. Psychologists categorize memory into three main types: sensory memory, short-term memory, and long-term memory. Sensory memory holds information from our senses for just a fraction of a second, allowing our brain to process stimuli. Short-term memory, also called working memory, can hold limited information for about 20-30 seconds and has a capacity of roughly 7 items.

Long-term memory has virtually unlimited capacity and can store information for extended periods, from hours to a lifetime. It is divided into explicit memory (conscious memories of facts and events) and implicit memory (unconscious memories like skills and habits). The process of transferring information from short-term to long-term memory is called consolidation, which is strengthened through repetition and meaningful association.

Research has revealed several effective learning strategies. The spacing effect shows that distributing study sessions over time is more effective than cramming. Elaborative rehearsal, which involves connecting new information to existing knowledge, enhances retention. The testing effect demonstrates that retrieving information through practice tests strengthens memory more than passive review. Understanding these principles allows students to develop more efficient study habits and improve their learning outcomes.'
WHERE section = 'reading' AND question_number = 16;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 16)
WHERE section = 'reading' AND question_number IN (17, 18, 19, 20);

UPDATE questions SET question_text = 'What is the main purpose of the passage?'
WHERE section = 'reading' AND question_number = 16;

UPDATE questions SET question_text = 'According to the passage, short-term memory can hold information for'
WHERE section = 'reading' AND question_number = 17;

UPDATE questions SET question_text = 'The word "consolidation" in paragraph 2 refers to'
WHERE section = 'reading' AND question_number = 18;

UPDATE questions SET question_text = 'The author mentions repetition to'
WHERE section = 'reading' AND question_number = 19;

UPDATE questions SET question_text = 'According to the passage, which learning strategy is most effective?'
WHERE section = 'reading' AND question_number = 20;

-- ============================================
-- PASSAGE 5: Renaissance Art (Questions 21-25)
-- ============================================

UPDATE questions SET passage_text =
'The Renaissance, meaning "rebirth," was a cultural movement that flourished in Europe from the 14th to the 17th century, marking a transition from medieval to modern times. This period saw a renewed interest in classical Greek and Roman culture, along with revolutionary developments in art, science, and philosophy. Renaissance artists rejected the flat, symbolic style of medieval art in favor of realistic, three-dimensional representations based on careful observation of nature.

Key artistic innovations included the development of linear perspective by Filippo Brunelleschi, which allowed artists to create the illusion of depth on flat surfaces. Artists also mastered chiaroscuro, the use of light and shadow to create volume and drama. Leonardo da Vinci exemplified the Renaissance ideal of the "universal man," combining artistic genius with scientific inquiry. His paintings, such as the Mona Lisa and The Last Supper, demonstrate exceptional technical skill and psychological insight.

Michelangelo Buonarroti was another towering figure, whose sculptures like David showed unprecedented anatomical accuracy and emotional expression. His paintings on the Sistine Chapel ceiling remain among art history''s greatest achievements. These masterpieces reflect the Renaissance emphasis on humanism—the celebration of human potential and achievement. The period''s innovations in technique and philosophy laid the groundwork for modern Western art and continue to inspire artists today.'
WHERE section = 'reading' AND question_number = 21;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 21)
WHERE section = 'reading' AND question_number IN (22, 23, 24, 25);

UPDATE questions SET question_text = 'What is the passage primarily concerned with?'
WHERE section = 'reading' AND question_number = 21;

UPDATE questions SET question_text = 'According to the passage, Renaissance artists differed from medieval artists in that they'
WHERE section = 'reading' AND question_number = 22;

UPDATE questions SET question_text = 'The word "unprecedented" in paragraph 3 is closest in meaning to'
WHERE section = 'reading' AND question_number = 23;

UPDATE questions SET question_text = 'Why does the author mention Leonardo da Vinci?'
WHERE section = 'reading' AND question_number = 24;

UPDATE questions SET question_text = 'What does the passage suggest about humanism?'
WHERE section = 'reading' AND question_number = 25;

-- ============================================
-- PASSAGE 6: Ocean Currents (Questions 26-29)
-- ============================================

UPDATE questions SET passage_text =
'Ocean currents are continuous, directed movements of seawater generated by forces acting upon this mean flow, such as wind, temperature differences, and the Earth''s rotation. These currents play a crucial role in regulating global climate by redistributing heat around the planet. Warm water from tropical regions flows toward the poles, while cold water from polar regions moves toward the equator, creating a global conveyor belt of ocean circulation.

The Gulf Stream is perhaps the most well-known ocean current, transporting warm water from the Gulf of Mexico across the Atlantic Ocean to Europe. This current significantly moderates temperatures in Western Europe, making countries like Britain and Norway much warmer than other regions at similar latitudes. Scientists estimate that without the Gulf Stream, average temperatures in these areas could drop by 5-10°C.

Ocean currents also affect marine ecosystems and human activities. Upwelling currents bring nutrient-rich deep water to the surface, supporting productive fishing grounds. Navigation routes often utilize currents to reduce fuel consumption and travel time. However, climate change is beginning to affect ocean circulation patterns, with potentially serious consequences for weather systems, marine life, and coastal communities worldwide.'
WHERE section = 'reading' AND question_number = 26;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 26)
WHERE section = 'reading' AND question_number IN (27, 28, 29);

UPDATE questions SET question_text = 'What is the main topic of the passage?'
WHERE section = 'reading' AND question_number = 26;

UPDATE questions SET question_text = 'According to the passage, what creates ocean currents?'
WHERE section = 'reading' AND question_number = 27;

UPDATE questions SET question_text = 'The author mentions the Gulf Stream to illustrate'
WHERE section = 'reading' AND question_number = 28;

UPDATE questions SET question_text = 'What can be inferred about upwelling currents?'
WHERE section = 'reading' AND question_number = 29;

-- ============================================
-- PASSAGE 7: Photosynthesis (Questions 30-34)
-- ============================================

UPDATE questions SET passage_text =
'Photosynthesis is the fundamental biological process by which plants, algae, and some bacteria convert light energy into chemical energy stored in glucose molecules. This process takes place primarily in the chloroplasts of plant cells, where the green pigment chlorophyll captures light energy. Photosynthesis can be summarized by the equation: 6CO2 + 6H2O + light energy → C6H12O6 + 6O2, meaning carbon dioxide and water are converted into glucose and oxygen using light energy.

The process occurs in two main stages: the light-dependent reactions and the light-independent reactions (Calvin cycle). In the light-dependent reactions, which occur in the thylakoid membranes, light energy splits water molecules and generates ATP and NADPH. These energy-rich molecules then power the Calvin cycle in the stroma, where carbon dioxide is fixed into organic molecules that eventually form glucose.

Photosynthesis is essential for life on Earth. It produces the oxygen that most organisms need for respiration and forms the base of most food chains. Plants convert approximately 1% of available solar energy into chemical energy, which sustains nearly all ecosystems. Understanding photosynthesis has practical applications in agriculture, where optimizing this process can increase crop yields, and in developing renewable energy technologies that mimic natural photosynthesis to produce clean fuels.'
WHERE section = 'reading' AND question_number = 30;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 30)
WHERE section = 'reading' AND question_number IN (31, 32, 33, 34);

UPDATE questions SET question_text = 'What is the passage mainly about?'
WHERE section = 'reading' AND question_number = 30;

UPDATE questions SET question_text = 'According to the passage, where does photosynthesis primarily occur?'
WHERE section = 'reading' AND question_number = 31;

UPDATE questions SET question_text = 'The word "sustains" in paragraph 3 is closest in meaning to'
WHERE section = 'reading' AND question_number = 32;

UPDATE questions SET question_text = 'According to the passage, the Calvin cycle'
WHERE section = 'reading' AND question_number = 33;

UPDATE questions SET question_text = 'What does the author suggest about photosynthesis research?'
WHERE section = 'reading' AND question_number = 34;

-- ============================================
-- PASSAGE 8: Urban Planning (Questions 35-39)
-- ============================================

UPDATE questions SET passage_text =
'Urban planning is the process of designing and regulating the use of space in cities and towns to create sustainable, functional, and livable communities. Modern urban planning emerged in the 19th century as rapid industrialization led to overcrowded, unsanitary cities. Planners sought to address these problems by organizing urban space more efficiently and incorporating parks, wider streets, and proper sanitation systems.

Contemporary urban planning faces new challenges including population growth, environmental sustainability, and social equity. The concept of "smart growth" emphasizes compact, walkable neighborhoods with mixed-use development, reducing dependence on automobiles and promoting public transit. Green infrastructure, such as parks, green roofs, and urban forests, helps manage stormwater, reduce heat island effects, and improve air quality while providing recreational spaces.

Successful urban planning requires balancing multiple stakeholder interests and considering long-term consequences. Planners must address housing affordability, economic development, environmental protection, and cultural preservation simultaneously. Innovative approaches like participatory planning involve community members in decision-making processes, ensuring that development reflects local needs and values. As cities continue to grow—with projections suggesting 68% of the global population will live in urban areas by 2050—effective planning becomes increasingly critical for quality of life and environmental sustainability.'
WHERE section = 'reading' AND question_number = 35;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 35)
WHERE section = 'reading' AND question_number IN (36, 37, 38, 39);

UPDATE questions SET question_text = 'What is the main purpose of the passage?'
WHERE section = 'reading' AND question_number = 35;

UPDATE questions SET question_text = 'According to the passage, modern urban planning began in response to'
WHERE section = 'reading' AND question_number = 36;

UPDATE questions SET question_text = 'The word "compact" in paragraph 2 is closest in meaning to'
WHERE section = 'reading' AND question_number = 37;

UPDATE questions SET question_text = 'What does the author mean by "smart growth"?'
WHERE section = 'reading' AND question_number = 38;

UPDATE questions SET question_text = 'According to the passage, participatory planning'
WHERE section = 'reading' AND question_number = 39;

-- ============================================
-- PASSAGE 9: Antibiotics (Questions 40-44)
-- ============================================

UPDATE questions SET passage_text =
'Antibiotics are powerful medicines that fight bacterial infections by either killing bacteria or preventing their reproduction. The discovery of penicillin by Alexander Fleming in 1928 revolutionized medicine, transforming previously fatal infections into treatable conditions. Since then, numerous antibiotics have been developed, each targeting different types of bacteria through various mechanisms. Some antibiotics disrupt bacterial cell walls, others interfere with protein synthesis, and some inhibit DNA replication.

However, the widespread use and misuse of antibiotics has led to a growing crisis: antibiotic resistance. When bacteria are exposed to antibiotics repeatedly, those with genetic mutations that confer resistance survive and multiply, creating resistant populations. This natural selection process has accelerated due to overprescription of antibiotics, patients not completing treatment courses, and extensive use in agriculture. Methicillin-resistant Staphylococcus aureus (MRSA) and other "superbugs" now resist multiple antibiotics, making some infections extremely difficult to treat.

Addressing antibiotic resistance requires coordinated action. Healthcare providers must prescribe antibiotics only when necessary and patients must complete full treatment courses. Agricultural practices need reform to reduce routine antibiotic use in livestock. Research into new antibiotics and alternative treatments is crucial, though developing new drugs is expensive and time-consuming. Public health organizations warn that without action, we risk entering a "post-antibiotic era" where common infections could once again become deadly.'
WHERE section = 'reading' AND question_number = 40;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 40)
WHERE section = 'reading' AND question_number IN (41, 42, 43, 44);

UPDATE questions SET question_text = 'What is the passage primarily about?'
WHERE section = 'reading' AND question_number = 40;

UPDATE questions SET question_text = 'According to the passage, antibiotics work by'
WHERE section = 'reading' AND question_number = 41;

UPDATE questions SET question_text = 'The word "confer" in paragraph 2 is closest in meaning to'
WHERE section = 'reading' AND question_number = 42;

UPDATE questions SET question_text = 'What causes antibiotic resistance according to the passage?'
WHERE section = 'reading' AND question_number = 43;

UPDATE questions SET question_text = 'What does the author imply about the future of antibiotics?'
WHERE section = 'reading' AND question_number = 44;

-- ============================================
-- PASSAGE 10: Sleep Science (Questions 45-50)
-- ============================================

UPDATE questions SET passage_text =
'Sleep is a complex biological process essential for physical health, cognitive function, and emotional well-being. Despite spending approximately one-third of our lives asleep, scientists are still uncovering the mechanisms and purposes of sleep. During sleep, the brain cycles through distinct stages: non-REM sleep (stages 1-3) and REM (rapid eye movement) sleep. Each stage serves different functions, from physical restoration during deep sleep to memory consolidation and emotional processing during REM sleep.

Research has revealed that sleep deprivation has serious consequences. Insufficient sleep impairs attention, decision-making, and reaction time, increasing accident risk. Chronic sleep loss is linked to numerous health problems including obesity, diabetes, cardiovascular disease, and weakened immune function. Studies show that even modest sleep restriction—getting 6 hours instead of 8—accumulates a "sleep debt" that cannot be easily repaid by weekend catch-up sleep.

The modern lifestyle poses significant challenges to healthy sleep patterns. Artificial light, especially blue light from electronic devices, suppresses melatonin production and delays sleep onset. Work schedules, stress, and social activities often conflict with natural circadian rhythms. Sleep experts recommend maintaining consistent sleep schedules, creating dark and cool sleeping environments, avoiding screens before bedtime, and limiting caffeine and alcohol. Understanding sleep''s importance and prioritizing adequate rest is crucial for maintaining health and optimal functioning in our demanding, 24/7 society.'
WHERE section = 'reading' AND question_number = 45;

UPDATE questions SET passage_text = (SELECT passage_text FROM questions WHERE section = 'reading' AND question_number = 45)
WHERE section = 'reading' AND question_number IN (46, 47, 48, 49, 50);

UPDATE questions SET question_text = 'What is the main idea of the passage?'
WHERE section = 'reading' AND question_number = 45;

UPDATE questions SET question_text = 'According to the passage, REM sleep is important for'
WHERE section = 'reading' AND question_number = 46;

UPDATE questions SET question_text = 'The phrase "accumulates a sleep debt" in paragraph 2 means that'
WHERE section = 'reading' AND question_number = 47;

UPDATE questions SET question_text = 'The word "suppresses" in paragraph 3 is closest in meaning to'
WHERE section = 'reading' AND question_number = 48;

UPDATE questions SET question_text = 'What does the author suggest about catching up on sleep during weekends?'
WHERE section = 'reading' AND question_number = 49;

UPDATE questions SET question_text = 'Which of the following is NOT mentioned as a sleep hygiene recommendation?'
WHERE section = 'reading' AND question_number = 50;
