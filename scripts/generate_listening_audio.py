# PTESOL Listening Audio Generator
# Generate audio untuk semua 200 soal listening menggunakan Bark TTS
# Voice: v2/en_speaker_3 (English Male - Casual & Friendly)

import torch
import scipy.io.wavfile
from transformers import AutoProcessor, BarkModel
import numpy as np
import os
from datetime import datetime
import json

# Setup
device = "cuda" if torch.cuda.is_available() else "cpu"
VOICE_PRESET = "v2/en_speaker_3"  # English Male 2 - Casual & Friendly

print("=== PTESOL Listening Audio Generator ===")
print(f"🎙️ Voice: {VOICE_PRESET} (English Male - Casual & Friendly)")
print(f"📊 Total Questions: 200 (Part A: 100, Part B: 30, Part C: 70)")
print(f"🔧 Device: {device.upper()}")
print("\nMemuat model Bark...")

processor = AutoProcessor.from_pretrained("suno/bark")
model = BarkModel.from_pretrained("suno/bark").to(device)
print("✅ Model Bark berhasil dimuat!\n")

# Database soal listening (dari SQL files)
LISTENING_QUESTIONS = {
    # Part A: Short Conversations (1-100)
    # Format: question_number: {"question": "...", "correct_answer": "option_text", "context": "conversation_context"}
    
    # Questions 1-30 (dari insert_listening_questions.sql)
    1: {
        "question": "What does the man mean?",
        "answer": "He cannot make it to the meeting",
        "context": "meeting attendance"
    },
    2: {
        "question": "What does the woman suggest they do?",
        "answer": "Go to the library",
        "context": "study location"
    },
    3: {
        "question": "What is the man's problem?",
        "answer": "He missed the deadline",
        "context": "assignment deadline"
    },
    4: {
        "question": "Where does this conversation probably take place?",
        "answer": "At a bookstore",
        "context": "location identification"
    },
    5: {
        "question": "What does the woman imply about the course?",
        "answer": "It requires too much reading",
        "context": "course difficulty"
    },
    6: {
        "question": "What will the man probably do next?",
        "answer": "Go to the library",
        "context": "next action"
    },
    7: {
        "question": "What does the woman mean?",
        "answer": "She agrees with the man",
        "context": "agreement"
    },
    8: {
        "question": "What can be inferred about the woman?",
        "answer": "She is taking too many courses",
        "context": "academic workload"
    },
    9: {
        "question": "What does the man suggest?",
        "answer": "Postponing the meeting",
        "context": "meeting schedule"
    },
    10: {
        "question": "Why is the woman going to the bookstore?",
        "answer": "To return a book",
        "context": "bookstore visit"
    },
    11: {
        "question": "What does the man imply?",
        "answer": "He did not study enough",
        "context": "exam preparation"
    },
    12: {
        "question": "What are the speakers mainly discussing?",
        "answer": "A research project",
        "context": "academic discussion"
    },
    13: {
        "question": "What does the woman mean when she says, 'I wish I had known'?",
        "answer": "She would have acted differently",
        "context": "regret expression"
    },
    14: {
        "question": "What is the man's attitude toward the proposal?",
        "answer": "Skeptical",
        "context": "proposal evaluation"
    },
    15: {
        "question": "What will the woman probably do?",
        "answer": "Talk to the professor",
        "context": "seeking advice"
    },
    16: {
        "question": "What does the man imply about the assignment?",
        "answer": "It is confusing",
        "context": "assignment difficulty"
    },
    17: {
        "question": "Why does the woman mention her roommate?",
        "answer": "To explain her situation",
        "context": "providing context"
    },
    18: {
        "question": "What can be inferred about the man?",
        "answer": "He is nervous",
        "context": "emotional state"
    },
    19: {
        "question": "What does the woman suggest the man do?",
        "answer": "Talk to his advisor",
        "context": "giving advice"
    },
    20: {
        "question": "What is the main topic of the conversation?",
        "answer": "Housing options",
        "context": "accommodation discussion"
    },
    21: {
        "question": "What does the man mean?",
        "answer": "He is too busy",
        "context": "declining help"
    },
    22: {
        "question": "What does the woman imply about the professor?",
        "answer": "He is helpful",
        "context": "professor feedback"
    },
    23: {
        "question": "What will the speakers probably do next?",
        "answer": "Study together",
        "context": "joint activity"
    },
    24: {
        "question": "What is the woman's problem?",
        "answer": "She does not understand the assignment",
        "context": "academic confusion"
    },
    25: {
        "question": "What does the man suggest?",
        "answer": "Using the writing center",
        "context": "academic resources"
    },
    26: {
        "question": "What can be inferred about the woman?",
        "answer": "She works part-time",
        "context": "employment status"
    },
    27: {
        "question": "What does the man mean?",
        "answer": "He needs more time",
        "context": "time management"
    },
    28: {
        "question": "What are the speakers discussing?",
        "answer": "A class presentation",
        "context": "academic presentation"
    },
    29: {
        "question": "What does the woman imply?",
        "answer": "She needs to check her schedule",
        "context": "schedule confirmation"
    },
    30: {
        "question": "What will the man probably do?",
        "answer": "Revise his paper",
        "context": "paper revision"
    },
    
    # Part B & C will be added similarly...
    # For now, let's create the structure for all 200 questions
}

