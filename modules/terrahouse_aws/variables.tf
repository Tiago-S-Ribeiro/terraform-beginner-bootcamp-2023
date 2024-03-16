variable "user_uuid" {
    description = "The user's UUID"
    type        = string

    validation {
        condition     = can(regex("^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$", var.user_uuid))
        error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
    }
}

variable "bucket_name" {
    description = "Name for the S3 bucket name"
    type        = string
}