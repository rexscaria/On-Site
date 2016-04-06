class CalculatorController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
  end

  def new
    @id = SecureRandom.hex(4)
    render :json => {:success => true, :id=>@id}
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
      @error = ""
      @msg = @c.input(params[:calculator][:param]) 
    rescue => e
      @success = false
      @error = e.class
      @msg = e.message
    end
   
    render :json => {:success => @success, :result=>@msg, :error=> @error}
  end

  def calculator_params
    params.requier(:calculator).permit(:id, :param)
  end
end
