require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu- #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import Entries from a CSV"
    puts "5 - View Entry Number n"
    puts "6 - Exit"


  selection = gets.to_i

  case selection
  when 1
    system "clear"
    view_all_entries(true)
  when 2
    system "clear"
    create_entry
    main_menu
  when 3
    system "clear"
    search_entries
    main_menu
  when 4
    system "clear"
    read_csv
    main_menu
  when 5
    system "clear"
    view_entry
  when 6
    puts "Goodbye"
    exit(0)
  else
    system "clear"
    puts "Sorry, that is not a valid input"
    main_menu
  end
end

  def view_all_entries(show_submenu)
    address_book.entries.each_with_index do |entry, index|
      system "clear"
      puts "Entry Number - #{index}"
      puts entry.to_s
      entry_submenu(entry) if show_submenu
    end
      puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp

    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)

    else
      puts "No match found for #{name}"
    end

  end

  def read_csv
    print "Enter CSV file to import:"
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entires added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name"
      read_csv
    end
  end

  def view_entry
    view_all_entries(false)
    puts 'Select the number entry you\'d like to view'
    entry_search = gets.to_i
    if entry_search < address_book.entries.count
      puts address_book.entries[entry_search]
      entry_submenu(address_book.entries[entry_search])
    else
      puts "Your selection #{entry_search} is not valid, please try again"
      main_menu
    end
  end

  def entry_submenu(entry)
    puts 'n - next entry'
    puts 'd - delete entry'
    puts 'e - edit this entry'
    puts 'm - return to main menu'

    selection = gets.chomp

    case selection
      when 'n'
      when 'd'
        delete_entry(entry)
      when 'e'
        edit_entry(entry)
        entry_submenu(entry)
      when 'm'
        system "clear"
        main_menu
      else
        system 'clear'
        puts '#{selection} is not a valid input'
        entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    print "Updated name:"
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    puts "nd- delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    selection = gets.chomp
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
      end
  end
end
