### Notes

The Terraform CLI installation instructions have changed due to gpg keyring changes. The latest CLI installation instructions were added via official documentation to a script and then added to the .gitpod.yaml file.

```
gp env PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
```

I can check if the AWS credentials are configured correctly by running:
```
aws sts get-caller-identity
```

### Resources

- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://bash.cyberciti.biz/guide/Shebang
- https://www.pluralsight.com/blog/it-ops/linux-file-permissions
- https://www.gitpod.io/docs/configure/workspaces/tasks
- https://www.geeksforgeeks.org/environment-variables-in-linux-unix/
- https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html


### Terraform Cloud

```
$ terraform login
```

On the prompt cli, exit it with 'q' and click the link there to create a token directly in Terraform cloud.