class TopController < ApplicationController
  def index
    session.delete(:previous)
  end
end
