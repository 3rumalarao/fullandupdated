security_groups = {
  METRICS = {
    name        = "${var.env}-${var.orgname}-METRICS-SG"
    description = "Security group for METRICS server"
    ingress = [
      {
        from_port   = 80,
        to_port     = 80,
        protocol    = "tcp",
        cidr_blocks = ["0.0.0.0/0"]
      }
    ],
    egress = [
      {
        from_port   = 0,
        to_port     = 0,
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  EMS = {
    name        = "${var.env}-${var.orgname}-EMS-SG"
    description = "Security group for EMS server"
    ingress = [
      {
        from_port   = 0,
        to_port     = 0,
        protocol    = "tcp",
        cidr_blocks = ["10.0.0.0/16"]
      }
    ],
    egress = [
      {
        from_port   = 0,
        to_port     = 0,
        protocol    = "-1",
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  // Add additional security groups for MERGER, CSMERGE, MYSQL, POSTGRESQL, CRM, CLOVER, LDAPHAPROXY, REGCOM, ERCOT, etc.
}
