variable "credentials_path" {
    description = "overwrite in ci"
    default = "account.json"
}

variable "project_name" {
    default = "naesheim-home"
    type = "string"
}

variable "cluster_region" {
    default = "europe-west3"
}

variable "cluster_location" {
    default = "europe-west3c"
}

variable "cluster_name" {
    default = "naesheim-production"
}

variable "cluster_username" {
  type = "string"
  description = "cluster username."
}

variable "cluster_password"  {
  type = "string"
  description = "password for the cluster username."
}

variable "max_node_count" {
  default = 1
}

variable "nodepool_name" {
  default  = "production"
  type     = "string"
  description = "The node pool name."
}

variable "node_pool_count" {
  default  = 1
  description = "The initial size of the cluster node pool."
}

variable "node_disk_size" {
  default  = 50
  description = "The disk size for nodes in the cluster node pool."
}
