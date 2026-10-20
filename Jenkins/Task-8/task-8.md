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

![alt text](image-6.png)

![alt text](image-7.png)

![alt text](image-8.png)

![alt text](image-9.png)

![alt text](image-10.png)

![alt text](image-11.png)

![alt text](image-14.png)

![alt text](image-15.png)

### Create a job

![alt text](image-4.png)

![alt text](image-5.png)

![alt text](image-12.png)

![alt text](image-13.png)


### Output


![alt text](image-16.png)

![alt text](image-17.png)

![alt text](image-18.png)

![alt text](image-19.png)

![alt text](image-20.png)


![alt text](image-21.png)



