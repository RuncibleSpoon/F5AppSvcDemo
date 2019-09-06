# A Simple Blue Green Deployment


## Introduction 

[Blue Green deployments](https://martinfowler.com/bliki/BlueGreenDeployment.html) are a common way of getting new code into deployment. 

In this instance we have a very simple app that displays a soothing green page, and an exciting update that offers a pleasing blue.

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/blue.PNG "Blue App")

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/green.PNG "Green App")

Once the container(s) for the new version are up and running, how do we direct traffic over to the new updated visual experience? 

Do we want everyone to go there, or just start with a few connections?

How will we make sure that the new version is working correctly?

This is where an application aware proxy can really help.

## Setting up the basic app

Run the green.json AS3 declaration 

`ubuntu@util:~/F5AppSvcDemo$ python as3.py green.json` 

Now navigate to the app:

http://<ipaddress of your BIG-IP install>/

And check you have a pleasing green app. 	

## Managing Ratios and Switching Instances 


Let's start with a 90:10 ratio of green to blue:


`$python ~/F5AppSvcDemo/as3.py bleu10green90.json`


Now navigate to the app:

http://<ipaddress of your BIG-IP install>/

You're probably going to get a green screen, but you never know. Since this could get a little tiresome, we've included a handy script that runs 100 HTTP GET requests and reports the results

`./scenarios/BlueGreen/counter.sh `


![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/B10G90.PNG  "Counter script results")

If we are happy with that, we can move to 50:50 ratio

`ubuntu@util:~/F5AppSvcDemo$ python as3.py blue50green50.json`

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/B50G50.PNG  "Counter script results")

And then maybe a 90:10

`ubuntu@util:~/F5AppSvcDemo$ python as3.py blue90green10.json`

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/B90G10.PNG  "Counter script results")

## Enhancing things with a rule to control who sees the new app


All this is fine, but what if you wanted to test out your changes on your internal audience first? 

Simple - we will just create a rule that sends all external traffic to the green app:

```
when HTTP_REQUEST {
   if { ![class match [IP::client_addr] equals "private_net"] } {
   
     log local0. "Client IP:[IP::client_addr] is external so going to Green node"
   
   node 	10.1.10.100 9080
   
   } else {
   
   log local0. "Client IP:[IP::client_addr] is internal so will be load balanced"
   
   pool web_pool
   
   }
   
}

```

And attach it to your AS3 declaration as an external stored file 

```
...
 "class": "Service_HTTP",
                     "iRules": ["external_green_only"],
                     "virtualAddresses": [
                         "10.1.10.50"
                     ],
 ...
 ```

```
...
"external_green_only": {
                    "class": "iRule",
                    "iRule": {
                    "url": "https://raw.githubusercontent.com/RuncibleSpoon/F5AppSvcDemo/master/scenarios/BlueGreen/irule.tcl"
                    }  
...
```                    



`$ python ~/F5AppSvcDemo/as3.py protect_juiceshop.json`

Let's try that again

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/juiceshop4.PNG "Juiceshop App")

OK, so we also discover another hack, where the system doesn't handle errors very gracefully, but at least we have shut off this attack. 

Taking a look at the [protect_juiceshop.json](https://github.com/RuncibleSpoon/F5AppSvcDemo/blob/master/declarations/protect_juiceshop.json) declaration, you can see a couple of key differences from the simple [juiceshop.json](https://github.com/RuncibleSpoon/F5AppSvcDemo/blob/master/declarations/juiceshop.json) declaration. 

In particular the relevant lines are 

`"pool": "juice_pool",
                     "policyWAF": {
                        "use": "JuiceShopASM"
                     },`

and                      


              `   "JuiceShopASM": {
                    "class": "WAF_Policy",
                    "url": "https://raw.githubusercontent.com/RuncibleSpoon/F5AppSvcDemo/master/scenarios/AppSec/JuiceShop.xml"
                    "ignoreChanges": true
                },`

Where we define which Web Application Firewall (WAF) policy to use, and later define the [policy location](https://github.com/RuncibleSpoon/F5AppSvcDemo/blob/master/scenarios/AppSec/JuiceShop.xml). The policy is readable, but is checksummed to prevent malicious interference. 

There are probably other hacks that this policy mitigates, why not try to find a few? 



