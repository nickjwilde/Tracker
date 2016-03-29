class JqueryController < ActionController::Base
  def homes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @parade_id = params[:id]
    @home_results = worker.interact_with_home('L')
  end

end