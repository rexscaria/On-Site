
redis_host = ENV["REDISTOGO_URL"] || '127.0.0.1:6379'
uri = URI.parse(redis_host)
DataMapper.setup(:default, {:adapter  => "redis"})
Redis.current = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)


#$redis = Redis::Namespace.new("calculator_app", :redis => Redis.new)
