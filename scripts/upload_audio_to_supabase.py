# Upload Audio ke Supabase Storage - Python Script
# Run this after generating audio files from Colab

from supabase import create_client
import os
from pathlib import Path

# Supabase credentials
SUPABASE_URL = "https://yuzxvbhcozrjwejmbqmy.supabase.co"
SUPABASE_KEY = "YOUR_SUPABASE_ANON_KEY"  # Ganti dengan anon key Anda

# Initialize Supabase client
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

# Folder berisi audio files
AUDIO_FOLDER = "ptesol_listening_audio_20250117_120000"  # Ganti dengan folder hasil generate

def upload_audio_to_supabase():
    """
    Upload semua file audio ke Supabase Storage
    """
    
    audio_files = list(Path(AUDIO_FOLDER).glob("*.wav"))
    
    print(f"📂 Found {len(audio_files)} audio files")
    print(f"🚀 Starting upload to Supabase Storage...\n")
    
    uploaded = []
    failed = []
    
    for audio_file in audio_files:
        filename = audio_file.name
        
        try:
            print(f"⬆️  Uploading {filename}... ", end="", flush=True)
            
            # Read file
            with open(audio_file, 'rb') as f:
                audio_data = f.read()
            
            # Upload to Supabase Storage
            response = supabase.storage.from_('ptesol-audio').upload(
                path=filename,
                file=audio_data,
                file_options={"content-type": "audio/wav"}
            )
            
            # Get public URL
            public_url = supabase.storage.from_('ptesol-audio').get_public_url(filename)
            
            uploaded.append({
                'filename': filename,
                'url': public_url
            })
            
            print(f"✅")
            
        except Exception as e:
            print(f"❌ {str(e)}")
            failed.append({
                'filename': filename,
                'error': str(e)
            })
    
    # Generate SQL UPDATE statements
    generate_update_sql(uploaded)
    
    print(f"\n🎉 Upload completed!")
    print(f"✅ Successful: {len(uploaded)}")
    print(f"❌ Failed: {len(failed)}")
    print(f"📝 SQL update statements saved to: audio_urls_update.sql")
    
    return uploaded, failed

def generate_update_sql(uploaded_files):
    """
    Generate SQL UPDATE statements untuk update database
    """
    
    sql_file = "audio_urls_update.sql"
    
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write("-- Auto-generated SQL UPDATE statements\n")
        f.write("-- Update audio_url for all listening questions\n\n")
        
        for item in uploaded_files:
            filename = item['filename']
            url = item['url']
            
            # Extract question number from filename
            # Format: listening_001_part1.wav
            parts = filename.replace('.wav', '').split('_')
            q_num = int(parts[1])  # Get "001"
            
            sql = f"UPDATE questions SET audio_url = '{url}' WHERE section = 'listening' AND question_number = {q_num};\n"
            f.write(sql)
        
        f.write(f"\n-- Total: {len(uploaded_files)} audio URLs updated\n")
    
    print(f"\n📝 Generated SQL file: {sql_file}")

if __name__ == "__main__":
    print("="*60)
    print("🎵 PTESOL Audio Uploader to Supabase Storage")
    print("="*60)
    print(f"📂 Folder: {AUDIO_FOLDER}")
    print(f"🌐 Supabase: {SUPABASE_URL}")
    print(f"🪣 Bucket: ptesol-audio")
    print("="*60 + "\n")
    
    # Check if folder exists
    if not os.path.exists(AUDIO_FOLDER):
        print(f"❌ Error: Folder '{AUDIO_FOLDER}' not found!")
        print("Please update AUDIO_FOLDER variable with correct path.")
        exit(1)
    
    # Check Supabase key
    if SUPABASE_KEY == "YOUR_SUPABASE_ANON_KEY":
        print("❌ Error: Please update SUPABASE_KEY with your actual key!")
        print("Get it from: Supabase Dashboard > Settings > API > anon public")
        exit(1)
    
    input("Press ENTER to start upload...")
    
    uploaded, failed = upload_audio_to_supabase()
    
    if len(uploaded) > 0:
        print("\n💡 Next Steps:")
        print("1. Open audio_urls_update.sql")
        print("2. Copy all SQL statements")
        print("3. Run in Supabase SQL Editor")
        print("4. Test audio playback in your app")
        print("\n✨ No need to redeploy Vercel!")
