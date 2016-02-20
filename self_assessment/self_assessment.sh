#!/bin/sh

if [ "$#" -ne 1 ]
then
	echo "Error, must supply a URL as an argument to test. Please use the URL that you will submit to the homework submission system"
	echo "Usage: $0 <URL>"
	exit 1
fi

URL=$1

echo "Running first test case"
echo "python TestCorrectUserForms.py $URL"

python TestCorrectUserForms.py "$URL"
rc=$?

if [ $rc -ne 0 ]
then
	echo "Error: First test case failed, which means the other test cases are very likely to fail"
	exit 1
fi

echo "Running second test case"
echo "python TestCorrectUserLogic.py $URL"
python TestCorrectUserLogic.py "$URL"
rc=$?

if [ $rc -ne 0 ]
then
	echo "Error: Second test case failed, which means the other test cases are very likely to fail"
	exit 1
fi

echo "Running third test case"
echo "python TestCorrectMessagesForms.py $URL"
python TestCorrectMessagesForms.py "$URL"
rc=$?

if [ $rc -ne 0 ]
then
	echo "Error: Third test case failed, which means that fourth test will likely fail"
	exit 1
fi

echo "Running forth test case"
echo "python TestCorrectUserAndMessageLogic.py $URL"
python TestCorrectUserAndMessageLogic.py "$URL"
rc=$?

if [ $rc -ne 0 ]
then
	echo "Error: Fourth test case failed, which means that the secret tests will likely fail"
	exit 1
fi


echo "Great Success! This basic test is 50% of the grade, the rest will come from correctly implementing the assignment functionality"
