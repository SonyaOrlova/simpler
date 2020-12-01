class TestsController < Simpler::Controller

  def index
    # render 'tests/list'

    status 201
    render plain: "Plain text response"
  end

  def create

  end

end
