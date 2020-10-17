# Terraform Automated Apache Deploy 

This code runs on Terraform version 0.12

Be sure to export the aws credentials that has privileges to create the resources and set default region on `variables.tf`


## deploy-ec2

Deploys an EC2 instance under a load balancer. The EC2 Instance will have Apache installed trought bootstrapping 


## deploy-autoscaler 

Deploys an EC2 instance under a load balancer. The EC2 instance is managed by an auto scaling group thats scale in with 80% or greather of cpu utilization and scale out with 60% or less of cpu utilization.

You can use a tool like `ab` (ApacheBenchmark) to test the autoscaler. 
Eg.: 
```bash
ab -n 10000 -c 10 http://<elb_id>.<region>.elb.amazonaws.com/
```