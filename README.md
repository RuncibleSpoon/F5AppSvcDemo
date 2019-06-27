# A Simple F5 Application Services Demo Environment in AWS


## Introduction

This is a beta version of a new cloud-based demo environment that will set up a VPC within AWS (more clouds to follow) contianing an Ubuntu Linux client instance (the Utility Server), an F5 BIG-IP, and Ubuntu Linux server EC2 instance. 

The deployment is done using [AWS Cloudformation](https://aws.amazon.com/cloudformation/) using the supplied cloudofrmation template. 

The client and server insances run [Docker](https://www.docker.com/) community edition and come laded with some tools and test scenarios to enable you to try out various application serivces like Web Applicaiton firewalls.  

All configuration of the BIG-IP is done via [AS3](http://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/) launched from a simple Python script - no BIG-IP admin experience  required.

This repostitory is cloned onto the client, but AS3 declarations are pulled form the master branch each time the script is run - allowing for rapid update cycles. 

## Requirements 

You will need: 

1) An AWS account and the knowledge to operate it 
2) An AWS S3 bucket to put the AWS 
3) Ideally API access to AWS - this lab is primarily designed to be started from the CLI
4) Patience - this is an early beta with more work to do!

## Some improtant notes 

There are a couple of important things to know

1) This lab is not built to best practices for production security. In particular you are asked to supply a key pair for use in the demo - this should be disposable (you will stil need to specify a standard AWS key pair for remote acces )

2) This lab is only us-west-1 in this version. The templates will be updated to be multi-region ASAP


## Documentation

See below for instructions for starting the lab and running your frst declaration
Each sample test will come with instructions and explanations

### Starting the Lab



Required Parameters: 

This lab is designed to be as turnkey as possible, with only a couple of mandatory paramters:

KeyName: the name of the AWS keypair you need to 
S3Bucket: The s3 bucket location
DemoPrivateKey, DemoPublicKey: Dispossable SSH public and pivake eys 

###Steps

1) Create an S3 bucket - and give it public access attributes 
2) Upload the templates from the teemplates directory into the bucket
3) Create a disposable ssh key pair and  save the private key sd id_rsa, and the public key as key.pub (this is very bad practice, but just about OK for this demo)
4) Launch the Lab - tool of your choce - this lab was devloepd using Windows PowerShell for AWS - but you can use the any method you like. An exmaple Script to launch the lab form powershell is supplied.
5) Get the access details - the parent template outputs the IP addresses for the Utility Server, the BIG-IP and the App server.
6) Login and explore the test scenarios. 






## Filing Issues and Getting Help
If you come across a bug or other issue when using AS3, use [GitHub Issues](https://github.com/\]issues) to submit an issue for our team.  You can also see the current known issues on that page, which are tagged with a purple Known Issue label.  

Because AS3 is has been created and fully tested by F5 Networks, it is fully supported by F5. This means you can get assistance if necessary from [F5 Technical Support](https://support.f5.com/csp/article/K25327565).  

Be sure to see the [Support page](SUPPORT.md) in this repo for more details and supported versions of AS3.  

**Community Help**  
We encourage you to use our [Slack channel](https://f5cloudsolutions.herokuapp.com) for discussion and assistance on AS3 templates (click the **f5-appsvcs-extension** channel). There are F5 employees who are members of this community who typically monitor the channel Monday-Friday 9-5 PST and will offer best-effort assistance. This slack channel community support should **not** be considered a substitute for F5 Technical Support. See the [Slack Channel Statement](slack-channel-statement.md) for guidelines on using this channel.


## Copyrightf

Copyright 2014-2019 F5 Networks Inc.


### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).  

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects. Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.  

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.   

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein. You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA. 


