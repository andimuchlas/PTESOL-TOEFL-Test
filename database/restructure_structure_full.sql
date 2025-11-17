-- Full Structure Section Restructure
-- Update Error Identification Questions (16-40) with proper underline format
-- Each underlined part corresponds to options A, B, C, D

-- Question 16
UPDATE questions SET 
  question_text = '<u>It is generally</u> <u>assumed</u> that birds <u>sleeping</u> while <u>they are flying</u>.',
  option_a = 'It is generally',
  option_b = 'assumed', 
  option_c = 'sleeping',
  option_d = 'they are flying'
WHERE section = 'structure' AND question_number = 16;

-- Question 17
UPDATE questions SET 
  question_text = 'Not <u>many</u> young people <u>come</u> to <u>live</u> in the countryside, but <u>little</u> leave.',
  option_a = 'many',
  option_b = 'come',
  option_c = 'live',
  option_d = 'little'
WHERE section = 'structure' AND question_number = 17;

-- Question 18
UPDATE questions SET 
  question_text = '<u>In 1867</u>, a telegraph cable <u>connected</u> Britain <u>to</u> America and it greatly improved <u>communication</u>.',
  option_a = 'In 1867',
  option_b = 'connected',
  option_c = 'to',
  option_d = 'communication'
WHERE section = 'structure' AND question_number = 18;

-- Question 19
UPDATE questions SET 
  question_text = '<u>Despite</u> most mushrooms <u>are</u> edible, <u>some species</u> cause <u>serious poisoning</u>.',
  option_a = 'Despite',
  option_b = 'are',
  option_c = 'some species',
  option_d = 'serious poisoning'
WHERE section = 'structure' AND question_number = 19;

-- Question 20
UPDATE questions SET 
  question_text = 'Salmon begin <u>its</u> life in fresh water, <u>migrate</u> to the ocean <u>as adolescents</u>, and return to fresh water <u>as adults</u>.',
  option_a = 'its',
  option_b = 'migrate',
  option_c = 'as adolescents',
  option_d = 'as adults'
WHERE section = 'structure' AND question_number = 20;

-- Question 21
UPDATE questions SET 
  question_text = '<u>Sound</u> <u>can travel</u> <u>through</u> a vacuum, but light <u>cannot</u>.',
  option_a = 'Sound',
  option_b = 'can travel',
  option_c = 'through',
  option_d = 'cannot'
WHERE section = 'structure' AND question_number = 21;

-- Question 22
UPDATE questions SET 
  question_text = 'Yeast is <u>an extremely</u> simple organism <u>made up</u> of <u>one-celled</u> forms of a class of fungi <u>called</u> Ascomycetes.',
  option_a = 'an extremely',
  option_b = 'made up',
  option_c = 'one-celled',
  option_d = 'called'
WHERE section = 'structure' AND question_number = 22;

-- Question 23
UPDATE questions SET 
  question_text = '<u>The ear</u> is <u>probably</u> the human body''s <u>more intricate</u> <u>organ</u>.',
  option_a = 'The ear',
  option_b = 'probably',
  option_c = 'more intricate',
  option_d = 'organ'
WHERE section = 'structure' AND question_number = 23;

-- Question 24
UPDATE questions SET 
  question_text = 'The Tennessee Valley Authority <u>has chartered</u> <u>by</u> the United States Congress in 1933 <u>to construct</u> dams <u>and</u> power plants.',
  option_a = 'has chartered',
  option_b = 'by',
  option_c = 'to construct',
  option_d = 'and'
WHERE section = 'structure' AND question_number = 24;

-- Question 25
UPDATE questions SET 
  question_text = 'The price of gold <u>depends on</u> several factors, <u>including</u> supply, demand, <u>and</u> <u>it has quality</u>.',
  option_a = 'depends on',
  option_b = 'including',
  option_c = 'and',
  option_d = 'it has quality'
WHERE section = 'structure' AND question_number = 25;

-- Question 26
UPDATE questions SET 
  question_text = 'Precipitation <u>is measured</u> <u>on</u> <u>rain gauges</u> or <u>by radar</u>.',
  option_a = 'is measured',
  option_b = 'on',
  option_c = 'rain gauges',
  option_d = 'by radar'
WHERE section = 'structure' AND question_number = 26;

-- Question 27
UPDATE questions SET 
  question_text = '<u>When</u> the ratio of carbons to hydrogens in hydrocarbon molecules <u>increased</u>, <u>the result</u> is <u>an increased</u> boiling point.',
  option_a = 'When',
  option_b = 'increased',
  option_c = 'the result',
  option_d = 'an increased'
WHERE section = 'structure' AND question_number = 27;

