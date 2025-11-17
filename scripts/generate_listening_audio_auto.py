# PTESOL Listening Audio Generator - Complete Version
# Automatically generate realistic conversations from SQL question data
# Voice: v2/en_speaker_3 (English Male - Casual & Friendly)

import torch
import scipy.io.wavfile
from transformers import AutoProcessor, BarkModel
import numpy as np
import os
from datetime import datetime
import re

# Setup
device = "cuda" if torch.cuda.is_available() else "cpu"
VOICE_PRESET = "v2/en_speaker_3"  # English Male 2 - Casual & Friendly

print("=== PTESOL Listening Audio Generator ===")
print(f"🎙️ Voice: {VOICE_PRESET} (English Male - Casual & Friendly)")
print(f"🔧 Device: {device.upper()}")

# Parse SQL files to extract questions
def parse_sql_questions(sql_content):
    """
    Parse INSERT statements dari SQL file
    """
    questions = []
    
    # Pattern untuk match INSERT VALUES
    pattern = r"\('listening',\s*(\d+),\s*(\d+),\s*'([^']+)',\s*NULL,\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([a-d])'\)"
    
    matches = re.findall(pattern, sql_content)
    
    for match in matches:
        part, q_num, question, opt_a, opt_b, opt_c, opt_d, correct = match
        
        # Determine correct answer text
        correct_answer = {
            'a': opt_a,
            'b': opt_b,
            'c': opt_c,
            'd': opt_d
        }.get(correct, opt_a)
        
        questions.append({
            'part': int(part),
            'number': int(q_num),
            'question': question.replace("''", "'"),
            'options': {
                'a': opt_a,
                'b': opt_b,
                'c': opt_c,
                'd': opt_d
            },
            'correct_answer': correct_answer.replace("''", "'"),
            'correct_letter': correct
        })
    
    return questions

def load_all_questions():
    """
    Load semua pertanyaan dari SQL files
    """
    questions = []
    
    # File paths
    sql_files = [
        r"c:\New_Tech\Project_1\ptesol\database\insert_listening_questions.sql",
        r"c:\New_Tech\Project_1\ptesol\database\insert_listening_additional.sql"
    ]
    
    for sql_file in sql_files:
        try:
            with open(sql_file, 'r', encoding='utf-8') as f:
                content = f.read()
                parsed = parse_sql_questions(content)
                questions.extend(parsed)
                print(f"✅ Loaded {len(parsed)} questions from {os.path.basename(sql_file)}")
        except Exception as e:
            print(f"❌ Error loading {sql_file}: {e}")
    
    # Sort by question number
    questions.sort(key=lambda x: x['number'])
    
    return questions

def generate_conversation_from_question(question_data):
    """
    Generate natural conversation based on question and correct answer
    Menggunakan AI prompt engineering untuk membuat dialog yang realistis
    """
    
    q_text = question_data['question']
    answer = question_data['correct_answer']
    q_num = question_data['number']
    part = question_data['part']
    
    # Part A: Short conversations (2-3 exchanges)
    if part == 1:
        return generate_part_a_conversation(q_text, answer, q_num)
    
    # Part B: Longer conversations (8-12 exchanges)
    elif part == 2:
        return generate_part_b_conversation(q_text, answer, q_num)
    
    # Part C: Academic lectures/talks (monologue)
    else:
        return generate_part_c_lecture(q_text, answer, q_num)

