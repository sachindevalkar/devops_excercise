import json

# File name containing the JSON data
file_name = "commit_data.json"

# Read JSON data from the file
with open(file_name, 'r') as file:
    data = json.load(file)["commits"]

# Initialize variables to store max and min commits
# max_commits and min_commits are initialized to keep track of the maximum and minimum commit counts encountered in the data
#max_dates and min_dates are arrays used to store the dates corresponding to the maximum and minimum commit counts, respectively.
max_commits = 0
min_commits = float('inf')  # Start with infinity to find the smallest value
max_dates = []
min_dates = []

# Iterate over the list of commits to find max and min
for entry in data:
    date = entry["date"]
###    print(date)
    commits = entry["commits"]
###    print(commits)

    # Check for maximum commits
    if commits > max_commits:
        max_commits = commits
        max_dates = [date]  # Reset the list with the new maximum date
    elif commits == max_commits:
        max_dates.append(date)  # Add date if it matches the current maximum

    # Check for minimum commits
    if commits < min_commits:
        min_commits = commits
        min_dates = [date]  # Reset the list with the new minimum date
    elif commits == min_commits:
        min_dates.append(date)  # Add date if it matches the current minimum

# Convert the dates to comma-separated strings
max_dates_str = ', '.join(max_dates)
min_dates_str = ', '.join(min_dates)

# Output
print("Maximum number of commits were made on {} totalling to {} and minimum number of commits were made on {} totalling to {}.".format(
    max_dates_str, max_commits, min_dates_str, min_commits))

