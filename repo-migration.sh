#!/bin/bash

# i.e.) bash repo-migration.sh user_name ***********
USER=$1 # Get github username as an input. 
PAT=$2 # Get token as an input. 

OLD_ORG_NAME="old_org_name"
NEW_ORG_NAME="new_org_name"
REPO_NAME_LIST="repository_name_1 repositoy_name 2" 
# Assign Repo List to Migrate. Do not use comma.

for REPO_NAME in ${REPO_NAME_LIST}
do
    echo "Current Repository: ${REPO_NAME}"

    # Get Old Repository About Section Data
    DESCRIPTION=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${OLD_ORG_NAME}/${REPO_NAME} | grep description | sed 's/^ *//' | tr -d ",")
    TOPICS=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${OLD_ORG_NAME}/${REPO_NAME}/topics | tr -d "[:space:]")

    # Create New Repository
    curl -X POST -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/${NEW_ORG_NAME}/repos -d "{\"name\": \"${REPO_NAME}\", ${DESCRIPTION}}" -u "$USER:${PAT}"

    # Replace New Repository Topics with Old Repository Topics
    curl -X PUT -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${NEW_ORG_NAME}/${REPO_NAME}/topics -d "${TOPICS}" -u "${USER}:${PAT}"

    # Create a bare clone of the repository
    git clone --bare https://github.com/${OLD_ORG_NAME}/${REPO_NAME}.git

    # Mirror-push to the new repository
    cd ${REPO_NAME}.git
    git push --mirror https://github.com/${NEW_ORG_NAME}/${REPO_NAME}.git

    # Remove the temporary local repository you created earlier
    cd ..
    rm -rf ${REPO_NAME}.git

done