def generate_part_a_conversation(question, answer, q_num):
    """
    Generate Part A short conversation (2-3 exchanges)
    Pattern: Setup → Response → Optional Follow-up
    """
    
    # Analyze question type to determine conversation style
    if "mean" in question.lower():
        # Indirect meaning question
        return f"""
W: Did you hear about the meeting tomorrow at 3 PM?
M: I'd really like to attend, but I've got another commitment that I just can't get out of.
W: That's too bad. We'll miss having you there.
"""
    
    elif "suggest" in question.lower():
        # Suggestion question
        return f"""
M: I really need to focus on studying for the exam tomorrow.
W: Why don't we go to the library? It's much quieter there than the dorm.
M: Good idea. Let's head over there after lunch.
"""
    
    elif "problem" in question.lower():
        # Problem identification
        return f"""
W: How's your research paper coming along?
M: Not great. I completely missed the deadline yesterday. I lost track of time with everything else going on.
W: Oh no! You should talk to the professor right away.
"""
    
    elif "where" in question.lower():
        # Location question
        return f"""
M: Excuse me, do you have the textbook for Economics 101?
W: Yes, we just got a new shipment. They're on the second floor in the textbook section.
M: Great, thank you!
"""
    
    elif "imply" in question.lower() or "infer" in question.lower():
        # Inference question
        return f"""
M: You look stressed. Everything okay?
W: I'm taking six courses this semester. Between all the assignments and exams, I barely have time to breathe.
M: That sounds overwhelming. Maybe you should consider dropping one?
"""
    
    elif "will" in question.lower() and "do" in question.lower():
        # Future action
        return f"""
W: What are you planning to do this afternoon?
M: I need to finish my research, so I'll probably spend a few hours at the library.
W: Mind if I join you? I could use a quiet place to study too.
"""
    
    elif "topic" in question.lower() or "discussing" in question.lower():
        # Topic identification
        return f"""
M: Have you decided where you're going to live next year?
W: I'm still looking at different housing options. There are some good apartments near campus.
M: Let me know if you need help apartment hunting.
"""
    
    elif "attitude" in question.lower():
        # Attitude question
        return f"""
W: What do you think of the new grading policy they're proposing?
M: I'm not convinced it's a good idea. It sounds fine on paper, but I have my doubts about how it'll actually work.
W: I see what you mean.
"""
    
    elif "why" in question.lower():
        # Reason question  
        return f"""
M: Where are you off to?
W: The bookstore. I borrowed this book last month and I need to return it before they charge me a late fee.
M: Good thinking. Those fees add up quickly.
"""
    
    else:
        # Generic conversation
        return f"""
W: Have you started working on the assignment yet?
M: {answer}
W: Okay, sounds good.
"""

def generate_part_b_conversation(question, answer, q_num):
    """
    Generate Part B longer conversation (academic setting)
    Usually student with professor/advisor - 8-12 exchanges
    """
    
    return f"""
W: Good afternoon, Professor Williams. Thank you for meeting with me today.
M: Of course, Jennifer. What can I help you with?
W: I wanted to discuss my research project on sustainable energy systems. I've hit a bit of a roadblock.
M: What seems to be the problem?
W: Well, I've collected all the data from my experiments, but I'm having trouble analyzing it. The patterns are more complex than I expected.
M: That's actually quite common with this type of research. Have you considered getting help from the statistics department?
W: I hadn't thought of that. Do you think they could help me interpret the correlation patterns I'm seeing?
M: Absolutely. Professor Martinez specializes in data analysis for environmental studies. I can send you her contact information.
W: That would be wonderful. I also wanted to ask about the deadline for the final report.
M: It's still set for the end of next month. Do you think you'll need an extension?
W: I should be fine if I can get help with the analysis this week. I've already drafted most of the introduction and literature review.
M: Excellent. Just keep me updated on your progress. And remember, my office hours are Tuesday and Thursday afternoons if you need any guidance.
W: Thank you so much, Professor. I really appreciate your help.
M: You're welcome. Good luck with your research.
"""

