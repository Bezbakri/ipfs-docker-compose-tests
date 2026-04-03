#! /bin/bash

auth="--basic --user username:password"
docker_api="docker compose exec api"
cluster0=cluster0:9094
test_input=testfile_in.txt
test_output=testfile_out.txt


# 401 error
$docker_api curl -X GET $cluster0/version
# No 401 error
#echo "$docker_api curl -X GET $cluster0/version $auth"
$docker_api curl -X GET $cluster0/version $auth

# Create a file for testing
$docker_api /bin/sh -c "echo testing from bash file > $test_input"
# Add the file and get the CID
cid=$($docker_api curl -F file1=@$test_input $cluster0/add $auth | grep -Po '("cid":")[^"]*' | sed -n 's/"cid":"//p')
echo $cid
# Get the file back
# For a password protection to this, we could use nginx
$docker_api curl "http://ipfs0:8080/ipfs/$cid" -o $test_output
# Print out the contents of the file to verify that everything worked
$docker_api echo Printing out contents of $test_output
$docker_api cat $test_output
$docker_api echo -e "Done\n"