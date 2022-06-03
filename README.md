# Custom AWS Lambda runtime for Crystal

We will show you how to use AWS Lambda's [Custom Runtime](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html) feature to execute [Crystal](https://crystal-lang.org/)'s code.
This project can be utilized as a library, but we recommend that you do **NOT** use it for production workloads as it is only sample code.

## Step-by-Step Guide

**1. Build a docker image**

First, create a Docker image to be used as a builder. Clone this repository and execute the following command

```bash
docker build -t crystal-lambda-builder .
```

**2. Add a dependency**

Add this repository to dependency by adding the following statement to shard.yml

```yaml
dependencies:
  lambda_runtime:
    github: aws-samples/lambda-crystal-runtime
```

Then run `shards install` to install.

**3. Write Lambda function**

Write a Lambda function in Crystal. Create `src/example.cr` and make the following contents.

```crystal
require "lambda_runtime"

lambda_event_loop do |event_body|
  puts event_body

  "ok"
end
```

This function prints the received `event_body` and returns the string `ok`. It is very simple code.

**4. Build Crystal code**

Add the following statement to `shard.yml`.

```yaml
targets:
  example:
    main: src/example.cr
```

Instead of doing a `shards build` like a normal Crystal project, run the following command

```bash
docker run -v $(pwd):/lambda-src crystal-lambda-builder
```

After successful execution, the `lambda` directory will be created, containing a zip file called `example.zip`.
You can then create a function from the Lambda management console, upload the zip file as source code, and it is ready to run.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

