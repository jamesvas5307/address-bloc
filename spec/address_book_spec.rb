require_relative '../models/address_book'

RSpec.describe AddressBook do
  let(:book) {AddressBook.new}
  describe "attributes" do
    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      expect(book.entries).to be_an(Array)
  end

    it "intiializes entries as empty" do
      expect(book.entries.size).to eq(0)
    end
  end
  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry("Ada Love Lace", "010.012.1815", "augusta.king@lovelace.com")
      expect(book.entries.size).to eq(1)
    end

    it "adds correct information to entries" do
      book.add_entry("Ada Love Lace", "010.012.1815", "augusta.king@lovelace.com")
      new_entry = book.entries[0]

      expect(new_entry.name).to eq("Ada Love Lace")
      expect(new_entry.email).to eq("augusta.king@lovelace.com")
      expect(new_entry.phone_number).to eq("010.012.1815")
    end
  end

  describe "#remove_entry" do
    it "should remove one entry from the address book" do
      name ="Ada Love Lace"
      phone_number = "010.012.1815"
      email = "augusta.king@lovelace.com"
      book.add_entry(name, phone_number, email)
      book.remove_entry(name,phone_number,email)
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#import_from_csv" do
    it "imports the correct number of entries" do
      book.import_from_csv('entries.csv')
      book_size = book.entries.size
      expect(book_size).to eq 5
    end

    def check_entry(entry, expected_name, expected_number, expected_email)
     expect(entry.name).to eq expected_name
     expect(entry.phone_number).to eq expected_number
     expect(entry.email).to eq expected_email
   end

   it 'imports the 1st entry' do
     book.import_from_csv("entries.csv")

     entry_one = book.entries[0]
     check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
   end

   it "imports the 2nd entry" do
       book.import_from_csv("entries.csv")
       # Check the second entry
       entry_two = book.entries[1]
       check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       # Check the third entry
       entry_three = book.entries[2]
       check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       # Check the fourth entry
       entry_four = book.entries[3]
       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "imports the 5th entry" do
       book.import_from_csv("entries.csv")
       # Check the fifth entry
       entry_five = book.entries[4]
       check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end


     it "imports second CSV file" do
       book.import_from_csv("entries_2.csv")
       book_size = book.entries.count
       expect(book_size).to eq 3
     end

     it "imported the 1st entry from second file" do
       book.import_from_csv("entries_2.csv")
       entry_one = book.entries[0]
       check_entry(entry_one,"Daenerys Targayen","444-444-4444", "daenerys@motherofdragons.com")
     end

     it "imported the 2nd entry from second file" do
       book.import_from_csv("entries_2.csv")
       entry_two = book.entries[1]
       check_entry(entry_two,"Jon Snow","111-111-1111", "jon@knowsnothing.com")
     end

     it "imported the 3rd entry from second file" do
       book.import_from_csv("entries_2.csv")
       entry_three = book.entries[2]
       check_entry(entry_three,"Tyrion Lannister","555-555-5555", "tyrion@impsdelight.net")
     end
   end
 end