-- Question 28
UPDATE questions SET 
  question_text = '<u>In general</u>, the brightness of a star <u>depends on</u> how much energy <u>produce</u> and <u>how far</u> it is from Earth.',
  option_a = 'In general',
  option_b = 'depends on',
  option_c = 'produce',
  option_d = 'how far'
WHERE section = 'structure' AND question_number = 28;

-- Question 29
UPDATE questions SET 
  question_text = 'Plants <u>remove</u> carbon dioxide <u>from</u> the atmosphere and <u>return</u> oxygen <u>by</u> a process called photosynthesis.',
  option_a = 'remove',
  option_b = 'from',
  option_c = 'return',
  option_d = 'by'
WHERE section = 'structure' AND question_number = 29;

-- Question 30
UPDATE questions SET 
  question_text = 'Anthracite, <u>which</u> is found <u>mainly</u> in Pennsylvania, is the <u>hardly</u> kind <u>of</u> coal.',
  option_a = 'which',
  option_b = 'mainly',
  option_c = 'hardly',
  option_d = 'of'
WHERE section = 'structure' AND question_number = 30;

-- Question 31
UPDATE questions SET 
  question_text = '<u>In 1879</u>, Thomas Edison invented <u>his</u> incandescent light bulb, <u>and</u> this <u>revolutionize</u> the lighting of homes.',
  option_a = 'In 1879',
  option_b = 'his',
  option_c = 'and',
  option_d = 'revolutionize'
WHERE section = 'structure' AND question_number = 31;

-- Question 32
UPDATE questions SET 
  question_text = 'In a <u>parliamentary</u> system, a government''s <u>ability</u> to govern depends <u>in</u> its ability to command <u>a majority</u> in the parliament.',
  option_a = 'parliamentary',
  option_b = 'ability',
  option_c = 'in',
  option_d = 'a majority'
WHERE section = 'structure' AND question_number = 32;

-- Question 33
UPDATE questions SET 
  question_text = 'Carbohydrates <u>are composed</u> of carbon, hydrogen, <u>and</u> oxygen, with <u>the ratio</u> of hydrogen atoms to oxygen atoms <u>to be</u> two to one.',
  option_a = 'are composed',
  option_b = 'and',
  option_c = 'the ratio',
  option_d = 'to be'
WHERE section = 'structure' AND question_number = 33;

-- Question 34
UPDATE questions SET 
  question_text = 'Much research <u>has been done</u> on the <u>possible</u> relationship of vitamins <u>and</u> the prevention <u>for</u> certain diseases.',
  option_a = 'has been done',
  option_b = 'possible',
  option_c = 'and',
  option_d = 'for'
WHERE section = 'structure' AND question_number = 34;

-- Question 35
UPDATE questions SET 
  question_text = 'In <u>mammals</u>, the major artery <u>called</u> the aorta <u>carries</u> blood from the heart to all organs except <u>lung</u>.',
  option_a = 'mammals',
  option_b = 'called',
  option_c = 'carries',
  option_d = 'lung'
WHERE section = 'structure' AND question_number = 35;

-- Question 36
UPDATE questions SET 
  question_text = '<u>In</u> the eighteenth century, all workers <u>are</u> required <u>to serve</u> <u>a</u> 14-hour day.',
  option_a = 'In',
  option_b = 'are',
  option_c = 'to serve',
  option_d = 'a'
WHERE section = 'structure' AND question_number = 36;

-- Question 37
UPDATE questions SET 
  question_text = 'A pharmacist <u>supplies</u> prescribed medications and <u>gives</u> information <u>to patients</u> about <u>theirs</u> use.',
  option_a = 'supplies',
  option_b = 'gives',
  option_c = 'to patients',
  option_d = 'theirs'
WHERE section = 'structure' AND question_number = 37;

-- Question 38
UPDATE questions SET 
  question_text = 'The body <u>depends on</u> bones <u>to support</u> its weight, and the <u>weight bearing</u> function of bones increases their <u>strengthen</u>.',
  option_a = 'depends on',
  option_b = 'to support',
  option_c = 'weight bearing',
  option_d = 'strengthen'
WHERE section = 'structure' AND question_number = 38;

-- Question 39
UPDATE questions SET 
  question_text = 'The North American raccoon <u>is</u> native <u>to</u> temperate regions, and its range <u>extending</u> from Canada <u>to</u> Central America.',
  option_a = 'is',
  option_b = 'to',
  option_c = 'extending',
  option_d = 'to'
WHERE section = 'structure' AND question_number = 39;

-- Question 40
UPDATE questions SET 
  question_text = 'People <u>who</u> enjoy watching wildlife <u>should visit</u> the Central Park Zoo, where <u>there are</u> many animals that <u>is</u> rare in the wild.',
  option_a = 'who',
  option_b = 'should visit',
  option_c = 'there are',
  option_d = 'is'
WHERE section = 'structure' AND question_number = 40;
