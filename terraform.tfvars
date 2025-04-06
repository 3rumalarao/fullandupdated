aws_region = "us-east-1"
env        = "DEV"
orgname    = "SAP"
vpc_id     = "vpc-12345678"

private_subnets  = ["subnet-aaa111", "subnet-bbb222", "subnet-ccc333"]
public_subnets   = ["subnet-ddd444", "subnet-eee555", "subnet-fff666"]

private_servers = {
  METRICS = {
    ami           = "ami-METRICS"
    instance_type = "m5.xlarge"
    subnet_index  = 0
    key_name      = "private-instance"
  },
  EMS = {
    ami           = "ami-EMS"
    instance_type = "t3.large"
    subnet_index  = 1
    key_name      = "private-instance"
  },
  MERGER = {
    ami           = "ami-45373"
    instance_type = "t2.large"
    subnet_index  = 2
    key_name      = "private-instance"
  },
  CSMERGE = {
    ami           = "ami-CSMERGE"
    instance_type = "r5.large"
    subnet_index  = 0
    key_name      = "private-instance"
  },
  MYSQL = {
    ami           = "ami-MYSQL"
    instance_type = "r5.4xlarge"
    subnet_index  = 1
    key_name      = "private-instance"
  },
  POSTGRESQL = {
    ami           = "ami-POSTGRES"
    instance_type = "r5.4xlarge"
    subnet_index  = 2
    key_name      = "private-instance"
  }
}

public_servers = {
  REGCOM = {
    ami           = "ami-REGCOM"
    instance_type = "m5.xlarge"
    subnet_index  = 0
    key_name      = "private-instance"
    allocate_eip  = true
  },
  ERCOT = {
    ami           = "ami-ERCOT"
    instance_type = "m5.xlarge"
    subnet_index  = 1
    key_name      = "private-instance"
    allocate_eip  = true
  }
}

efs = {
  name          = "${env}-${orgname}-EFS"
  mount_targets = [
    { az = "us-east-1a", subnet_index = 0 },
    { az = "us-east-1b", subnet_index = 1 },
    { az = "us-east-1d", subnet_index = 2 }
  ]
}

application_servers = {
  crm = {
    instances = {
      CRM1 = {
        ami           = "ami-565732"
        instance_type = "m5.xlarge"
        subnet_index  = 0
        key_name      = "private-instance"
        az            = "us-east-1a"
      },
      CRM2 = {
        ami           = "ami-565732"
        instance_type = "m5.xlarge"
        subnet_index  = 1
        key_name      = "private-instance"
        az            = "us-east-1b"
      }
    }
    lb = {
      name          = "${env}-${orgname}-CRM-LB"
      type          = "application"
      scheme        = "internal"
      listener_port = 80
    }
  },
  clover = {
    instances = {
      CLOVER1 = {
        ami           = "ami-CLOVER"
        instance_type = "t3.xlarge"
        subnet_index  = 0
        key_name      = "private-instance"
        az            = "us-east-1a"
      },
      CLOVER2 = {
        ami           = "ami-CLOVER"
        instance_type = "t3.xlarge"
        subnet_index  = 1
        key_name      = "private-instance"
        az            = "us-east-1b"
      }
    }
    lb = {
      name          = "${env}-${orgname}-CLOVER-LB"
      type          = "application"
      scheme        = "internal"
      listener_port = 8080
    }
  },
  ldaphaproxy = {
    instances = {
      LDAPHAPROXY1 = {
        ami           = "ami-LDAPHAPROXY"
        instance_type = "m5.xlarge"
        subnet_index  = 0
        key_name      = "private-instance"
        az            = "us-east-1a"
      },
      LDAPHAPROXY2 = {
        ami           = "ami-LDAPHAPROXY"
        instance_type = "t3.xlarge"
        subnet_index  = 1
        key_name      = "private-instance"
        az            = "us-east-1b"
      }
    }
    lb = {
      name          = "${env}-${orgname}-LDAPHAPROXY-NLB"
      type          = "network"
      scheme        = "internal"
      listener_port = 389
    }
  }
}

rds_server = {
  name           = "${env}-${orgname}-MYSQL-API"
  instance_class = "db.m5.large"
  engine         = "mysql"
  username       = "dbuser"
  password       = "ChangeMe123"
  storage        = 500
  subnets        = private_subnets
}

ssm_parameters = {
  app_env = {
    name        = "/${env}/${orgname}/app_env"
    description = "Application settings for ${env} environment"
    value       = jsonencode({
      MYSQL_IP         = "replace_with_mysql_ip",
      POSTGRES_IP      = "replace_with_postgres_ip",
      CRM_LB_DNS       = "replace_with_crm_lb_dns",
      CLOVER_LB_DNS    = "replace_with_clover_lb_dns",
      LDAPHAPROXY_NLB  = "replace_with_ldaphaproxy_nlb_dns"
    })
    type        = "SecureString"
  }
}

backup_policy = {
  retention_days      = 7
  resource_tag_filter = "PROD-${orgname}"
}