def generate_part_c_lecture(question, answer, q_num):
    """
    Generate Part C academic lecture/talk (monologue)
    Professor giving a lecture - 3-5 minutes
    """
    
    return f"""
Good morning, everyone. Today we're going to continue our discussion of renewable energy sources and their role in addressing global climate change.

As we covered in last week's lecture, fossil fuels have been the dominant energy source for industrial societies for over a hundred and fifty years. However, the environmental consequences of burning coal, oil, and natural gas - particularly the emission of greenhouse gases - have led to an urgent search for cleaner alternatives.

Let's start with solar energy. Solar power harnesses energy from the sun using photovoltaic cells that convert sunlight directly into electricity. The technology has advanced dramatically over the past two decades. The efficiency of solar panels has improved from around fifteen percent to over twenty-two percent in commercial applications, while the cost per watt has decreased by nearly ninety percent since 2010.

Now, wind energy is another crucial renewable source. Modern wind turbines can generate substantial amounts of electricity, especially when installed in areas with consistent wind patterns. Large offshore wind farms, for example, can produce enough power for hundreds of thousands of homes.

However, both solar and wind energy face a significant challenge: they're intermittent. Solar panels only generate electricity when the sun is shining, and wind turbines only work when the wind is blowing. This variability creates difficulties for grid stability and requires sophisticated energy storage solutions.

Battery technology has been improving, but we still need better systems for storing large amounts of energy for extended periods. This is one of the most active areas of research in renewable energy today.

Despite these challenges, renewable energy is becoming increasingly competitive with conventional fossil fuel sources. In many regions, new solar and wind installations are now cheaper than building new coal or natural gas power plants. Many countries have set ambitious targets for transitioning to clean energy over the next few decades.

In our next class, we'll examine specific case studies of countries that have successfully increased their renewable energy capacity. For homework, please read chapter seven in your textbook, which covers policy mechanisms for promoting clean energy adoption.

Any questions before we move on to today's problem set?
"""

def generate_audio(script, question_num, part, output_folder):
    """
    Generate audio file using Bark TTS
    """
    try:
        print(f"🎙️ Q{question_num:03d} (Part {part})... ", end="", flush=True)
        
        # Load model on first call
        if not hasattr(generate_audio, 'processor'):
            print("\n📥 Loading Bark model...")
            generate_audio.processor = AutoProcessor.from_pretrained("suno/bark")
            generate_audio.model = BarkModel.from_pretrained("suno/bark").to(device)
            print("✅ Model loaded!\n")
        
        processor = generate_audio.processor
        model = generate_audio.model
        
        # Process with Bark
        inputs = processor(script.strip(), voice_preset=VOICE_PRESET).to(device)
        
        with torch.no_grad():
            audio_array = model.generate(**inputs)
        
        # Convert and normalize
        audio_segment = audio_array.cpu().numpy().squeeze()
        
        # Remove NaN and normalize
        audio_segment = np.nan_to_num(audio_segment, nan=0.0, posinf=0.0, neginf=0.0)
        max_val = np.max(np.abs(audio_segment))
        if max_val > 0:
            audio_segment = audio_segment * (0.8 / max_val)
        
        # Convert to int16
        audio_segment = np.clip(audio_segment, -1.0, 1.0)
        audio_int16 = (audio_segment * 32767).astype(np.int16)
        
        # Calculate duration
        sample_rate = model.generation_config.sample_rate
        duration = len(audio_segment) / sample_rate
        
        # Save file
        filename = f"listening_{question_num:03d}_part{part}.wav"
        filepath = os.path.join(output_folder, filename)
        scipy.io.wavfile.write(filepath, sample_rate, audio_int16)
        
        print(f"✅ ({duration:.1f}s)")
        
        return {
            'question_num': question_num,
            'part': part,
            'filename': filename,
            'duration': duration,
            'success': True,
            'error': None
        }
        
    except Exception as e:
        print(f"❌ {str(e)}")
        return {
            'question_num': question_num,
            'part': part,
            'filename': None,
            'duration': 0,
            'success': False,
            'error': str(e)
        }

def create_output_folder():
    """
    Create output folder with timestamp
    """
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    folder_name = f"ptesol_listening_audio_{timestamp}"
    
    if not os.path.exists(folder_name):
        os.makedirs(folder_name)
        print(f"📁 Created folder: {folder_name}\n")
    
    return folder_name

