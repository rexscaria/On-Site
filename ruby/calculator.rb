class NotSupportedInputException < StandardError
  def initialize(msg)
    @message = msg
  end
end

class InvalidPolishExpression < StandardError
  def initialize(msg)
    @message = msg
  end
end

class Calculator
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
    @storage = Array.new
    @param = nil
  end

  def input(param)
    raise TypeError, "Nil is not accepeted" if param.nil?
    @param = param.to_s.strip()
    if sanitize
      return process_input()
    end
    @param = nil
    raise NotSupportedInputException.new("The input #{@param} is not supported")
  end

  def is_operable?
    @storage.length >= 2
  end

  def process_input
    if @@operator_map.include?(@param)
      if not is_operable?
        @param = nil
        raise InvalidPolishExpression.new("The polish expression is invalid")
      end

      operator1 = @storage.pop
      operator2 = @storage.pop
      operator = @@operator_map[@param]
      result = operator.call(operator1, operator2)
      @storage << result
      return result
    else
      result = @param
      @storage << @param
    end

    return result
  end

  def sanitize
    return true if @@operator_map.include?(@param)

    begin
      @param = Integer(@param)
      return true
    rescue ArgumentError
      begin
        @param = Float(@param)
        return true
      rescue ArgumentError
      end
    end
    return false
  end
  
  private :is_operable?, :process_input, :sanitize
end

if __FILE__== $0
  calc = Calculator.new
  loop do
    print '>'
    ch = gets.chomp
    if ch.eql?('q')
      break
    else
      puts calc.input(ch)
    end
  end
end


