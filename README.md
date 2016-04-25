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

Use the API, the DocusignApi instance will return [curb](https://github.com/taf2/curb) responses. Examples:

### GET
Get a list of your account's templates
```ruby
  c = @api.get '/templates'

  puts c.response_code
  puts JSON::parse(c.body)
```

### POST
Create an envelope from a template
```ruby
  h = {
    emailSubject: email_subject,
    status: 'created',
    templateRoles: [],
    compositeTemplates: [{
      serverTemplates: [
        {
          sequence: '1',
          templateId: template_id
        }
      ],
      document: {
        name: 'document name',
        documentId: document_id,
        documentBase64: Base64.encode64(File.read(pdf)),
        documentFields: [
          { name: 'field1', value: 'value1' },
          { name: 'field2', value: 'value2' }
        ]
      }
    }]
  }

  c = @api.post '/envelopes', h.to_json

  puts c.response_code
  puts JSON::parse(c.body)
```

### PUT
Change envelope recipients
```ruby
  h = {
    signers: { roleName: 'signer', email: 'test@test.com', name: 'Recipient Name', recipientId: '1' }
  }
  c = @api.put '/envelopes/123/recipients', h.to_json

  puts c.response_code
  puts JSON::parse(c.body)
```

### DELETE
Delete envelope recipients
```ruby
  h = {
    signers: [{ recipientId: '1' }]
  }
  c = @api.delete '/envelopes/123/recipients', h.to_json

  puts c.response_code
  puts JSON::parse(c.body)
```

## Docusign API Docs
https://www.docusign.com/p/RESTAPIGuide/RESTAPIGuide.htm

## Source Code
This project was created and is maintained by [Open Listings Engineering](https://www.openlistings.com) <engineering@openlistings.com>
