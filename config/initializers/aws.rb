 # load the libraries
require 'pathname'
require 'aws-sdk'
# log requests using the default rails logger
AWS.config(:logger => Rails.logger)
# load credentials from a file

AWS.config({
  :access_key_id => 'AKIAJZTKQSL62KW4T2JQ',
  :secret_access_key => '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',
})