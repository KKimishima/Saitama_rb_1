class Gate
  STATIONS = [:umeda, :juso, :mikuni] # :nodoc:
  FARES = [150,190]
  def initialize(name)
    @name = name
  end
  def enter(tk)
    tk.stamp(@name)
  end
  def exit(tk)
    fare = calc_fate(tk)
    fare <= tk.fare
  end
  def calc_fate(tk)
    from = STATIONS.index(tk.stamped_at)
    to = STATIONS.index(@name)
    distance = to - from
    FARES[distance - 1]
  end
end

