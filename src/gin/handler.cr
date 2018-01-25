require "http/server"

module Gin
  include HTTP::Handler

  @req : HTTP::Request?
  @res : HTTP::Server::Response?

  abstract def routes

  def call(context)
    dup._call(context)
  end

  def call(context)
    @matched = false
    @req, @res = context.request, context.response
    routes
    call_next(context) unless @matched
  end

  def on(*arg, &blk)
    return if @matched
    yield *arg.map { |a|
      if a.is_a?(Bool)
        a || return
      else
        a.call || return
      end
    }
    @matched = true
  end

  def path(p : String)
    ->() {
      if req=@req
        if req.resource =~ /\A(#{p})(.*)/
          req.resource = $2
          $1
        end
      end
    }
  end

  def segment
    path("[^\\/]+")
  end

  def method
    if req=@req
      req.method
    end
  end

  def get; method=="GET"; end
  def post; method=="POST"; end
  def put; method=="PUT"; end
  def delete; method=="DELETE"; end

  def puts(*args)
    if res=@res
      args.each { |s|
        res.print s
        res.print "\n"
      }
    end
  end
end


