
class HelloWorld
  def self.hello (name) # the use of self makes hello a static method o_O
    name == '' ? ('Hello, world!') : ("Hello, #{name}!")
  end
end
