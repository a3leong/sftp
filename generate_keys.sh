# Test for one file existing and assume rest are there
FILE=$PWD/keys/ssh_host_ed25519_key
echo $FILE
echo "Checking that $FILE exists"
if [ ! -f "$FILE" ]
then
    echo "Generating keys"
    mkdir keys
    cd keys
    ssh-keygen -t ed25519 -P "" -f ssh_host_ed25519_key < /dev/null &&
    ssh-keygen -t rsa -P "" -b 4096 -f ssh_host_rsa_key < /dev/null
else
    echo "Keys already found, building docker file using pre-existing keys"
fi