class ApplicationController < ActionController::API
  before_action :print_headers

  def print_headers
    puts "***" * 100
    p request.authorization
    puts "***" * 100
  end
end
