#####################################################
# Base sur le fichier assertions.rb repot Emprunts
#####################################################

def assert_equal( expected, obtained, msg = nil )
  unless expected == obtained
    fail "*** assert_equal( #{expected.inspect}, #{obtained.inspect}, #{msg} )"
  end
end

def assert( condition, msg = nil )
  fail "*** assert non satisfait: #{msg}" unless condition
end

def refute( condition, msg = nil )
 fail "*** refute non satisfait: #{msg}" if condition
end
