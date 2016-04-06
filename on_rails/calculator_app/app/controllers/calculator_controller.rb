class CalculatorController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    @id = SecureRandom.hex(4)
  end

  def create
    @c = Calculator.get(params[:calculator][:id])
    if not @c
      @c = Calculator.new
      @c.id = params[:calculator][:id]
    @c.storage
    @c.param
    end

    begin
      @success = true
      @msg = @c.input(params[:calculator][:param]) 
    rescue Exception => e
      @success = false
      @msg = e.message
    end
   
    render :json => {:success => @success, :result=>@msg}
  end

  def calculator_params
    params.requier(:calculator).permit(:id, :param)
  end
end
