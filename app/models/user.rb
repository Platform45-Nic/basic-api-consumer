# include HTTParty

class User
  
  def self.find(id)
    return nil unless id.present?

    response = HTTParty.get(
      "http://localhost:3000/todos/#{id}/",
      headers: {
        'Content-Type' => 'application/json', 
        'Authorization' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Njg3MzI0NDd9.1TN_Rp1XyFNYuGJMZrqiwJnXWu9vyXHWM_k4esn_DvM'
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
