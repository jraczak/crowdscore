# Mock out Fog by pretending a bucket exists
Fog.mock!
connection = Fog::Storage.new(:provider => 'AWS')
connection.directories.create(:key => 'crowdscore-test')
