# exam repository
Jenkins URL: https://3.218.247.223/
User/pass: adminuser/chenbe



Build the work env using terraform (if you need environment wo work on):
copy the files , and run:
terraform init
terraform plan
terraform apply -auto-approve


JenkinsCreateFile:
With this file we build the jenkins container , using the following command:
sudo docker build -t jenkinschen -f JenkinsCreateFile .
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


Web Service:
Dockerfile - To build the image 
counter-service.py   - the python script which we nned to run as part of the image
Jenkinsfile - The file we need to use in the jenkins job , we also need to define the Extended Choice Parameter manually(Groovy Script):
def getBranches() {
    def stdout = new ByteArrayOutputStream()
    def stderr = new ByteArrayOutputStream()
    def cmd = "git ls-remote --heads git@github.com:chenbe/exam.git"
    def proc = cmd.execute()
    proc.consumeProcessOutput(stdout, stderr)
    proc.waitForOrKill(10000) // wait max 10 seconds
    if(proc.exitValue() != 0) {
        return ["Error: ${stderr.toString().trim()}"]
    }
    return stdout.toString().trim().split("\n").collect { it.split()[1].replaceAll('refs/heads/', '') }
}
return getBranches()


Action Items for improvments:
* Change the BRANCH_NAME instead of Extended Choice Parameter to run in a better way (security issue)
* EXTERNAL_IP - Add the option to work with localhost , than we can delete the parameter
