# Jenkins Workspaces

Some developers are working on a common repository where they are testing some features for an application. They are having three branches (excluding the master branch) in this repository where they are adding changes related to these different features. They want to test these changes on Stratos DC app servers so they need a Jenkins job using which they can deploy these different branches as per requirements. Configure a Jenkins job accordingly.



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.


Similarly, click on Gitea button to access the Gitea page. Login to Gitea server using username sarah and password Sarah_pass123.


There is a Git repository named web_app on Gitea where developers are pushing their changes. It has three branches version1, version2 and version3 (excluding the master branch). You need not to make any changes in the repository.


Create a Jenkins job named app-job.

Configure this job to have a choice parameter named Branch with choices as given below:

version1

version2

version3


Configure the job to fetch changes from above mentioned Git repository and make sure it should fetches the changes from the respective branch which you are passing as a choice in the choice parameter while building the job. For example if you choose version1 then it must fetch and deploy the changes from branch version1.

Configure this job to use custom workspace rather than a default workspace and custom workspace directory should be created under /var/lib/jenkins (for example /var/lib/jenkins/version1) location rather than under any sub-directory etc. The job should use a workspace as per the value you will pass for Branch parameter while building the job. For example if you choose version1 while building the job then it should create a workspace directory called version1 and should fetch Git repository etc within that directory only.

Configure the job to deploy code (fetched from Git repository) on App Server 1 (stapp01) under /var/www/html directory.

You can access the website by clicking on App button.

![alt text](image-1.png)

![alt text](image.png)

Search for Git. Select Gitea, SSH & Publish over SSH plugin and click Download now and install after restart

### Add credentials for Git

![alt text](image-2.png)

![alt text](image-3.png)

### Create a job

![alt text](image-4.png)

```bash
//
// Setup up the Remote connection for SSH Build Pipeline step
//
def remote = [:]
remote.name = 'ststor01'
remote.host = 'ststor01'
remote.user = 'natasha'
remote.password = 'Bl@kW'
remote.allowAnyHosts = true   
            
pipeline {
    // Run on agent with label 'ststor01'
    agent { label 'ststor01' }

    // Pipeline stages 
    stages {
        // Deploy stage
        stage('Deploy') {
            steps {
                echo 'Deploying ...'
                // Connect to GIT and download the repo code
                // Use the Jenkins Credentials by ID: GIT_CREDS
                git credentialsId: 'GIT_CREDS', url: 'http://git.stratos.xfusioncorp.com/sarah/web.git'
                // Transfer all the files we downloaded to /tmp of ststor01
                sshPut remote: remote, from: '.', into: '/tmp'
                // Finally move all the files from /tmp to /data on ststor01
                sshCommand remote: remote, command: "mv -f /tmp/${JOB_NAME}/* /data"
            }
        }

        // Test stage
        stage('Test') {
            environment {
                // Update the below value as per the text given in question
                INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
            }

            steps {
                // Now test that the content from default page from HTTPD on each 
                // of the appservers is same as the index.html content required as
                // per question
                sh '((curl http://stapp01:8080/ | grep -F "$INDEX_CONTENT") && true)'
                sh '((curl http://stapp02:8080/ | grep -F "$INDEX_CONTENT") && true)'
                sh '((curl http://stapp03:8080/ | grep -F "$INDEX_CONTENT") && true)'
            }
        }
    }
}

```

### Commit changes to index.html

SSH to ststor01 using SSH user sarah
Change to /home/sarah/web
Edit index.html as per the question


