import boto3

s3 = boto3.resource('s3')

print("Listing AWS:S3 buckets...")
print("--")

for bucket in s3.buckets.all():
    print(bucket.name)
