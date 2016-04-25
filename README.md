# docusign_api

Use the Docusign REST API with libcurl

## Usage
Add to your Gemfile:

```ruby
gem 'docusign_api'
```

Initialize with your credentials, either inline or set a constant called `DOCUSIGN`

```ruby
  @api = DocusignApi.new username: 'username', password: 'password', integrator_key: 'abc1234', login_url: 'https://demo.docusign.net/restapi/v2/login_information'
```

Use the API, the DocusignApi instance will return curb responses. Examples:

```ruby
  c = @api.get '/templates'

  puts c.response_code
  puts JSON::parse(c.body)
```
