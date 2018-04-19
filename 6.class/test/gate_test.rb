require "minitest/autorun"
require "./lib/gate"
require "./lib/ticket"

class Gate_Test < Minitest::Test
  def test_gate
    umeda = Gate.new(:umeda)
    juso =  Gate.new(:juso)

    tk = Ticket.new(150)
    umeda.enter(tk)
    assert juso.exit(tk)
  end
  def test_umeda_to_mikuni_when_fare_is_no_enough
    umeda = Gate.new(:umeda)
    mikuni =  Gate.new(:mikuni)

    tk = Ticket.new(150)
    umeda.enter(tk)
    refute  mikuni.exit(tk)
  end
end
