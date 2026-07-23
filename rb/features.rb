# BluefinShieldconex SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module BluefinShieldconexFeatures
  def self.make_feature(name)
    case name
    when "base"
      BluefinShieldconexBaseFeature.new
    when "test"
      BluefinShieldconexTestFeature.new
    else
      BluefinShieldconexBaseFeature.new
    end
  end
end
