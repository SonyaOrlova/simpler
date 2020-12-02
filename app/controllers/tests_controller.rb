class TestsController < Simpler::Controller

  def index
    # render 'tests/list'

    status 201
    headers({ 'Content-Type' => 'text/plain' })

    render plain: 'Plain text response Index method'
  end

  def show
    status 200
    headers({ 'Content-Type' => 'text/plain' })

    render plain: "Plain text response Show method. Params = #{params}"
  end

end
