require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def params
      @request.env['simpler.route.params'].merge! @request.params
    end
    
    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      headers({ 'Content-Type' => 'text/html' })
    end

    def status(status)
      @response.status = status
    end

    def headers(headers={})
      headers.each { |key, value| @response[key] = value }
    end

    def write_response
      body = @body || render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(options)
      (options.is_a? String) ? render_html(options) : render_plain(options[:plain])
    end

    def render_html(template)
      @request.env['simpler.template'] = template
    end

    def render_plain(string)
      @body = string
    end
    
  end
end
