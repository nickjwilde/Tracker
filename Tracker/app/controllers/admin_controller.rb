class AdminController < ApplicationController
  def events
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @results = worker.interact_with_parade('L')
  end
end
