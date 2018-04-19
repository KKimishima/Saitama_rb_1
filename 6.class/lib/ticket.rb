class Ticket
  attr_reader :stamped_at, :fare
  def initialize(fare)
    @fare = fare
  end
  
  def stamp(name)
    @stamped_at = name
  end
end
