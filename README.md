## Automation

This creates the AWS networking, and then creates a single ec2 instance to host the application, bootstrapping it via user data (for something this simple a full config management setup with ansible or chef seems overkill).

Many of these choices such as using Dockerhub for the container images, and limiting AWS permissions were made since this is a personal AWS account running primarily on the free tier, and I'd like to avoid excess charges.

### Deploying automation
```bash
# create the AWS networking
cd tf/networking 
terraform plan
terraform apply
cd ../..
# Create the server instance
cd tf/server_instance
terraform plan
terraform apply
cd ../..
```

### Future changes
For a full enterprise setup, I'd 
- set up EKS or ECS instead, which would simplify deploys and be relatively standard.
- Any server images necessary would be built via Packer as AMIs.
- Server instances would be set as autoscaling groups and would be behind a load balancer
 - I'd remove ssh access except through Session Manager
 - SSO AWS access, with the account being provisioned via Control Tower




