CarrierWave.configure do |config|
  if Rails.env.test? or Rails.env.development?
    config.storage :file
    config.asset_host = 'http://localhost:3000'
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        :provider               => 'AWS',       # required
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],       # required
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']  ,     # required
        :region                 => 'eu-west-1',  # optional, defaults to 'us-east-1'
        :path_style             => true,
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME'] # required
    # see https://github.com/jnicklas/carrierwave#using-amazon-s3
    # for more optional configuration
  end
end