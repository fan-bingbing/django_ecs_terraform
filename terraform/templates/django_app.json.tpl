[
  {
    "name": "django-app",
    "image": "${docker_image_url_django}",
    "essential": true,
    "cpu": 10,
    "memory": 512,
    "links": [],
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],
    "command": ["gunicorn", "-w", "3", "-b", ":8000", "django_project.wsgi:application"],
    "environment": [
      {
        "name": "SECRET_KEY",
        "value": "exhlfdat&vfum(-34*c2uroi(($ww(yo$9pv98=e6p^gl(-eoj"
      },
      {
        "name": "DJANGO_ALLOWED_HOSTS",
        "value": "*"
      },
      {
        "name": "EMAIL_USER",
        "value": "${email_name}"
      },
      {
        "name": "EMAIL_PASS",
        "value": "${email_pw}"
      },
      {
        "name": "RDS_DB_NAME",
        "value": "${rds_db_name}"
      },
      {
        "name": "RDS_USERNAME",
        "value": "${rds_username}"
      },
      {
        "name": "RDS_PASSWORD",
        "value": "${rds_password}"
      },
      {
        "name": "RDS_HOSTNAME",
        "value": "${rds_hostname}"
      },
      {
        "name": "RDS_PORT",
        "value": "5432"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/usr/src/django_project/staticfiles/",
        "sourceVolume": "static_volume"
      },
      {
        "containerPath": "/usr/src/django_project/media",
        "sourceVolume": "media_volume"
      }

    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/django-app",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "django-app-log-stream"
      }
    }
  },
  {
    "name": "nginx",
    "image": "${docker_image_url_nginx}",
    "essential": true,
    "cpu": 10,
    "memory": 128,
    "links": ["django-app"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/usr/src/django_project/staticfiles/",
        "sourceVolume": "static_volume"
      },
      {
        "containerPath": "/usr/src/django_project/media/",
        "sourceVolume": "media_volume"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/nginx",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "nginx-log-stream"
      }
    }
  }
]