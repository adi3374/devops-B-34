**Httpd Script**
```sh
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "hello apache" >/var/www/html/index.html
```
