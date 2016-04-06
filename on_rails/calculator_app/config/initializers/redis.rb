
DataMapper.setup(:default, {:adapter  => "redis"})
Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)


#$redis = Redis::Namespace.new("calculator_app", :redis => Redis.new)
