#! /bin/bash

auth="--basic --user username:password"
docker_api="docker compose exec api"
cluster0=cluster0:9094
test_input=testfile_in.txt
test_output=testfile_out.txt


# 401 error
echo -e "\nAttempt to use the API without auth:"
$docker_api curl -X GET $cluster0/version
# No 401 error
#echo "\n$docker_api curl -X GET $cluster0/version $auth"
echo -e "\nUse the API with auth:"
$docker_api curl -X GET $cluster0/version $auth

# Create a file for testing
$docker_api /bin/sh -c "echo testing from bash file > $test_input"
echo -e "\nCreated test text file with contents:"
$docker_api cat $test_input
# Add the file and get the CID
cid=$($docker_api curl --silent -F file1=@$test_input $cluster0/add $auth | grep -Po '("cid":")[^"]*' | sed -n 's/"cid":"//p')
echo -e "\nContent ID of uploaded file:"
echo $cid
# Get the file back
# For a password protection to this, we could use nginx
echo -e "\nDownload the file by content ID (CID)."
$docker_api curl "http://ipfs0:8080/ipfs/$cid" -o $test_output --silent
# Print out the contents of the file to verify that everything worked
echo -e "\nPrinting out contents of $test_output"
$docker_api cat $test_output
echo -e "\nDone"
