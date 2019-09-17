# include HTTParty

class User

  def self.get_auth(email, password)
    # return nil unless id.present?

    response = HTTParty.post(
      "http://localhost:3000/auth/login",
      body: {"email": "#{email}", "password": "#{password}"}.to_json,
      headers: {
        'Content-Type' => 'application/json'
      } 
    )
    response['auth_token']
  end
  
  def self.find(id)
    return nil unless id.present?

    response = HTTParty.get(
      "http://localhost:3000/todos/#{id}/",
      headers: {
        'Content-Type' => 'application/json', 
        'Authorization' => session[:auth_token]
      } 
    )

    response.each do |item|
      define_method "#{item[0]}".to_sym do
        instance_variable_get "@#{item[0]}"
      end

      define_method "#{item[0]}=".to_sym do |val|
        instance_variable_set "@#{item[0]}", val
      end
    end
    new(response)
  end

  def initialize(args)
    args.each do |arg|
      public_send "#{arg[0]}=".to_sym, arg[1]
    end
  end
end
