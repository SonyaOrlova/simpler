class TestsController < Simpler::Controller

  def index
    # render 'tests/list'
    render plain: "Plain text response"
  end

  def create

  end

end
