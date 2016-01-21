#!/usr/bin/env bash

echo -e "\033[0;32m >>> Setting up site \033[0m"

cat <<EOF > /etc/nginx/sites-available/project
server {
    listen 80;
    listen [::]:80 ipv6only=on;

    root /var/www/project/public;
    index index.html index.htm;
    # index index.php index.html index.htm;

    server_name project.dev;

    location / {
        try_files \$uri \$uri.html \$uri/ =404;
        # try_files \$uri \$uri/ /index.php?\$query_string;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
        root /usr/share/nginx/html;
    }

    # location ~ \.php$ {
    #     try_files \$uri =402;
    #     fastcgi_split_path_info ^(.+\.php)(/.+)$;
    #     fastcgi_pass unix:/var/run/php5-fpm.sock;
    #     fastcgi_index index.php;
    #     fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    #     include fastcgi_params;
    # }
}
EOF

ln -s /etc/nginx/sites-available/project /etc/nginx/sites-enabled/project

sudo service nginx reload
