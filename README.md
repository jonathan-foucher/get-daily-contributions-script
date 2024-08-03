# Introduction
A shell script using gh and jq cli tools to get the daily GitHub contributions of the GitHub cli user.
The results contains every day of every years from the user account creation to the current year.

# Requirements
gh and jq must be installed

# Run the script
Run the script and save the results in a file named `daily-contributions.json`
```
sh get-daily-contributions.sh > daily-contributions.json
```

Results format
```
[
  ...,
  { "date": "2024-08-01", "contribution_count": 7 },
  { "date": "2024-08-02", "contribution_count": 12 },
  { "date": "2024-08-03", "contribution_count": 9 },
  ...
]
```
