#!/bin/sh

# Create variables
## Variable parameters: to ajust manually
PROJ_NAME=test_mirror_s3
GITHUB_USER_MAIN=fBedecarrats
S3_USER_NAME=fbedecarrats

## Variables: 
WORK_DIR=/home/rstudio/${PROJ_NAME}
REPO_URL=https://github.com/${GITHUB_USER_MAIN}/${PROJ_NAME}
DATA_DIR=${WORK_DIR}/data
DOC_DIR=${WORK_DIR}/documentation

# Git
git clone $REPO_URL $WORK_DIR
chown -R rstudio:users $WORK_DIR

# Folders to store data and documentation
mkdir $DATA_DIR
mkdir $DOC_DIR

chown -R rstudio:users $DATA_DIR


## copy files from S3 to container
mc cp s3/${S3_USER_NAME}/diffusion/test_mirror/commune2021.csv $DATA_DIR
# mirror from container to S3
mc mirror --watch $DATA_DIR s3/${S3_USER_NAME}/diffusion/test_mirror

