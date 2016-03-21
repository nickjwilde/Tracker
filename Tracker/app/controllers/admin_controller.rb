class AdminController < ApplicationController
  def home
    worker = Factory.new
    worker.connect_to_db("nitrous","")
    @results = worker.interact_with_parade('L')
  end
end
