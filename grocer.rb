require 'pry'
def consolidate_cart(cart)
  new_cart = {} 
  cart.each do |hash|
    if new_cart.keys.include?(hash.keys[0]) 
      new_cart[hash.keys[0]][:count] +=1
    else 
    new_cart[hash.keys[0]] = hash[hash.keys[0]] #this adds price and clearence to new_cart
    new_cart[hash.keys[0]][:count] = 1 #this creates a new key called count in the new_cart and sets the value as 1
    end
  end
  return new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

#   new_cart ={}
#   if coupons.size != 0
#     cart.keys.each do |out_keys| #["AVOCADO", "KALE"], cart.keys.each iterates through  elements of that new array, with |out_keys| representing elements
#       coupons.each do |coupon| 
#         #puts out_keys == coupon[:item]
#         if out_keys == coupon[:item] # if avocado == avocado,
#           apply_amt = cart[out_keys][:count] / coupon[:num]
  
#           remainder = cart[out_keys][:count] % coupon[:num]  
      
#           new_cart[out_keys] = {:price => cart[out_keys][:price], :clearance => cart[out_keys][:clearance], :count => remainder}
      
          
#           single_coup_cost = (coupon[:cost])/(coupon[:num])
        
#           new_cart["#{out_keys} W/COUPON"] =  {:price => single_coup_cost, :clearance => cart[out_keys][:clearance] , :count => coupon[:num]*(coupons.count(coupon)) }
#           cart[out_keys][:count] -= (apply_amt*(coupon[:num]))

#         else out_keys != coupon[:item] 
#           new_cart[out_keys] = cart[out_keys] #this creates a new key in the new_cart


          
          
#         end
#       end
#     end
#   else 
#     new_cart = cart
#   end   
# new_cart
# end 



def apply_clearance(cart)
  cart.keys.each do |keys|
    if cart[keys][:clearance] 
      cart[keys][:price] -= ((cart[keys][:price]) * 0.2)
    end
  end
return cart
end



def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  new_cart = apply_coupons(consolidated, coupons)
  updated = apply_clearance(new_cart)

  next_updated = updated.reduce(0) do |memo, (key, value)|
    memo += (value[:price] * value[:count])
   

  if next_updated > 100 
    next_updated -= (next_updated * 0.10)
    return next_updated
  else
    return next_updated
  end
  
end

