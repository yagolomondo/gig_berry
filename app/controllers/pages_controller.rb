class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  # Testing comment
  def home
  end
end
