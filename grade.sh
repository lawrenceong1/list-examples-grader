CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# Check that the student code has the correct file submitted. If they didn’t, detect and give helpful feedback about it. This is not done by the provided code, you should figure out where to add it
# Useful tools here are if and -e/-f. You can use the exit command to quit a bash script early. These are summarized in the week 6 Monday lecture handout and podcast

if [ ! -f student-submission/*.java ]; then
    echo 'Grade: 0/4. File not found.'
    exit 1
fi

# Check that the student code compiles. If it doesn’t, detect and give helpful feedback about it. This is not done by the provided code, you should figure out where to add it
javac -cp $CPATH student-submission/ListExamples.java TestListExamples.java -d grading-area 2> grading-area/compile.txt
if [ $? -ne 0 ]; then
    echo 'Compilation failed'
    echo ''
    cat grading-area/compile.txt
    echo ''
    echo 'Grade: 1/5. File is found but does not compile.'
    exit 1
else 
    echo 'Compilation successful.'
fi

# Run the tests and save the results to a file
java -cp "$CPATH:grading-area" org.junit.runner.JUnitCore TestListExamples > grading-area/result.txt

# Check if all tests passed.
success=$(grep -o "OK" grading-area/result.txt)
if [ $success == "OK" ]
then
    echo "Grade: 5/5. All tests passed."
    exit 0
fi


## If not all tests passed, then we need to calculate the score.

# Extract the line with the total number of tests run from the result file
total_tests_line=$(grep "run: [0-9]*" grading-area/result.txt)

# Extract the number from the grep output
total_tests=$(echo $total_tests_line | awk '{ print $3 }')

# Extract the line with the number of failed tests from the result file
failed_tests_line=$(grep "Failures: [0-9]*" grading-area/result.txt)

# Extract the number from the grep output
failed_tests=$(echo $failed_tests_line | awk '{ print $2 }')

# Calculate the score by subtracting the number of failed tests from the total
score=$((total_tests - failed_tests))

# Print the score
echo ""
echo "Grade: $score/$total_tests"