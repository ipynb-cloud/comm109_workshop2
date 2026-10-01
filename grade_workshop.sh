#!/bin/bash

# A script to automatically grade Python exercises.
# It detects which exercises to grade by finding all .txt files
# in the 'ref_output' directory.

# --- Configuration ---
# Directory containing the correct output files (e.g., ex1_variables.txt)
REF_OUTPUT_DIR="ref_output"

# --- Score Initialization ---
grand_total_correct=0
grand_total_possible=0

# --- Pre-run Check ---
# Ensure the ref_output directory exists before we start.
if [ ! -d "$REF_OUTPUT_DIR" ]; then
    echo "Error: Directory '$REF_OUTPUT_DIR' not found."
    echo "Please create it and add your reference .txt output files."
    exit 1
fi

# --- Helper Function to Grade a Single Exercise ---
# Usage: grade_exercise <base_filename>
# Example: grade_exercise "ex1_variables"
grade_exercise() {
    local basename="$1"
    local student_file="${basename}.py"
    local answer_file="${REF_OUTPUT_DIR}/${basename}.txt"
    
    echo "-----------------------------------------------------"
    echo "Grading: ${student_file}"

    # Check if the student's Python file exists
    if [ ! -f "$student_file" ]; then
        echo "File not found. Score: 0"
        echo "-----------------------------------------------------"
        return
    fi
    
    # The answer file is guaranteed to exist because we used it to find the exercise,
    # so no need for a separate check here.

    # Create a temporary file to store the student's output
    STUDENT_OUTPUT=$(mktemp)
    trap 'rm -f "$STUDENT_OUTPUT"' EXIT
    
    # Run the student's Python script and redirect its output.
    python3 "$student_file" > "$STUDENT_OUTPUT" 2>/dev/null

    # --- Line-by-Line Comparison ---
    local correct_lines=0
    local total_lines=0
    
    # Read the answer file line by line
    while IFS= read -r correct_line || [ -n "$correct_line" ]; do
        total_lines=$((total_lines + 1))
        
        # Get the corresponding line from the student's output file
        student_line=$(sed -n "${total_lines}p" "$STUDENT_OUTPUT")
        
        # Compare the lines
        if [ "$correct_line" = "$student_line" ]; then
            correct_lines=$((correct_lines + 1))
        fi
    done < "$answer_file"

    # Report the score for this file
    if [ "$total_lines" -gt 0 ]; then
        echo "Result: ${correct_lines} / ${total_lines} lines correct."
        # Update grand totals
        grand_total_correct=$((grand_total_correct + correct_lines))
        grand_total_possible=$((grand_total_possible + total_lines))
    else
        echo "Warning: Answer file '${answer_file}' is empty. Score: 0"
    fi
    
    echo "-----------------------------------------------------"
    rm -f "$STUDENT_OUTPUT"
    trap - EXIT
}

# --- Main Execution ---
# Dynamically find exercises to grade based on files in the ref_output directory.
exercises=()
for file in "${REF_OUTPUT_DIR}"/*.txt; do
    # This check handles the case where the directory is empty
    [ -e "$file" ] || continue
    # Get just the filename (e.g., ex1_variables.txt)
    filename_only=${file##*/}
    # Get the basename by removing the .txt suffix (e.g., ex1_variables)
    basename=${filename_only%.txt}
    exercises+=("$basename")
done

# Check if any exercises were found
if [ ${#exercises[@]} -eq 0 ]; then
    echo "No reference files (.txt) found in '$REF_OUTPUT_DIR'. Nothing to grade."
    exit 0
fi

# Call the grading function for each exercise found
for exercise in "${exercises[@]}"; do
    grade_exercise "$exercise"
done

# --- Final Report ---
echo ""
echo "====================================================="
echo "Grading Complete!"
echo ""
echo "Final Score: ${grand_total_correct} / ${grand_total_possible}"
echo "====================================================="