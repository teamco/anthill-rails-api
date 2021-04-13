class Secured::AuthorController < ApplicationController
  before_action :authenticate_user!
end
