require 'logger'

class AppLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    response = @app.call(env)

    @logger.info(message(env, response))

    response
  end

  private

  def message(env, response)
    status, headers, body = response

    "\nRequest: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}\n" \
    "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}\n" \
    "Parameters: #{env['simpler.controller'].params}\n" \
    "Response: #{status} OK [#{headers['Content-Type']}] #{env['simpler.template_path']}\n"
  end
end
