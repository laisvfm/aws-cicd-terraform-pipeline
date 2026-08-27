variable "admin_ip" {
  type        = string
  description = "IP address allowed to access the instance via SSH"
  default     = "0.0.0.0/0" # Generic fallback if no value is provided
}