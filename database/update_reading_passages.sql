-- Update Reading Questions with Passage Text
-- Run this after adding passage_text column

-- Passage 1: Coral Reefs (Questions 1-10)
UPDATE questions SET passage_text = 
'Coral reefs are among the most diverse and beautiful ecosystems on Earth. These intricate underwater structures are formed by colonies of tiny animals called coral polyps. The polyps secrete calcium carbonate, which builds up over time to create the reef structure. Coral reefs are found in shallow, warm waters and require sunlight to thrive because they have a symbiotic relationship with algae called zooxanthellae that live within their tissues.

The relationship between corals and algae is mutually beneficial. The algae provide the coral with nutrients through photosynthesis, while the coral provides the algae with protection and access to sunlight. This partnership gives corals their vibrant colors and helps them grow more quickly than they could on their own.

Coral reefs support an incredible diversity of marine life. They provide habitat, food, and breeding grounds for approximately 25% of all marine species, despite covering less than 1% of the ocean floor. Fish, sea turtles, sharks, and countless invertebrates depend on coral reefs for survival.

However, coral reefs face numerous threats. Ocean acidification, rising water temperatures, pollution, and destructive fishing practices all contribute to reef deterioration. When stressed, corals expel their symbiotic algae in a process called coral bleaching, which can lead to coral death if conditions do not improve.

Conservation efforts are crucial to protect these valuable ecosystems. Marine protected areas, sustainable fishing practices, and efforts to reduce carbon emissions can all help preserve coral reefs for future generations.'
WHERE section = 'reading' AND question_number BETWEEN 1 AND 10;

-- Passage 2: Industrial Revolution (Questions 11-20)
UPDATE questions SET passage_text = 
'The Industrial Revolution, which began in Britain in the late 18th century, brought revolutionary changes to society, economy, and technology. This period marked a shift from agrarian, handcraft-based economies to ones dominated by industry and machine manufacturing. The innovations of this era fundamentally transformed how people lived and worked.

The development of the factory system was a key feature of industrialization. New machinery, powered first by water and then by steam engines, could produce goods much faster and cheaper than traditional hand production. This led to the growth of factories in urban areas, which attracted workers from rural communities. The resulting urbanization changed the demographic landscape, as cities grew rapidly to accommodate factory workers and their families.

The revolution also brought about significant improvements in transportation. The construction of canals and, later, railways made it possible to move raw materials and finished goods over long distances efficiently. Railroads particularly revolutionized transportation, connecting distant regions and facilitating trade and economic growth.

However, the Industrial Revolution also had negative consequences. Working conditions in early factories were often harsh, with long hours, low wages, and dangerous environments. Child labor was common, and there were few safety regulations. These poor conditions eventually gave rise to labor movements and unions that fought for workers'' rights.

The Industrial Revolution''s impact extended far beyond Britain, eventually spreading to Europe, North America, and other parts of the world. It laid the foundation for modern industrial society and continues to influence our world today.'
WHERE section = 'reading' AND question_number BETWEEN 11 AND 20;

-- Passage 3: Climate Change (Questions 21-30)
UPDATE questions SET passage_text = 
'Global warming, the gradual increase in Earth''s average surface temperature, has emerged as one of the most pressing environmental challenges of our time. The primary cause of this warming trend is the increased concentration of greenhouse gases in the atmosphere, particularly carbon dioxide, which trap heat that would otherwise escape into space.

Human activities are the main contributors to rising greenhouse gas levels. The burning of fossil fuels for energy, transportation, and industrial processes releases large amounts of carbon dioxide. Deforestation reduces the number of trees available to absorb CO2 from the atmosphere, while agricultural practices contribute methane and nitrous oxide emissions.

The effects of global warming are already visible across the planet. Glaciers and polar ice caps are melting at unprecedented rates, contributing to rising sea levels that threaten coastal communities. Weather patterns are becoming more extreme, with increased frequency of heat waves, droughts, floods, and intense storms. These changes affect agriculture, water resources, and ecosystems worldwide.

