#!/bin/bash

# Path to your calculator program
CALC="./calc"

# Define test cases
declare -A test_cases=(
    ["3 + 4"]="Result: 7"
    ["10 - 2"]="Result: 8"
    ["2 * 3"]="Result: 6"
    ["8 / 2"]="Result: 4"
    ["2 ^ 3"]="Result: 8"
    ["(1 + 2) * 3"]="Result: 9"
    ["4 + (3 - 1) * 2"]="Result: 8"
    ["-3 + 5"]="Result: 2"
    ["(2 + 3) ^ 2"]="Result: 25"
    ["2 ^ 3 ^ 2"]="Result: 512"
    ["-(6 + 2) * 3^2"]="Result: -72"

)

# Initialize counters
pass_count=0
fail_count=0

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Run each test case
for expr in "${!test_cases[@]}"; do
    expected="${test_cases[$expr]}"
    result=$(echo "$expr" | $CALC)
    
    if [ "$result" == "$expected" ]; then
        echo -e "${GREEN}PASS${NC}: $expr => $result"
        ((pass_count++))
    else
        echo -e "${RED}FAIL${NC}: $expr => Expected: $expected, Got: $result"
        ((fail_count++))
    fi
done

# Print summary
echo -e "\nSummary:"
echo -e "${GREEN}Passed: $pass_count${NC}"
echo -e "${RED}Failed: $fail_count${NC}"
