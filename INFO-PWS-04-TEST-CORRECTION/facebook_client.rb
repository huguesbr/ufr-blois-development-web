load 'http.rb'
module Facebook
  class Client
    DEFAULT_ACCESS_TOKEN = 'TOKEN'
    attr_accessor :access_token

    def self.default
      new(access_token: DEFAULT_ACCESS_TOKEN)
    end

    def initialize(access_token:)
      self.access_token = access_token
    end

    def get_posts(keyword: nil)
      results = HTTParty.get("https://graph.facebook.com/me/posts?fields=id,message,created_time&access_token=#{access_token}")
      posts = results.parsed_response['data']
      filtered_posts = posts
      if keyword
        filtered_posts = []
        posts = posts.select { |p| p['message'] } # remove posts without any message
        for post in posts
          filtered_posts << post if post['message'].include?(keyword)
        end
      end
      filtered_posts
    end

    def get_me
      results = HTTParty.get("https://graph.facebook.com/me?fields=first_name,last_name,email&access_token=#{access_token}")
      # `me` request DOES NOT return a `data` key
      results.parsed_response
    end

    def get_comments(post_id:)
      results = HTTParty.get("https://graph.facebook.com/#{post_id}/comments?access_token=#{access_token}")
      results.parsed_response['data']
    end

    def get_user_information
      user = get_me
      "Hello, #{user['first_name']} #{user['last_name']}, you're email is #{user['email']}"
    end

    def display_feed
      puts get_user_information
      posts = get_posts
      for post in posts
        comments = get_comments(post_id: post['id'])
        puts "- '#{post['message']}' with #{comments.count} comment(s)"
      end
    end
  end
end