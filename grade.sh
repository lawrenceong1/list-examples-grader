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
    echo '.java file not found'
    exit 1
fi

# Check that the student code compiles. If it doesn’t, detect and give helpful feedback about it. This is not done by the provided code, you should figure out where to add it
javac -cp $CPATH student-submission/ListExamples.java TestListExamples.java -d grading-area
if [ $? -ne 0 ]; then
    echo 'Compilation failed'
    exit 1
else 
    echo 'Compilation successful'
fi

echo 'Finished compiling'

# make a variable to reference the .java file name without the .java in the student-submission directory
filename=$(basename --suffix=.class grading-area/*.class)

# Run the tests and report the grade based on the JUnit output. You should add this
# Again output redirection will be useful, and also tools like grep could be helpful here
java -cp $CPATH:grading-area org.junit.runner.JUnitCore $filename > grading-area/grade.txt

#testing this to see if it updates