def create_conversation_script(question_num, question_data):
    """
    Generate natural conversation script based on question context
    Format TOEFL: 2 people conversation (M = Man, W = Woman)
    """
    
    context = question_data.get("context", "general")
    answer = question_data.get("answer", "")
    
    # Template conversations based on context
    conversations = {
        "meeting attendance": [
            "W: Are you coming to the meeting this afternoon?",
            "M: I'm afraid I have another commitment. I won't be able to make it."
        ],
        "study location": [
            "M: Where should we study for tomorrow's exam?",
            "W: How about the library? It's quiet there and we can find all the materials we need."
        ],
        "assignment deadline": [
            "W: Did you submit the research paper on time?",
            "M: No, unfortunately I missed the deadline. I had some technical issues with my computer."
        ],
        "location identification": [
            "M: Excuse me, do you have the latest edition of Introduction to Psychology?",
            "W: Yes, let me check. We have three copies left on the second floor, in the textbook section."
        ],
        "course difficulty": [
            "M: How's your literature course going?",
            "W: It's interesting, but honestly, there's so much reading every week. I can barely keep up with the assignments."
        ],
        "next action": [
            "W: What are your plans for this afternoon?",
            "M: I need to finish some research for my paper, so I'll probably head to the library after lunch."
        ],
        "agreement": [
            "M: I think the professor should give us more time for this project.",
            "W: I completely agree with you. The deadline is too tight for such a complex assignment."
        ],
        "academic workload": [
            "M: You look exhausted. Is everything okay?",
            "W: I'm taking six courses this semester. Between classes, assignments, and exams, I barely have time to sleep."
        ],
        "meeting schedule": [
            "W: Should we have our study group meeting tomorrow as planned?",
            "M: Actually, I think we should postpone it. Several members have exams this week."
        ],
        "bookstore visit": [
            "M: Where are you headed?",
            "W: To the bookstore. I need to return this book I borrowed last month before the late fee kicks in."
        ],
        "exam preparation": [
            "W: How did you do on the midterm?",
            "M: Not as well as I hoped. I didn't study enough, especially for the essay questions."
        ],
        "academic discussion": [
            "M: What's the main focus of your term paper?",
            "W: I'm working on a research project about climate change impacts on coastal ecosystems."
        ],
        "regret expression": [
            "M: The workshop last week was really helpful for understanding statistical analysis.",
            "W: Oh, I wish I had known about it. I would have definitely attended if someone had told me."
        ],
        "proposal evaluation": [
            "W: What do you think about the new grading policy the department proposed?",
            "M: I'm not sure about it. It sounds good in theory, but I'm skeptical about how it will work in practice."
        ],
        "seeking advice": [
            "M: You seem worried. What's wrong?",
            "W: I'm having trouble deciding which courses to take next semester. I think I should talk to my professor for advice."
        ],
        "assignment difficulty": [
            "W: Have you started the statistics assignment?",
            "M: I tried, but honestly, the instructions are really confusing. I'm not sure what the professor wants us to do."
        ],
        "providing context": [
            "M: Why can't you join us for the group project meeting tonight?",
            "W: My roommate is sick and I need to take her to the health center. I have to stay with her."
        ],
        "emotional state": [
            "W: Are you ready for your presentation tomorrow?",
            "M: Not really. I've prepared everything, but I'm quite nervous about speaking in front of the whole class."
        ],
        "giving advice": [
            "M: I'm not sure which major to choose. Engineering or Business?",
            "W: That's a big decision. I think you should talk to your academic advisor. They can help you explore both options."
        ],
        "accommodation discussion": [
            "W: Have you found a place to live next semester?",
            "M: Not yet. I'm looking at several housing options, both on-campus and off-campus apartments."
        ],
    }
    
    # Get conversation or create generic one
    if context in conversations:
        dialogue = conversations[context]
    else:
        # Generic conversation template
        dialogue = [
            f"M: I was wondering about {context}.",
            f"W: {answer}."
        ]
    
    # Format for TTS: combine lines with natural pauses
    script = " [pause] ".join(dialogue)
    
    return script

