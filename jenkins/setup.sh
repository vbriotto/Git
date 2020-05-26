#!/bin/sh

#docker-compose up -d 

cp ~/.ssh/id_rsa.pub /project/git-server/keys

keys=$(docker exec -it jenkins cat ~/.ssh/id_rsa.pub)

docker exec jenkins /bin/bash -c "chmod 700 /root/.ssh"

docker exec jenkins /bin/bash -c "chmod 600 /root/.ssh/*"

docker exec jenkins /bin/bash -c "rm -rf /var/jenkins_home/init.groovy.d/default-user.groovy"

docker exec jenkins /bin/bash -c "rm -rf /var/jenkins_home/init.groovy.d/pipeline-create.groovy"

docker exec jenkins /bin/bash -c " ssh-keyscan -p 2222 $1 >> ~/.ssh/known_hosts"

docker-compose restart git-server 

docker exec  git-server sh -c "echo $keys >> /home/git/.ssh/authorized_keys"

docker exec  git-server sh -c "chmod 700 /home/git/.ssh"

docker exec  git-server sh -c "chmod 600 /home/git/.ssh/*"


