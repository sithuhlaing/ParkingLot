carpark = Array.new
index = 0
slots = 0
is_full = true

begin
  instruction = gets.chomp
  command = instruction.split
  case command[0]
    when 'create_parking_lot'
      is_full = false
      slots = command[1].to_i
      carpark = Array.new(slots, nil)
      puts 'Created a parking lot with %x slots' % slots
    when 'park'
      puts "park #{index} #{is_full}"
      if index+1 >= slots
        is_full = true
        puts 'Sorry, parking lot is full'
        index = 0
      else
        while carpark[index] != nil
          index += 1
          if index >= slots
           index = -1
           puts 'Sorry, parking lot is full'
           break
          end
        end
        if index >= 0
          carpark[index] = {'No' => index, 'RegNo' => command[1], 'Color'=> command[2]}
          puts "Allocated slot number: #{index+1}"
        end
        index = 0
      end
    when 'leave'
      i = command[1].to_i
      carpark[i-1] = nil
      puts "Slot number #{i} is free"
      is_full = false
      index = 0
    when 'status'
      x = 1
      puts 'Slot No. Registration No Color'
      carpark.each do |car|
        if car != nil 
          puts "#{x}       #{car['RegNo']} #{car['Color']}"
        end
        x += 1
      end
    when 'registration_numbers_for_cars_with_colour'
      car_list = carpark.select{|car| command[1] == car['Color']}.map{|car| car['RegNo']}
      puts car_list.join(", ")
    when 'slot_numbers_for_cars_with_colour'
      car_list = carpark.select{|car| command[1] == car['Color']}.map{|car| car['No'] + 1}
      puts car_list.join(", ")
    when 'slot_number_for_registration_number'
      car = carpark.select{|car| command[1] == car['RegNo']}
      if car == nil
        puts 'Not found'
      else
        puts car[0]['No'] + 1
      end
    else
      puts 'errors'
  end
end while true
