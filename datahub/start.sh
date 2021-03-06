echo $1
if [ $1 == "aws" ]
then
    docker run -d \
        -p 7000:7000 \
        -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
        -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
        -e secret='b9c8e5acc65e88f817ec58d94b9664cba1385a77a1a63c1e8fa8cd5e5c5852c2' \
        -e algorithm="HS256" \
        --env-file env_var \
        -v "$(pwd)":/app \
        --link synapse-core:synapse-core \
        --link synapse-postgres:synapse-postgres \
        --network synapse-bridge \
        --name synapse-datahub synapse-datahub
elif [ $1 == "gcp" ]
then
    docker run -d \
        -p 7000:7000 \
        -e GOOGLE_APPLICATION_CREDENTIALS="/app/data/google_credential.json" \
        -e secret='b9c8e5acc65e88f817ec58d94b9664cba1385a77a1a63c1e8fa8cd5e5c5852c2' \
        -e algorithm="HS256" \
        --env-file env_var \
        -v "$(pwd)":/app \
        -v ${GOOGLE_APPLICATION_CREDENTIALS}:/app/data/google_credential.json \
        --link synapse-core:synapse-core \
        --link synapse-postgres:synapse-postgres \
        --network synapse-bridge \
        --name synapse-datahub synapse-datahub
else
    echo "Cloud platform provided is neither aws or gcp"
fi