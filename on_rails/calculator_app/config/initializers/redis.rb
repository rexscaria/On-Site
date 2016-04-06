
redis_host = ENV["REDISTOGO_URL"] || '127.0.0.1'
uri = URI.parse(redis_host)
DataMapper.setup(:default, {:adapter  => "redis"})
Redis.current = Redis.new(:host => uri.host, :port => 6379)


#$redis = Redis::Namespace.new("calculator_app", :redis => Redis.new)
