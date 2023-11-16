# exam repository
JenkinsCreateFile:
With this file we build the jenkins container , using the following command:
sudo docker run -d --name jenkinsV1 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkinschen

Nginx:
Create ssl directory under the folder: /home/ec2-user/myapp/nginx/conf.d/ssl

Create ssl certificate , using the commands:
user_home=$(eval echo ~$USER)
ssl_dir="$user_home/myapp/nginx/conf.d/ssl"
config_dir="$user_home/myapp/nginx/conf.d"
mkdir -p ${ssl_dir}
mkdir -p ${config_dir}
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ${ssl_dir}/nginx.key -out ${ssl_dir}/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=example.com"

cat << EOF > ${config_dir}/nginx.conf
erver {
    listen 443 ssl;
    server_name chen-jenkins;

    ssl_certificate /etc/nginx/conf.d/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/conf.d/ssl/nginx.key;

    location / {
        proxy_pass http://${ip}:8080;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        client_max_body_size 100M;  # Adjust as needed
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_ssl_session_reuse off;
        proxy_read_timeout 1200;
        proxy_connect_timeout 1200;
        proxy_send_timeout 1200;
        proxy_set_header Origin '';
    }
}
EOF
#replace the {ip} witht the internal IP , for example for : 10.0.1.179

sudo docker run --name docker-nginxchen -p 443:443 -d -v /home/ec2-user/myapp/nginx/conf.d/:/etc/nginx/conf.d/ nginx