Scientists use various methods to study climate change, including ice core samples, tree rings, and modern temperature records. Climate models help predict future scenarios based on different levels of greenhouse gas emissions. These models consistently show that without significant action to reduce emissions, global temperatures will continue to rise.

Addressing climate change requires coordinated global effort. Transitioning to renewable energy sources, improving energy efficiency, protecting and restoring forests, and developing sustainable agricultural practices are all necessary steps. International agreements like the Paris Climate Accord aim to unite countries in the fight against climate change.'
WHERE section = 'reading' AND question_number BETWEEN 21 AND 30;

-- Passage 4: Memory and Learning (Questions 31-40)
UPDATE questions SET passage_text = 
'Human memory is a complex cognitive process that allows us to encode, store, and retrieve information. Psychologists generally divide memory into three types: sensory memory, short-term memory, and long-term memory. Each type plays a distinct role in how we process and retain information.

Sensory memory is the briefest form of memory, lasting only a fraction of a second. It holds information from our senses just long enough for us to process it. Short-term memory, also called working memory, can hold a limited amount of information for about 20-30 seconds. This is where we temporarily store information we''re currently using, such as a phone number we just heard.

Long-term memory has a much larger capacity and can store information for extended periods, from hours to a lifetime. Information moves from short-term to long-term memory through a process called consolidation, which involves repetition and meaningful association. Long-term memory is further divided into explicit memory (conscious memories like facts and events) and implicit memory (unconscious memories like skills and habits).

The process of learning involves forming new memories and connections in the brain. Repetition is one of the most effective learning strategies because it strengthens neural pathways. However, research shows that spacing out study sessions, known as distributed practice, is more effective than cramming. The spacing effect allows time for consolidation and makes memories more resistant to forgetting.

Another powerful learning technique is elaborative rehearsal, which involves relating new information to existing knowledge. Creating mental associations, using mnemonic devices, and teaching concepts to others are all forms of elaborative rehearsal that enhance memory retention. Understanding how memory works can help students develop more effective study strategies.'
WHERE section = 'reading' AND question_number BETWEEN 31 AND 40;

-- Passage 5: Renaissance Art (Questions 41-50)
UPDATE questions SET passage_text = 
'The Renaissance, which flourished in Europe from the 14th to the 17th century, marked a profound transformation in art, culture, and intellectual thought. This period, whose name means "rebirth," saw a renewed interest in classical Greek and Roman culture, along with revolutionary changes in artistic techniques and philosophy.

Renaissance artists developed new techniques that dramatically changed the appearance of art. The use of linear perspective, developed by Filippo Brunelleschi, allowed artists to create the illusion of three-dimensional space on a two-dimensional surface. This technique revolutionized painting and architecture. Artists also mastered the use of light and shadow, called chiaroscuro, to create more realistic and dramatic effects.

Leonardo da Vinci exemplified the Renaissance ideal of the "universal man" – someone accomplished in multiple fields. His paintings, such as the Mona Lisa and The Last Supper, demonstrate his mastery of technique and his deep understanding of human anatomy and expression. Da Vinci was also an inventor, scientist, and engineer, embodying the Renaissance spirit of inquiry and innovation.

Michelangelo Buonarroti was another towering figure of the Renaissance. His sculptures, including the famous David, showed unprecedented attention to human anatomy and emotional expression. His paintings on the ceiling of the Sistine Chapel remain among the most celebrated works of art in history. These masterpieces demonstrate the Renaissance emphasis on humanism – the celebration of human potential and achievement.

The Renaissance began in Italy but gradually spread throughout Europe, influencing art, literature, science, and philosophy. The period''s emphasis on observation, experimentation, and individual creativity laid the groundwork for the modern world. Its artistic innovations and humanistic values continue to inspire artists and thinkers today.'
WHERE section = 'reading' AND question_number BETWEEN 41 AND 50;
