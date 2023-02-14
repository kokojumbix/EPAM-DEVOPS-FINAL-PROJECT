
## Localhorse web site. Picture storage in browser. - Final Project EPAM DevOps.
<h5>Created by Markiian Chorniy</h5>


<h1> Description of project: </h1>

<h2> 1. Motivation.</h2>

For a long time i have the idea of creating my own site for storing images.
And this is a really interesting task, especially in using microservices architecture

<br>
<h2> 2. Actuality. </h2>

Yes, services like this is not something new, examples: imgur, google drive, dropbox. Main reason why i chosen this one,
is that it will be nice basement to create some social networks, forum.

<br>
<h2> 3. Goal. </h2>

Provide storage of photos, with storage beyond the capacity of local devices. 
If to say more specifically, from business side, it is to create structure, that will be easy to scale, modify.

<br>
<h2> 4. Tasks. </h2>
  
At first sight it easy. Tasks that need to be solved:
```  
1) Web Application. (Developer side)
```
```
2) Deploy application to cloud infrastructure. (DevOps side):
  
  2.1) Creating RDB instance (Service of cloud or manual setting on the machine).

  2.2) Creating Web-Service instances:

      2.2.1) Creating auto-scaling structure for Production and for Test.

  2.3) Creating instance, from which all will be controlled, deployed program. (Jenkins Master, Terraform)
```

<br>
<h2> 5. Projecting. </h2>

Technologies what will be used:
```
1) DBMS - mysql.

For saving account information and image access-url is needed relational database. 
From all DBMS most simple is mysql, also it has free tier type.

  1.1) AWS RDS.

  AWS RDS is most optimal choise for growing projects. 
  As it is PaaS, another specialists are not needed to manage hardware, 
  and scaling will be much easier.
```

```
2) AWS.

Cloud services in AWS are incredibly large and can be used in all situations.
But it not the reason why this one was chosen, 
because other cloud providers like Azure or GCP give us also that possibilities 
for such small project.
Main reason is in the prevelance, so most of new DevOps engineers will be able to work with it.

```

```
3) Terraform.

Nice IaaC opensource tool, that can be used in the majority of Cloud Providers. So if this project
will use some services from another cloud providers, it can be easy adapted to new cloud.
```

```
4) Jenkins.

Used instead of AWS CodeDeploy in forward thinking, if in project will be used something not from AWS.
```

```
5) ASP .Net


Framework was used because "developer" has the greatest experience in it for developing web applications.
```

<h2> 6. Realization. </h2>

Suggested structure:

![Project-Structure](https://user-images.githubusercontent.com/113692759/218842459-7035f90e-65b0-458c-9b47-d92fd7c662c0.png)




1) Creating RDS and connecting it to local web application.

![image](https://user-images.githubusercontent.com/113692759/218836217-d08d8e61-47f2-4ee7-bbd7-e8fc2a2e72e9.png)

2) Creating EC2 instance for Jenkins Master.

3) Creating Terraform file to build infrastructure:

For better security was created shell script that declares AWS Credentials.

![image](https://user-images.githubusercontent.com/113692759/218838228-eb7b5249-8919-442f-b014-07931cd1bde5.png)






















