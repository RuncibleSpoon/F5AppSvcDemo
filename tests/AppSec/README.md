# Testing out F5 Application Secuirty Services with the OWASP JuiceShop App


## Introduction 

The [OWASP Juicebox App](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) is a well written, almost-bug free applicaiton that is chck full of vulnerabilites for you to find and expliot.  

For this test scenario you can first confugure the BIG-IP to proxy traffic to the contianer running on port 3000 on the app server, then check out a simple hack, then confugure BIG-IP to protect the application, and run the test agian. 

First, run the [AS3](http://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/) declaration using the as3.py script:

`$python ~/F5AppSvcDemo/as3.py juiceshop.json`


Now navigate to the juicshop app

http://<ipaddress of your BIG-IP install>/

