# Network Monitoring Engineering Challenge

## Task 1: Random Number Generator

### Description
This project contains a pure Bash script (`random_numbers.sh`) that outputs the numbers from 1 to 10 in a random order, ensuring each number appears only once. 

To strictly stick to the "bash only" constraint, this script intentionally avoids external GNU utilities (such as `shuf`, `sort -R`, or `seq`). Instead, it uses the **Fisher-Yates shuffle algorithm** using native Bash arrays and the internal `$RANDOM` variable. Following, a test script (`test_script.sh`) is also provided to validate the script's core logic and output.

### Build Instructions
As these are interpreted Bash scripts, there is no need for compilation or traditional build process required. To prepare the scripts for execution, simply grant them the necessary permissions using:

`chmod +x random_numbers.sh test_script.sh`

### Usage
**To run the main generator:**
`./random_numbers.sh`

**To run the test:**
`./test_script.sh`

*Note: The test verifies that the output contains exactly 10 lines, contains zero duplicate numbers, and that the mathematical sum of the output is exactly 55.*

### Known Limitations / Bugs
* **Pseudo-Randomness:** The script relies on Bash's internal `$RANDOM` function. This is a pseudo-random number generator (PRNG) seeded by the system clock and the PID. While perfectly sufficient for general scripting and this specific challenge, it is not cryptographically secure.
* **Performance at Scale:** Because this implementation uses pure, built-in Bash loops and variable swapping to satisfy the tool constraints, it is meant for small data sets (like 1-10). If the requirement were to scale to millions of integers, compiled utilities (like `shuf`) would be more memory and CPU efficient.
