variable "stage_uid" {
  type = string
}

# not safe
variable "auth_key" {
    type = string
    sensitive = true
    default = "allow"
}

variable "kb_id" {
    type = string
}

variable "source_id" {
    type = string
}

variable "root" {
  type = object({
    api_id = string
    root_id = string
    execution_arn = string
  })
}

variable "bucket_access_policy" {
  type = string
}
