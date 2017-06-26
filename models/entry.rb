class Entry
  attr_accessor :name, :email, :phone_number

  def initialize(name,phone_number,email)
    @name = name
    @phone_number = phone_number
    @email = email
  end

  def to_s
    "Name: #{name}\nPhone Number: #{phone_number}\nEmail: #{email}" 
  end
end
