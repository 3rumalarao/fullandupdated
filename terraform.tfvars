aws_region = "us-east-1"
env        = "dev"         # Use "prod" in production
orgname    = "sap"
vpc_id     = "vpc-12345678"

private_subnets  = ["subnet-aaa111", "subnet-bbb222", "subnet-ccc333"]
public_subnets   = ["subnet-ddd444", "subnet-eee555", "subnet-fff666"]

private_servers = {
  metrics = {
    ami             = "ami-metrics"
    instance_type   = "m5.xlarge"
    subnet_index    = 0
    key_name        = "private-instance"
    security_groups = ["dev-sap-metrics-sg"]
  },
  ems = {
    ami             = "ami-ems"
    instance_type   = "t3.large"
    subnet_index    = 1
    key_name        = "private-instance"
    security_groups = ["dev-sap-ems-sg"]
  },
  merger = {
    ami             = "ami-45373"
    instance_type   = "t2.large"
    subnet_index    = 2
    key_name        = "private-instance"
    security_groups = ["dev-sap-merger-sg"]
  },
  csmerge = {
    ami             = "ami-csmerge"
    instance_type   = "r5.large"
    subnet_index    = 0
    key_name        = "private-instance"
    security_groups = ["dev-sap-csmerge-sg"]
  },
  mysql = {
    ami             = "ami-mysql"
    instance_type   = "r5.4xlarge"
    subnet_index    = 1
    key_name        = "private-instance"
    security_groups = ["dev-sap-mysql-sg"]
  },
  postgresql = {
    ami             = "ami-postgres"
    instance_type   = "r5.4xlarge"
    subnet_index    = 2
    key_name        = "private-instance"
    security_groups = ["dev-sap-postgresql-sg"]
  }
}

public_servers = {
  regcom = {
    ami             = "ami-regcom"
    instance_type   = "m5.xlarge"
    subnet_index    = 0
    key_name        = "private-instance"
    allocate_eip    = true
    security_groups = ["dev-sap-regcom-sg"]
  },
  ercot = {
    ami             = "ami-ercot"
    instance_type   = "m5.xlarge"
    subnet_index    = 1
    key_name        = "private-instance"
    allocate_eip    = true
    security_groups = ["dev-sap-ercot-sg"]
  }
}

efs = {
  name          = "dev-sap-efs"
  mount_targets = [
    { az = "us-east-1a", subnet_index = 0 },
    { az = "us-east-1b", subnet_index = 1 },
    { az = "us-east-1d", subnet_index = 2 }
  ]
}

application_servers = {
  crm = {
    instances = {
      crm1 = {
        ami             = "ami-565732"
        instance_type   = "m5.xlarge"
        subnet_index    = 0
        key_name        = "private-instance"
        az              = "us-east-1a"
        security_groups = ["dev-sap-crm-sg"]
      },
      crm2 = {
        ami             = "ami-565732"
        instance_type   = "m5.xlarge"
        subnet_index    = 1
        key_name        = "private-instance"
        az              = "us-east-1b"
        security_groups = ["dev-sap-crm-sg"]
      }
    }
    lb = {
      name            = "dev-sap-crm-lb"
      type            = "application"
      scheme          = "internal"
      listener_port   = 80
      security_groups = ["dev-sap-crm-lb-sg"]
    }
  },
  clover = {
    instances = {
      clover1 = {
        ami             = "ami-clover"
        instance_type   = "t3.xlarge"
        subnet_index    = 0
        key_name        = "private-instance"
        az              = "us-east-1a"
        security_groups = ["dev-sap-clover-sg"]
      },
      clover2 = {
        ami             = "ami-clover"
        instance_type   = "t3.xlarge"
        subnet_index    = 1
        key_name        = "private-instance"
        az              = "us-east-1b"
        security_groups = ["dev-sap-clover-sg"]
      }
    }
    lb = {
      name            = "dev-sap-clover-lb"
      type            = "application"
      scheme          = "internal"
      listener_port   = 8080
      security_groups = ["dev-sap-clover-lb-sg"]
    }
  },
  ldaphaproxy = {
    instances = {
      ldaphaproxy1 = {
        ami             = "ami-ldaphaproxy"
        instance_type   = "m5.xlarge"
        subnet_index    = 0
        key_name        = "private-instance"
        az              = "us-east-1a"
        security_groups = ["dev-sap-ldaphaproxy-sg"]
      },
      ldaphaproxy2 = {
        ami             = "ami-ldaphaproxy"
        instance_type   = "t3.xlarge"
        subnet_index    = 1
        key_name        = "private-instance"
        az              = "us-east-1b"
        security_groups = ["dev-sap-ldaphaproxy-sg"]
      }
    }
    lb = {
      name            = "dev-sap-ldaphaproxy-nlb"
      type            = "network"
      scheme          = "internal"
      listener_port   = 389
      security_groups = ["dev-sap-ldaphaproxy-lb-sg"]
    }
  }
}

rds_config = {
  name           = "mysql-api"    # NOTE: This value will be used with a prefix (e.g., "db-") to create a valid identifier.
  instance_class = "db.m5.large"
  engine         = "mysql"
  storage        = 500
}

db_username = "dbuser"
db_password = "changeme123"

ssm_parameters = {
  app_env = {
    name        = "/dev/sap/app_env"
    description = "Application settings for DEV environment"
    value = {
      MYSQL_IP         = "replace_with_mysql_ip"
      POSTGRES_IP      = "replace_with_postgres_ip"
      CRM_LB_DNS       = "replace_with_crm_lb_dns"
      CLOVER_LB_DNS    = "replace_with_clover_lb_dns"
      LDAPHAPROXY_NLB  = "replace_with_ldaphaproxy_nlb_dns"
    }
    type = "SecureString"
  }
}

backup_policy = {
  retention_days      = 7
  resource_tag_filter = "prod-sap"  # In prod, tag value should match required tagging strategy.
}

common_tags = {
  OWEnvironment         = "dev"
  OWComanyCode          = "sap"
  OWCostCenter          = "1000"
  OWResourceName        = "replace_name"   # This can be overridden per resource as needed.
  OWBusinessApplication = "php-app"
  OWRegion              = "us-east-1"
}

# Security groups definitions; you can also place these in security-group.auto.tfvars if preferred.
security_groups = {
  metrics = {
    name        = "dev-sap-metrics-sg"
    description = "Security group for metrics server"
    ingress = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  ems = {
    name        = "dev-sap-ems-sg"
    description = "Security group for EMS server"
    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "crm-lb" = {
    name        = "dev-sap-crm-lb-sg"
    description = "Security group for CRM load balancer"
    ingress = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  rds = {
    name        = "dev-sap-rds-sg"
    description = "Security group for RDS instance"
    ingress = [
      {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  # Additional security groups for other resources as needed...
}
