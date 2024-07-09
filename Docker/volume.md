
**attach volume to container**
```
[ec2-user@ip-172-31-37-118 ~]$ docker run -itd --name cont2  --mount source=ebs,target=/app ubuntu:latest
````
