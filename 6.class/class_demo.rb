class User
  DEFAULT_AGE = 18
  #attr_reader :first_name, :last_name, :age
  def initialize(first_name,last_name,age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
  def full_name()
    "#{@last_name} #{@first_name}"
  end
  def self.info()
    "名前と年齢を保持するクラスです"
  end
end

user = User.new("太郎","山田",20)
p user.full_name()
p User.info()
p user::DEFAULT_AGE
