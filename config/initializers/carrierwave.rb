# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage :file
    config.asset_host = 'http://localhost:3000'
  else
    config.storage = :aws
    config.aws_credentials = {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'], # required
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
      region: ENV['AWS_REGION'] # required, defaults to 'us-east-1'
    }
    config.aws_bucket = ENV['S3_BUCKET_NAME'] # required
    # see https://github.com/jnicklas/carrierwave#using-amazon-s3
    # for more optional configuration
  end
end
