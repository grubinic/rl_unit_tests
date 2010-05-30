require 'test/unit'

module TestUtils
  def method_call_format(object, method, *args)
    "method call: %s.%s(%s)" %  [object, method, args.join(', ')] 
  end
  
  def top_level_method_call_format(method, *args)
    "method call: %s(%s)" %  [method, args.collect{|x| x.inspect }.join(', ')] 
  end
  
end