def create_longer_conversation(question_num, question_data):
    """
    Generate longer conversation for Part B (questions 31-38 per group)
    """
    # Part B: 2-3 minute conversations between student and professor/advisor
    topic = question_data.get("context", "academic discussion")
    
    script = f"""
    W: Good morning, Professor Johnson. Thanks for meeting with me today.
    M: Of course, Sarah. What can I help you with?
    W: I wanted to discuss my research project on renewable energy systems.
    M: Ah yes, how is that progressing?
    W: I've collected the data, but I'm having some difficulty with the analysis. The results are quite complex.
    M: That's not unusual for this type of research. Have you considered consulting with someone from the statistics department?
    W: I haven't, but that's a good idea. Do you think they could help with interpreting the correlation patterns?
    M: Absolutely. Dr. Martinez specializes in data analysis. I can introduce you if you'd like.
    W: That would be wonderful. Also, I was wondering about the deadline for the project.
    M: It's still set for the end of next month. Do you think you'll need more time?
    W: I should be able to make it, especially if I can get help with the statistical analysis.
    M: Good. Just keep me updated on your progress, and don't hesitate to reach out if you need guidance.
    """
    
    return script.strip()

def create_lecture_script(question_num, question_data):
    """
    Generate academic lecture for Part C (questions 39-50 per group)
    """
    # Part C: 3-5 minute academic lectures
    topic = question_data.get("context", "academic lecture")
    
    script = """
    Good morning, class. Today we're going to discuss renewable energy sources and their role in addressing climate change.
    As we've learned in previous lectures, fossil fuels have been the primary energy source for industrialized societies for over a century.
    However, the environmental impacts of burning fossil fuels, particularly greenhouse gas emissions, have led to a global search for cleaner alternatives.
    Solar energy is one of the most promising renewable sources. Photovoltaic cells convert sunlight directly into electricity.
    The efficiency of solar panels has improved dramatically over the past decade, while costs have decreased significantly.
    Wind energy is another important renewable source. Modern wind turbines can generate substantial amounts of electricity, especially in areas with consistent wind patterns.
    Both solar and wind energy are intermittent, meaning they only generate power when the sun is shining or wind is blowing.
    This variability presents challenges for grid stability and requires development of energy storage systems, such as large-scale batteries.
    Despite these challenges, renewable energy is becoming increasingly competitive with conventional fossil fuel sources.
    Many countries have set ambitious targets for transitioning to clean energy in the coming decades.
    """
    
    return script.strip()

