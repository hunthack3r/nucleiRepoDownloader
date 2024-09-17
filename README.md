# Repository Cloner

This script allows you to clone multiple repositories listed in a text file. The script takes a text file as input, which contains the URLs of the repositories to be cloned, and attempts to clone each repository. If the cloning process takes more than 30 seconds, it moves on to the next repository.

## Prerequisites

- **Git**: Make sure you have Git installed on your system.
- **Bash Shell**: This script is intended to run in a Unix-like environment with Bash shell support (Linux, macOS, or WSL on Windows).

## Usage

1. **Clone this repository** or download the `clone_repos_interactive.sh` script to your local machine.

2. **Make the script executable**:

   ```bash
   chmod +x clone_repos_interactive.sh
   ```

Run the script:
```bash
./clone_repos_interactive.sh
```

## Example File Format
Create a text file (e.g., repos.txt) with the following format, where each line represents a repository URL:
```
https://github.com/user/repo1.git
https://github.com/user/repo2.git
https://github.com/user/repo3.git
```

## Script Details
Here is the clone_repos_interactive.sh script:
```bash
#!/bin/bash

# Prompt the user for the file name
read -e -p "Enter the name of the file containing the list of repositories: " filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found. Please enter a valid file name."
    exit 1
fi

# Read each line of the file
while IFS= read -r repo; do
    # Print the repository being cloned
    echo "Cloning $repo..."
    
    # Try to clone with a timeout of 30 seconds
    timeout 30s git clone "$repo"

    # Check for failure
    if [ $? -ne 0 ]; then
        echo "Failed to clone $repo, moving to the next one."
    else
        echo "$repo cloned successfully."
    fi

done < "$filename"

```

## Additional Notes
The script uses the timeout command to limit the cloning process to 30 seconds for each repository.
If the cloning fails or exceeds the time limit, the script will continue with the next repository in the list.
The script takes advantage of Bash's read `-e` for interactive input, allowing you to use the `TAB` key for file name completion.
