class AdminController < ApplicationController
  def home
    worker = Factory.new
    @test = Array.new
    @test = [1,2,3]
    worker.connect_to_db("")
    @results = worker.interact_with_parade('L')
  end
end
