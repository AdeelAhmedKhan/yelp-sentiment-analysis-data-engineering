import json

input_file = "yelp_academic_dataset_review.json"  # Your 5GB JSON file
output_prefix = "split_file_"  # Prefix for output files
num_files = 20  # Number of files to split into

# Step 1: Count total lines (each line is a JSON object)
with open(input_file, "r", encoding="utf8") as f:
    total_lines = sum(1 for _ in f)

lines_per_file = total_lines // num_files
remaining_lines = total_lines % num_files

print(f"Total lines: {total_lines}, Lines per file: {lines_per_file}, Remaining: {remaining_lines}")

# Step 2: Split into multiple smaller files
with open(input_file, "r", encoding="utf8") as f:
    for i in range(num_files):
        output_filename = f"{output_prefix}{i+1}.json"

        # Add one extra line to the first 'remaining_lines' files
        current_file_lines = lines_per_file + (1 if i < remaining_lines else 0)

        with open(output_filename, "w", encoding="utf8") as out_file:
            for _ in range(current_file_lines):
                line = f.readline()
                if not line:
                    break
                out_file.write(line)

print("✅ JSON file successfully split into smaller parts!")