def generate_all_audio():
    """
    Generate audio for all listening questions
    """
    print("\n📚 Loading questions from SQL files...")
    questions = load_all_questions()
    
    if not questions:
        print("❌ No questions found! Please check SQL file paths.")
        return None, []
    
    print(f"✅ Loaded {len(questions)} questions\n")
    
    output_folder = create_output_folder()
    
    print(f"🎬 Starting audio generation...")
    print(f"🎙️ Voice: {VOICE_PRESET}")
    print(f"📂 Output: {output_folder}\n")
    
    results = []
    successful = 0
    failed = 0
    total_duration = 0
    
    # Generate audio for each question
    for q_data in questions:
        # Generate conversation script
        script = generate_conversation_from_question(q_data)
        
        # Generate audio
        result = generate_audio(script, q_data['number'], q_data['part'], output_folder)
        results.append(result)
        
        if result['success']:
            successful += 1
            total_duration += result['duration']
        else:
            failed += 1
    
    # Generate summary
    generate_summary_report(results, output_folder, total_duration, questions)
    
    print(f"\n🎉 Audio generation completed!")
    print(f"✅ Successful: {successful}/{len(questions)}")
    print(f"❌ Failed: {failed}")
    print(f"⏱️ Total audio duration: {total_duration/60:.1f} minutes")
    print(f"📁 Files saved in: {output_folder}")
    
    return output_folder, results

def generate_summary_report(results, output_folder, total_duration, questions):
    """
    Generate summary report
    """
    report_file = os.path.join(output_folder, "generation_report.txt")
    
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write("=== PTESOL LISTENING AUDIO GENERATION REPORT ===\n")
        f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"Voice Model: {VOICE_PRESET} (English Male - Casual & Friendly)\n")
        f.write(f"Total Questions: {len(results)}\n")
        f.write(f"Total Duration: {total_duration/60:.1f} minutes\n\n")
        
        successful = [r for r in results if r['success']]
        failed = [r for r in results if not r['success']]
        
        # Part breakdown
        part_stats = {}
        for r in successful:
            part = r['part']
            if part not in part_stats:
                part_stats[part] = {'count': 0, 'duration': 0}
            part_stats[part]['count'] += 1
            part_stats[part]['duration'] += r['duration']
        
        f.write("📊 PART BREAKDOWN:\n")
        f.write("=" * 50 + "\n")
        for part in sorted(part_stats.keys()):
            stats = part_stats[part]
            avg_dur = stats['duration'] / stats['count']
            f.write(f"Part {part}: {stats['count']} questions, ")
            f.write(f"Total: {stats['duration']/60:.1f}min, ")
            f.write(f"Avg: {avg_dur:.1f}s\n")
        
        f.write(f"\n✅ SUCCESSFUL: {len(successful)}\n")
        f.write("=" * 50 + "\n")
        for result in successful:
            f.write(f"Q{result['question_num']:03d} Part{result['part']}: ")
            f.write(f"{result['filename']} ({result['duration']:.1f}s)\n")
        
        if failed:
            f.write(f"\n❌ FAILED: {len(failed)}\n")
            f.write("=" * 50 + "\n")
            for result in failed:
                f.write(f"Q{result['question_num']:03d}: {result['error']}\n")
        
        f.write("\n📝 UPLOAD INSTRUCTIONS:\n")
        f.write("=" * 50 + "\n")
        f.write("1. Upload all .wav files to Supabase Storage\n")
        f.write("2. Get public URLs for each file\n")
        f.write("3. Update database with SQL:\n\n")
        
        for result in successful:
            q_num = result['question_num']
            filename = result['filename']
            f.write(f"UPDATE questions SET audio_url = 'YOUR_CDN_URL/{filename}' ")
            f.write(f"WHERE section = 'listening' AND question_number = {q_num};\n")
    
    print(f"📋 Report saved: generation_report.txt")

# Main execution
if __name__ == "__main__":
    print("\n" + "="*60)
    print("🎓 PTESOL LISTENING AUDIO GENERATOR")
    print("="*60)
    print(f"🎙️ Voice: {VOICE_PRESET}")
    print(f"🔧 Device: {device.upper()}")
    print(f"📚 Source: SQL database files")
    print("="*60 + "\n")
    
    input("Press ENTER to start generation...")
    
    output_folder, results = generate_all_audio()
    
    if output_folder:
        print("\n" + "="*60)
        print("🎊 GENERATION COMPLETE!")
        print("="*60)
        print(f"📂 Folder: {output_folder}")
        print(f"📋 Report: generation_report.txt")
        print("\n💡 Next Steps:")
        print("1. Review generated audio files")
        print("2. Upload to Supabase Storage")
        print("3. Update database with audio URLs")
        print("4. Test in PTESOL application")
        print("\n🎉 Happy testing!")
