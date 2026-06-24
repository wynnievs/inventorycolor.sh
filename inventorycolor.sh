#!/bin/bash
# Color Codes
COLOR_Q=$'\033[1;36m'   # Bright Cyan for questions
COLOR_OFF=$'\033[0m'    # Resets text back to default

# Define the file to keep record of inputs
CSV_FILE="inventory_records.csv"

# Color Codes
COLOR_QUESTION="\033[1;36m" # Bright Cyan for questions
COLOR_RESET="\033[0m"       # Resets text back to normal

# Create the CSV header if the file doesn't exist yet
if [ ! -f "$CSV_FILE" ]; then
    echo "Timestamp,1. Trigger,2. Thoughts,3. Response,4. Alternative,5. Amends,6. Success,7. Gratitude" > "$CSV_FILE"
fi

questions=(
    "1. What happened today that triggered an emotional response? "
    "2. What thoughts did I notice and were they distorted? "
    "3. How did I respond today (what were my words/actions)? "
    "4. What could I have done differently? "
    "5. Did I harm anyone and do I need to make amends? "
    "6. What went well today? "
    "7. Name one affirmation or something you are grateful for: "
)

echo "=== Daily Emotional Inventory Log ==="
echo "Take a deep breath and reflect on your day."
echo "==========================================="

# Array to store user answers
answers=()

# Loop through and ask the 7 questions
for i in "${!questions[@]}"; do
    # Pass the colorized text variables directly inside the prompt string
    read -p "${COLOR_Q}${questions[$i]}${COLOR_OFF}" input
    
    # Escape internal double quotes to safeguard CSV formatting
    clean_input=$(echo "$input" | sed 's/"/""/g')
    
    # Wrap each text answer securely in outer double quotes
    responses+=("\"$clean_input\"")
done

# Format a timestamp (YYYY-MM-DD HH:MM:SS)
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Construct the CSV line using the array elements
csv_line="\"$timestamp\",${responses[0]},${responses[1]},${responses[2]},${responses[3]},${responses[4]},${responses[5]},${responses[6]}"

# Append the entry to the CSV file
echo "$csv_line" >> "$CSV_FILE"

echo "==========================================="
echo "❤️ Reflection saved successfully to $CSV_FILE!"
