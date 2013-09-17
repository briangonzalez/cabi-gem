
class Hash
  
  def access(path)
    val = false

    path.split( Cabi::DELIMITER ).each do |p|
      if p.to_i.to_s == p
        val = self[p.to_i]
      else
        val = self[p.to_s] || self[p.to_sym]
      end
      break unless val
    end

    val
  end

end