# Testing out F5 Application Secuirty Services with the OWASP JuiceShop App


## Introduction 

The [OWASP Juicebox App](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) is a well written, almost-bug free applicaiton that is chck full of vulnerabilites for you to find and expliot.  

For this test scenario you can first confugure the BIG-IP to proxy traffic to the contianer running on port 3000 on the app server, then check out a simple hack, then confugure BIG-IP to protect the application, and run the test agian. 

First, run the [AS3](http://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/) declaration using the as3.py script:

`$python ~/F5AppSvcDemo/as3.py juiceshop.json`


Now navigate to the juicshop app

http://<ipaddress of your BIG-IP install>/

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/juiceshop1.jpg "Juiceshop App" )

We're going to try a simple SQL injection atack on the auth system - this is described by IncognitJoe in an [excellent doument](https://incognitjoe.github.io/hacking-the-juice-shop.html) that can run you through a lot fo the Juiceshop attacks.

Click the logn link and use the email address of "'or 1==1" --  This is classic SQLi stuff

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/juiceshop2.png  "Juiceshop App" )

Suddenly we've unlocked a challaenge and are logged in as admin (user id 1). 

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/juiceshop3.png  " HackedJuiceshop App" )

Of course we should go and fix the code, but maybe spending 30 seconds to protect the app while we do it makes sense?


`$ python ~/F5AppSvcDemo/as3.py protect_juiceshop.json`

Let's try that again

![alt text](https://github.com/RuncibleSpoon/F5AppSvcDemo/raw/master/images/juiceshop4.png "Juiceshop App" )

OK, so we also dicsover another hack, where the stystem doesn't handle errors very gracefully, but at least we have shut off this attack. 



