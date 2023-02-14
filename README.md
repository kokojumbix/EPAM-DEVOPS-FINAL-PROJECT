## Localhorse web site. Picture storage from browser. - Final Project EPAM DevOps.

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

2.2) Creating Web-Service instance:

2.2.1) Creating auto-scaling structure for Production and for Test.

2.3) Creating instance, from which all will be controlled. (Jenkins Master, Terraform)
```


