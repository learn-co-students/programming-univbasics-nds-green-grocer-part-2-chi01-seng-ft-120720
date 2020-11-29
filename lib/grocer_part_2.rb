require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
      coupon_name = "#{coupons[counter][:item]} W/COUPON"
      cart_item_name_with_coupon = find_item_by_name_in_collection(coupon_name, cart)
      if cart_item && cart_item[:count] >= coupons[counter][:num]
        if cart_item_name_with_coupon 
          cart_item_name_with_coupon[:count] += coupons[counter][:num]
          cart_item[:count] -= coupons[counter][:num]
        else cart_item_name_with_coupon = {
          :item => coupon_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_name_with_coupon
        cart_item[:count] -= coupons[counter][:num]
        end 
      end 
      counter += 1 
  end 
  cart 
end

def apply_clearance(cart)
  index = 0 
  cart.each do |item|
    if item[:clearance] 
      item[:price] = (item[:price] - (item[:price] * 0.20)).round(2)
    end 
    index += 1 
  end 
  cart 
end

 # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  
  total = 0 

  index = 0 
  
  final_cart.each do |key|
    total += key[:price] * key[:count] 
    index += 1
  end 
  if total > 100
    total -= (total * 0.10)
  end 
  total 
end