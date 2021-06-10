variable "project_id" {
  description = "The ID of an Google Project "
  type =string
  default = ""
}
variable "region" {
  description = "Region"
  type = string
  default = ""
}

variable "zone" {
  description = "zone"
  type = string
  default = ""
}
variable "cls_name" {
  description = "Name of the cluster"
  type = string
  default = ""
}
variable "cls_location_id" {
  description = "Location of cluster"
  type = string
  default = ""
}

variable "initial_node_count" {
  description = "The domain associated with the GCP Organization ID"
  type = number
  default = 1
}
variable "remove_default_node_pool" {
  description = "remove default node pool if anything exist"
  type = bool
  default = true
}
variable "container_node_pool_name" {
  description = "Name of the conatiner node pool name"
  type = string
  default = ""
}
variable "container_node_pool_name_location_id" {
  description = "In Which region you want to create container nod pool "
  type =string
  default = ""
}

 variable "chart_name" {
  description = "Chart name used "
  type =string
  default = ""
 }

variable "node_count" {
  description = "Number of nodes to create"
  type =number
  default = 1
}
variable "docker_repo" {
  description = "docker repo used"
  type =string
  default = ""
}
variable "docker_tag" {
  description = "docker tag used"
  type =string
  default =true
}
