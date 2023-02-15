
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

3.1 Apply

![image](https://user-images.githubusercontent.com/113692759/218838228-eb7b5249-8919-442f-b014-07931cd1bde5.png)

For better security was created shell script that declares AWS Credentials.

3.2

In this stage was created script to create vpc, subnets, autoscaling groups (1 EC2 instance per group).

![image](https://user-images.githubusercontent.com/113692759/218847117-ed76f121-8fc3-4b9e-8931-840bcdae764e.png)

3.3

Added to script creating of Load Balancer.

![image](https://user-images.githubusercontent.com/113692759/218858889-9ea5afeb-15c3-446b-98d9-ce6f3d6dfdeb.png)

3.4 


4) (Temp) Created manualy global accelerator

5) Installed AWS EC2 Fleet. Connected Autoscaling groups.

![image](https://user-images.githubusercontent.com/113692759/218861373-014a7d0f-4b42-4bd9-bdbc-5ff005f14f30.png)


![image](https://user-images.githubusercontent.com/113692759/218863596-cafa1ac9-5e57-4495-a57e-a5d9b72a97ee.png)

----------
Will be replaced
 |
\ /

![image](https://user-images.githubusercontent.com/113692759/218879615-807ec7bf-6ca8-4825-8c0f-57d7f1bfa3d1.png)

6) Jenkins job to deploy project in docker container

![image](https://user-images.githubusercontent.com/113692759/218879753-d20faf5f-9f78-4aef-987a-44b4677648a9.png)

![image](https://user-images.githubusercontent.com/113692759/218879829-2fec1556-12a8-4d83-8817-bdd317138d9b.png)

7) Attached Domain Name to public ip:

localhorse.space


<h2> 7. Demonstration </h2>

![image](https://user-images.githubusercontent.com/113692759/218972959-524be09d-aa6a-45e5-b06d-b14b80d78ac5.png)



<h2> 8.  </h2>




