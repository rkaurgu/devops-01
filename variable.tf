variable "cidr_block" {
    type = list(string)
    default = ["172.20.0.0/16","172.20.10.0/24","172.20.20.0/24"]

}

variable "ports" {
    type = list(number)
    default = [22,8080,443,8081,80]
}