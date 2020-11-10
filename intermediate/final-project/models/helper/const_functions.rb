CRUD_RESPONSE = {
  :create_success => 1,
  :failed => 2,
  :already_existed => 3,
  :update_success => 4,
  :delete_success => 5
}

# def list_equal(list_1, list_2)
#   return false if list_1.nil? || list_2.nil?
#   return false if !list_1.instance_of?(Array) || !list_2.instance_of?(Array) 
#   return false if list_1.length != list_2.length
#   list_1.each do |elmt|
#     return false if !list_2.include?(elmt)
#   end
#   true
# end