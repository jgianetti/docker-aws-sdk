# Docker container for AWS SDK for python - Tested on Debian

Useful for easy and fast developing of AWS Lambda functions, among other things. And to be able to test them on different platforms.

[AWS SDK](https://aws.amazon.com/sdk-for-python/) is an SDK to create, configure, and manage AWS services.

## How to use

### Build

Container defaults UID=1000. You can override it at build stage.

```bash
docker build -t aws-sdk --build-arg UID=$(id -u) .
```

### Run

```bash
docker run -it --rm \
    -v $HOME/.aws:/home/developer/.aws \
    aws-sdk
```

### Easy and simple start for developing

```bash
docker run -it --rm \
    -v $HOME/.aws:/home/developer/.aws \
    -v $(pwd)/code:/app/code \
    aws-sdk \
    bash
```

Then, inside the container

```bash
python3 main.py
```

### About the image

Based on debian, the container runs `python3 main.py`, on a `virtualenv`, as the user `developer` (default UID=1000).

### Dependencies

Just add them to `code/requirements.txt`.

## Parameters explained

### AWS Credentials

To be able to comunicate to the AWS API, the SDK needs AWS credentials. Usually located in `~/.aws/config` and `~/.aws/credentials`. Mount them inside the container at `/home/developer/.aws`

```bash
    -v $HOME/.aws:/home/developer/.aws
```

### development mode vs run

The easiest way to develop is to mount the code directory directly inside the container. I find no need for fancy reload tooling.

```bash
    -v $(pwd)/code:/app/code
```

This is only necessary when you are developing the app. When you just want to run it, or deploy it, you can and should avoid it. Instead, you should `docker build` it again to update the image, and `docker run` it.
