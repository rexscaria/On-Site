require 'redis-objects'
require 'redis-objects'
require 'dm-core'
require 'dm-redis-adapter'

DataMapper.setup(:default, {:adapter  => "redis"})
Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)

class InvalidPolishExpression < StandardError
  def initialize(msg)
    @message = msg
  end
end

class NotSupportedInputException < StandardError
    def initialize(msg)
      @message = msg
    end
end

class Calculator
  
	include Redis::Objects
  include DataMapper::Resource

	property :id, Serial  
  
  value :param
  list :storage, :expiration => 1.hour, :marshal => true
  
  @@add = lambda{|a,b| a+b }
  @@subtract = lambda{|a,b| a-b }
  @@multiply = lambda{|a,b| a*b }
  @@divide = lambda{|a,b| a.to_f/b.to_f }
  @@modulus = lambda{|a,b| a%b }
  
  @@operator_map = {
    "+" => @@add,
    "-" => @@subtract,
    "*" => @@multiply,
    "/" => @@divide,
    "%" => @@modulus
  }

  def initialize
    #@storage and @param.value
  end

  def input(param)
    raise TypeError, "Nil is not accepeted" if param.nil?
    @param.value = param.to_s.strip()
    if sanitize
      return process_input()
    end
    @param.value = nil
    raise NotSupportedInputException.new("The input #{@param.value} is not supported")
  end

  def is_operable?
    @storage.length >= 2
  end

  def process_input
    if @@operator_map.include?(@param.value)
      if not is_operable?
        @param.value = nil
        raise InvalidPolishExpression.new("The polish expression is invalid")
      end

      operator1 = @storage.pop.to_f
      operator2 = @storage.pop.to_f
      operator = @@operator_map[@param.value]
      result = operator.call(operator1, operator2)
      @storage << result
      return result
    else
      result = @param.value
      @storage << @param.value
    end

    return result
  end

  def sanitize
    return true if @@operator_map.include?(@param.value)

    begin
      @param.value = Integer(@param.value)
      return true
    rescue ArgumentError
      begin
        @param.value = Float(@param.value)
        return true
      rescue ArgumentError
      end
    end
    return false
  end
  
  private :is_operable?, :process_input, :sanitize

end