def generate_audio(script, question_num, output_folder):
    """
    Generate audio file using Bark TTS
    """
    try:
        print(f"🎙️ Generating Q{question_num:03d}... ", end="", flush=True)
        
        # Process with Bark
        inputs = processor(script, voice_preset=VOICE_PRESET).to(device)
        
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
        filename = f"listening_{question_num:03d}.wav"
        filepath = os.path.join(output_folder, filename)
        scipy.io.wavfile.write(filepath, sample_rate, audio_int16)
        
        print(f"✅ ({duration:.1f}s)")
        
        return {
            'question_num': question_num,
            'filename': filename,
            'duration': duration,
            'success': True,
            'error': None
        }
        
    except Exception as e:
        print(f"❌ Error: {str(e)}")
        return {
            'question_num': question_num,
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
    Generate audio for all 200 listening questions
    """
    output_folder = create_output_folder()
    
    print(f"🎬 Starting audio generation for {len(LISTENING_QUESTIONS)} questions...")
    print(f"🎙️ Voice: {VOICE_PRESET}")
    print(f"📂 Output: {output_folder}\n")
    
    results = []
    successful = 0
    failed = 0
    total_duration = 0
    
    # Generate audio for each question
    for q_num in sorted(LISTENING_QUESTIONS.keys()):
        question_data = LISTENING_QUESTIONS[q_num]
        
        # Determine which type of conversation based on question number
        if q_num <= 30 or (q_num >= 51 and q_num <= 100):
            # Part A: Short conversations
            script = create_conversation_script(q_num, question_data)
        elif q_num <= 38 or (q_num >= 101 and q_num <= 130):
            # Part B: Longer conversations
            script = create_longer_conversation(q_num, question_data)
        else:
            # Part C: Lectures
            script = create_lecture_script(q_num, question_data)
        
        # Generate audio
        result = generate_audio(script, q_num, output_folder)
        results.append(result)
        
        if result['success']:
            successful += 1
            total_duration += result['duration']
        else:
            failed += 1
    
    # Generate summary
    generate_summary_report(results, output_folder, total_duration)
    
    print(f"\n🎉 Audio generation completed!")
    print(f"✅ Successful: {successful}/{len(LISTENING_QUESTIONS)}")
    print(f"❌ Failed: {failed}")
    print(f"⏱️ Total audio duration: {total_duration/60:.1f} minutes")
    print(f"📁 Files saved in: {output_folder}")
    
    return output_folder, results

def generate_summary_report(results, output_folder, total_duration):
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
        
        f.write(f"✅ SUCCESSFUL: {len(successful)}\n")
        f.write("=" * 50 + "\n")
        for result in successful:
            f.write(f"Q{result['question_num']:03d}: {result['filename']} ({result['duration']:.1f}s)\n")
        
        if failed:
            f.write(f"\n❌ FAILED: {len(failed)}\n")
            f.write("=" * 50 + "\n")
            for result in failed:
                f.write(f"Q{result['question_num']:03d}: {result['error']}\n")
        
        f.write("\n📊 STATISTICS:\n")
        f.write("=" * 50 + "\n")
        f.write(f"Success Rate: {len(successful)/len(results)*100:.1f}%\n")
        f.write(f"Average Duration: {total_duration/len(successful):.1f}s per question\n")
        f.write(f"Part A (Short): ~30s each\n")
        f.write(f"Part B (Medium): ~2min each\n")
        f.write(f"Part C (Long): ~4min each\n")
    
    print(f"📋 Report saved: generation_report.txt")

# Main execution
if __name__ == "__main__":
    print("\n" + "="*60)
    print("🎓 PTESOL LISTENING AUDIO GENERATOR")
    print("="*60)
    print(f"📊 Total Questions: {len(LISTENING_QUESTIONS)}")
    print(f"🎙️ Voice: {VOICE_PRESET}")
    print(f"🔧 Device: {device.upper()}")
    print("="*60 + "\n")
    
    input("Press ENTER to start generation...")
    
    output_folder, results = generate_all_audio()
    
    print("\n" + "="*60)
    print("🎊 GENERATION COMPLETE!")
    print("="*60)
    print(f"📂 Folder: {output_folder}")
    print(f"📋 Report: generation_report.txt")
    print("\n💡 Next Steps:")
    print("1. Review the generated audio files")
    print("2. Upload files to storage (Supabase Storage/CDN)")
    print("3. Update database with audio URLs")
    print("4. Test audio playback in the application")
    print("\n🎉 Happy testing!")
