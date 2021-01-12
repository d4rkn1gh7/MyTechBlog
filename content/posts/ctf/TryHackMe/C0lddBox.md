+++ 
draft = false
date = 2021-01-12T14:04:07+05:30
title = "ColddBox TryHackMe Writeup"
description = "This is the writeup of ColddBox. This one is a easy box"
slug = ""
authors = ["d4rkn1gh7"]
tags = ["ctf","tryhackme","easy_box"]
categories = ["TryHackMe"]
externalLink = ""
series = ["TryHackMe"]
+++
# ColddBox TryHackme Walkthrough

![](/TryHackMe/c0lddbox/BoxImage.png)

###           __First Stage : Enumeration__


Nmap Scan shows port 80 and 4512 open.

![](/TryHackMe/c0lddbox/Nmapscan.png)


Now lets visit the site on port 80.

![](/TryHackMe/c0lddbox/website1.png)





Also we can see a comment in the post.


![](/TryHackMe/TryHackMe/c0lddbox/website2.png)


Since the website is wordpress website we should use wpscan to enumerate.

>wpscan --url http://\<ip>

![](/TryHackMe/TryHackMe/c0lddbox/wpscan1.png)


__So the wordpress theme is twentyfifteen.__

Lets see if we can enumerate some usernames with wpscan

> wpscan --url http://\<ip> -e u

![](/TryHackMe/TryHackMe/c0lddbox/wpscan2.png)

So the usernames we found are :

* the cold in person
* hugo
* c0ldd
* philip

Hence our only way in is bruteforce I guess


###   __Second Stage : BruteForce__




So lets bruteforce with wpscan itself

>wpscan --url http://\<ip> --usernames c0ldd -P /usr/share/wordlists/rockyou.txt




![](/TryHackMe/TryHackMe/c0lddbox/wpscan3.png)


So we have username and password lets login and change the 404.php of the theme and get a reverse shell.


![](/TryHackMe/TryHackMe/c0lddbox/worpress.png)

Use this command to access the reverse shell

>curl http://\<ip>/wp-content/themes/twentyfifteen/404.php

So we are inside  as www-data

![](/TryHackMe/c0lddbox/www-data.png)

To upgrade the shell use following commands

```bash
   python3 -c"import pty;pty.spawn('/bin/bash')"
   #then press Ctrl-Z to suspend 
   stty raw -echo ; fg
   #then press enter two times
   export TERM=screen
```


### __Third Stage : Second level enumeration__ 


So we can run *linpeas* to enumerate

And as we go and read the results of enumeration we see this.

![](/TryHackMe/c0lddbox/linpeas.png)


So lets ssh into the machine

We can see the user flag.

![](/TryHackMe/c0lddbox/user.png)


### Fourth Stage : Privilege Escalation


So lets try 

> sudo -l

to see what privileges we have .


![](/TryHackMe/c0lddbox/priveleges.png)


So if we search in [GTFOBins](https://gtfobins.github.io/) and search for vim we get to see this .

![](/TryHackMe/c0lddbox/gtfobins.png)

I am gonna use option b and get shell


And finally we get a shell .


![](/TryHackMe/c0lddbox/root.png)



