class DocusignApi
  def initialize( opts = {} )
    @username = opts[:username] || docusign_const(:username)
    @password = opts[:password] || docusign_const(:password)
    @integrator_key = opts[:integrator_key] || docusign_const(:integrator_key)
    @login_url = opts[:login_url] || docusign_const(:login_url)

    fail "please initialize with Docusign credentials: username, password, integrator_key" unless @username && @password && @integrator_key && @login_url

    @proxy_host = opts[:proxy_host]
    login
  end

  def get( path )
    perform( path, :get)
  end

  def post( path, body )
    perform( path, :post, body: body )
  end

  def put( path, body, opts = {} )
    perform( path, :put, opts.merge(body: body) )
  end

  def delete( path, body = nil )
    perform( path, :delete, body: body )
  end

private

  def auth_headers
    {
      'X-DocuSign-Authentication' => %{
        <DocuSignCredentials>
          <Username>#{@username}</Username>
          <Password>#{@password}</Password>
          <IntegratorKey>#{@integrator_key}</IntegratorKey>
        </DocuSignCredentials>
      }
    }
  end

  def docusign_const(key)
    DOCUSIGN[key] if defined?(DOCUSIGN)
  end

  def perform( path, method, opts = {} )
    fail DocusignApi::UnexpectedResponseBody, "body should be nil or a JSON string" if opts[:body] && !opts[:body].is_a?(String)
    url = full_url(path)

    c = Curl::Easy.new(url)
    c.ssl_verify_peer = false if @proxy_host
    c.headers = default_headers

    case method
    when :put, :delete
      c.put_data = opts[:body]
    when :post
      c.multipart_form_post = !!opts[:multipart_form_post]
      c.post_body = opts[:body]
    end

    c.http(method)

    c
  end

  def full_url( path )
    defined?(@base_url) && @base_url ? File.join(base_url, path) : path
  end

  def base_url
    if @proxy_host && @base_url
      @base_url.gsub(%r|[^/]+\.docusign\.net|, @proxy_host)
    else
      @base_url
    end
  end

  def login
    c = get(login_url)

    fail DocusignApi::LoginFailed, "Login failed: #{[c.response_code, c.body].inspect}" unless 200 == c.response_code
    login_response = JSON::parse(c.body)
    @base_url = login_response['loginAccounts'][0]['baseUrl']
  end

  def login_url
    if @proxy_host
      @login_url.gsub(%r|[^/]+\.docusign\.net|, @proxy_host)
    else
      @login_url
    end
  end

  def default_headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }.merge(auth_headers)
  end

end

class DocusignApi::LoginFailed < StandardError
end

class DocusignApi::UnexpectedResponseBody < StandardError
end
