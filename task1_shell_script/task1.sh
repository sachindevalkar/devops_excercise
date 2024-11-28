#!/bin/bash
#set -x
#set -e


json_data=`cat commit_data.json`
# Extract all commit counts and dates
# '"date": "\K[^"]+' which extracted date
# (?<="commits": )\d+ which extracts the commit count for "commits"
commits_and_dates=$(echo "$json_data" | grep -oP '"date": "\K[^"]+|(?<="commits": )\d+')

# Initialize variables for max and min values
# max_commits and min_commits are initialized to keep track of the maximum and minimum commit counts encountered in the data
#max_dates and min_dates are arrays used to store the dates corresponding to the maximum and minimum commit counts, respectively.
max_commits=0
min_commits=999999
max_dates=()
min_dates=()

# process data from file 
# While loop processes each line of commits_and_dates
# If the line is a commit count (i.e., a number), it updates the max_commits, min_commits, max_dates, and min_dates based on the current commit count.
# If the line is a date (which doesn't match the number pattern), it assigns the date to current_date.
while IFS= read -r line; do
    if [[ "$line" =~ ^[0-9]+$ ]]; then
	
        current_commits=$line
        if (( current_commits > max_commits )); then
            max_commits=$current_commits
            max_dates=("$current_date")
        elif (( current_commits == max_commits )); then
            max_dates+=("$current_date")
        fi

        if (( current_commits < min_commits )); then
            min_commits=$current_commits
            min_dates=("$current_date")
        elif (( current_commits == min_commits )); then
            min_dates+=("$current_date")
        fi
    else
        current_date=$line
    fi
done <<< "$commits_and_dates"

# Convert arrays to comma-separated strings
max_dates_str=$(IFS=,; echo "${max_dates[*]}")
min_dates_str=$(IFS=,; echo "${min_dates[*]}")




# output
echo "Maximum number of commits were made on $max_dates_str totalling to $max_commits and minimum number of commits were made on $min_dates_str totalling to $min_commits"

