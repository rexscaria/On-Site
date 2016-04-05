require_relative"calculator"
require"test/unit"

class TestCalculator< Test::Unit::TestCase

  def setup
    @calc = Calculator.new
    @polish_right = "1 2 3 + / 4 5 * +"
    @float_support_polish = "20E02 13.45 - 0x23 /"
  
    @wrong_input_polish1 = "1 2 ( 3 * 6 + 2 3 + /"
    @wrong_input_polish2 = "1 2 ) 3 * 6 + 2 3 + /"
    @wrong_input_polish3 = "1 k + 3 * 6 + 2 3 + /"
    @wrong_input_polish4 = "1 m > 3 * 6 + 2 3 + /"
  
    @wrong_polish1 = "2 + 3 * 6 + 2 3 + /"
    @wrong_polish2 = "1 2 5 3 * 6 + 2 3 + / * * *"
    @wrong_polish3 = "1 2 + * 6 + 2 3 + /"
    @wrong_polish4 = "1 2 + 3 * 6 + % 2 3 +"

    @result = []
  end

  def process_polish(polish)
    @result = []
    polish.split().each{|i| @result << @calc.input(i) }
  end

  def test_input
    process_polish(@polish_right)
  
    assert_equal(@result, [1, 2, 3, 5, 5.0, 4, 5, 20, 25.0])
  end

  def test_float_input
    process_polish(@float_support_polish)

    assert_equal(@result, [2000.0, 13.45, -1986.55, 35, -0.017618484306964336])
  end

  def test_wrong_operator_input
    assert_raise(NotSupportedInputException){ process_polish(@wrong_input_polish1) }
    
    @calc = Calculator.new()
    assert_raise(NotSupportedInputException){ process_polish(@wrong_input_polish2) }

    @calc = Calculator.new()
    assert_raise(NotSupportedInputException){ process_polish(@wrong_input_polish3) }
    
    @calc = Calculator.new()
    assert_raise(NotSupportedInputException){ process_polish(@wrong_input_polish4) }
  end


  def test_wrong_polish_expression_input
    assert_raise(InvalidPolishExpression){ process_polish(@wrong_polish1) }
    
    @calc = Calculator.new()
    assert_raise(InvalidPolishExpression){ process_polish(@wrong_polish2) }

    @calc = Calculator.new()
    assert_raise(InvalidPolishExpression){ process_polish(@wrong_polish3) }
    
    @calc = Calculator.new()
    assert_raise(InvalidPolishExpression){ process_polish(@wrong_polish4) }
  end

end

