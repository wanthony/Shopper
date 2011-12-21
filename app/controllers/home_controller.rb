class HomeController < ApplicationController
  def index
    @televisions = Television.from_walmart('Samsung TV')
  end

end
