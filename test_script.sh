#!/bin/bash

echo "Running tests for random_numbers.sh..."

# Test A: Check if output has exactly 10 lines
line_count=$(./random_numbers.sh | wc -l)
if [ "$line_count" -eq 10 ]; then
    echo "[PASS] Script outputs exactly 10 lines."
else
    echo "[FAIL] Expected 10 lines, got $line_count."
fi

# Test B: Check for duplicates
unique_count=$(./random_numbers.sh | sort | uniq | wc -l)
if [ "$unique_count" -eq 10 ]; then
    echo "[PASS] All numbers are unique."
else
    echo "[FAIL] Duplicate numbers found."
fi

# Test C: Check if the sum of all numbers is exactly 55
sum=$(./random_numbers.sh | awk '{s+=$1} END {print s}')
if [ "$sum" -eq 55 ]; then
    echo "[PASS] Sum of all numbers is 55."
else
    echo "[FAIL] Expected sum 55, got $sum."
fi