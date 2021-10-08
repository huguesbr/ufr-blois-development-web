require 'json'
require 'uri'
# require 'cgi'

POSTS_BODY = <<EOF
{
  "data": [
    {
      "id": "112125381237572_112175037899273",
      "message": "Hello it's me",
      "created_time": "2021-10-06T10:56:01+0000"
    },
    {
      "id": "112125381237572_112174994565944",
      "message": "Hello again",
      "created_time": "2021-10-06T10:55:51+0000"
    },
    {
      "id": "112125381237572_112155004567943",
      "message": "Et encore un autre message",
      "created_time": "2021-10-06T10:32:45+0000"
    },
    {
      "id": "112125381237572_112154947901282",
      "message": "Un autre message",
      "created_time": "2021-10-06T10:32:37+0000"
    },
    {
      "id": "112125381237572_112140841236026",
      "message": "Ceci est un exercise",
      "created_time": "2021-10-06T10:06:39+0000"
    },
    {
      "id": "112125381237572_112130777903699",
      "message": "Hello, how are you?",
      "created_time": "2021-10-06T09:48:35+0000"
    },
    {
      "id": "112125381237572_112077747909002",
      "message": "Premiere publication",
      "created_time": "2021-10-06T08:20:04+0000"
    },
    {
      "id": "112125381237572_112075634575880",
      "created_time": "1982-03-01T08:00:00+0000"
    }
  ],
  "paging": {
    "previous": "https://graph.facebook.com/v12.0/112125381237572/posts?access_token=EAAHvamI3YqEBABuIOAGP1qDZBnL4e52buiuqaW0jNqugFIJ8YOlfCDz6q4IZBZCX6ZADH3hYNX4hLJJHAUD224GC7mcUJQcRZCjbolPDkWhqlkFwtyqw8UDDrugTIK6LOWWDFHZAOG65lWEqjO7R3RUH2EwbOJPRW6ZCvZBopWjzIyp6Dlx9eHcMIcZB0sdgMJvEfzo5noHrGqAZDZD&pretty=0&fields=id%2Cmessage%2Ccreated_time&__previous=1&since=1633517761&until&__paging_token=enc_AdCQnH53ZCjxVM1NZBqOhDjoz6hU5QvLZBrMV16fZApKna5oLBruehlbpHRTLUuirDAWwpdcQmZCRcH2z8NXdGyj3Cd4Q3HVm6YZAjUkY5EZCDlPifyJv4JLTBSCMdkIoyEPZCYhY6T5bQ6iMOR6Em3W3StL2PUs",
    "next": "https://graph.facebook.com/v12.0/112125381237572/posts?access_token=EAAHvamI3YqEBABuIOAGP1qDZBnL4e52buiuqaW0jNqugFIJ8YOlfCDz6q4IZBZCX6ZADH3hYNX4hLJJHAUD224GC7mcUJQcRZCjbolPDkWhqlkFwtyqw8UDDrugTIK6LOWWDFHZAOG65lWEqjO7R3RUH2EwbOJPRW6ZCvZBopWjzIyp6Dlx9eHcMIcZB0sdgMJvEfzo5noHrGqAZDZD&pretty=0&fields=id%2Cmessage%2Ccreated_time&until=383817600&since&__paging_token=enc_AdCIgOO0SnpnW9957oRBTuTKzGlI6wfG1JQnTZBWOEED24MxaAytdE2U2SoZAaBFwDfnkiwoX3Yddnib3fSWLTVf7OqvqRTKSPybLUvCJxokTu4fh0sZAJ62hbZBy9ZBRAhVQbGu2zRTgfJnfiSDkLR5tXIBY&__previous"
  }
}
EOF

ME_BODY = <<EOF
{
  "id": "112125381237572",
  "email": "0@101.fr",
  "first_name": "Hugues",
  "last_name": "Bernet-Rollande"
}
EOF

COMMENTS_BODY = <<EOF
{
  "data": [
    {
      "created_time": "2021-10-06T10:32:19+0000",
      "from": {
        "name": "Hugues Bernet-Rollande",
        "id": "112125381237572"
      },
      "message": "Salut les kids",
      "id": "112077747909002_112154734567970"
    },
    {
      "created_time": "2021-10-06T10:32:27+0000",
      "from": {
        "name": "Hugues Bernet-Rollande",
        "id": "112125381237572"
      },
      "message": "Comment ca va?",
      "id": "112077747909002_112154774567966"
    }
  ],
  "paging": {
    "cursors": {
      "before": "WTI5dGJXVnVkRjlqZAFhKemIzSTZANVEV5TVRVME56TTBOVFkzT1Rjd09qRTJNek0xTVRZAek5EQT0ZD",
      "after": "WTI5dGJXVnVkRjlqZAFhKemIzSTZANVEV5TVRVME56YzBOVFkzT1RZAMk9qRTJNek0xTVRZAek5EYz0ZD"
    }
  }
}
EOF


class HTTParty
  def self.get(url)
    if url == 'test'
      puts "OK"
      return
    end
    uri = URI(url)
    raise StandardError, "Failed to open TCP connection to #{uri}" unless uri.host == 'graph.facebook.com'
    raise StandardError, "Failed to open TCP connection to #{uri}" unless uri.scheme == 'https'
    # params = CGI::parse(uri.query)
    # raise StandardError, 'Invalid Token' unless params['access_token'] == ['TOKEN']
    case
    when uri.path == '/me/posts'
      Response.new(POSTS_BODY)
    when uri.path == '/me'
      Response.new(ME_BODY)
    when url.include?('/comments')
      Response.new(COMMENTS_BODY)
    else
      raise 'Invalid URL'
    end
  end

  class Response
    attr_accessor :body
    def initialize(body)
      self.body = body
    end

    def parsed_response
      JSON.parse(self.body)
    end
  end
end

