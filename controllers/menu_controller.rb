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
  end

  def read_csv
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
      when 'e'
      when 'm'
        system "clear"
        main_menu
      else
        system 'clear'
        puts '#{selection} is not a valid input'
        entry_submenu(entry)
    end
  end
end
