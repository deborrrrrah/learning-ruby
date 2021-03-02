# Final Project in Advanced Level
## Problem Description
I have a huge collection of books at my home. Most of the time it’s hard to find the books I want and sorting the books takes too much time. I want a simple catalogue where I can just register my book collection and find them for later reads. 

I have limited room capacity and for now, and can only buy a limited number of bookshelves (n). I don’t know how big each shelf that I will buy, but all of them should have the same size of ‘x’ rows and can store ‘y’ books in a row. Since the budget is limited, so ‘n’, ‘x’, and ‘y’ will definitely be less than 100 each.

Each shelf will be coded by a number starting with 1. And each row and column on each shelf will also be coded by a number starting 1. A slot for one book will have its own address by the combination of all three. For example, given a shelf with id 1 with 3 rows and 4 columns, the address for each slot will look like:
```
010101 010102 010103 010104 
010201 010202 010203 010204 
010301 010302 010303 010304
```
That way I can translate the slot address easily, since “010203” should mean shelf 1, row 2, and column 3. 
When I input the book ISBN, title, and author, it will automatically be assigned to the next empty slot on my shelf, and I can see the slot address it’s put into. 

I can take out a book by giving the slot address. 
I will also notify the system when I need to take out the book from the shelf, so it will know that there’s an additional empty slot that can be used by the next book I put. 
The requirements are:
1. Store books into the shelf's slot address
2. Find the slot address of a first book with a given ISBN
3. List of all books (ISBN, title, author) and their slot addresses
4. Search the books by title keyword
5. Search the books by author keyword
I want the system to be interactive where I can give the command one by one. 


## Dev Setup
Ruby 2.7.1
Rbenv 1.1.2

## Instructions
1. Install the needed gems.
```
bundle install
```
2. Run the testing code by using 
```
rspec -fd
```
3. Run the app by using 
```
ruby main.rb
```

## Class diagram
<img src="docs/class-v3.png" width=1000>

## Command examples
```
build_library|2|1|3 
// Shelf 1 with 1 rows and 3 columns is added 
// Shelf 2 with 1 rows and 3 columns is added 

put_book|9780747532743|Harry Potter 1|J. K. Rowling 
// Allocated address: 010101 

put_book|9780807281918|Harry Potter 2|J. K. Rowling 
// Allocated address: 010102 

put_book|9780739330944|Eragon 1|Christopher Paolini 
// Allocated address: 010103 

put_book|9780545582933|Harry Potter 3|J. K. Rowling 
// Allocated address: 020101 

put_book|9780132350884|Clean Code|Robert Cecil Martin 
// Allocated address: 020102 

put_book|9780201485677|Refactoring|Martin Fowler, Kent Beck
// Allocated address: 020103

take_book_from|020102 
// Slot 020102 is free 

take_book_from|010102 
// Slot 010102 is free 

put_book|9780132350884|Clean Code|Robert Cecil Martin 
// Allocated address: 010102 

put_book|9780807281918|Harry Potter 2|J. K. Rowling 
// Allocated address: 020102

put_book|9780321146533|TDD: By Example|Kent Beck 
// All shelves are full! 

take_book_from|999999 
// Invalid code! 

find_book|9780807281918 
// Found the book at 020102 

find_book|000 
// Book not found! 

list_books 
// 010101: 9780747532743 | Harry Potter 1 | J. K. Rowling 
// 010102: 9780132350884 | Clean Code | Robert Cecil Martin 
// 010103: 9780739330944 | Eragon 1 | Christopher Paolini 
// 020101: 9780545582933 | Harry Potter 3 | J. K. Rowling 
// 020102: 9780807281918 | Harry Potter 2 | J. K. Rowling \
// 020103: 9780201485677 | Refactoring | Martin Fowler, Kent Beck 

search_books_by_title|Harry Potter 
// 010101: 9780747532743 | Harry Potter 1 | J. K. Rowling 
// 020101: 9780545582933 | Harry Potter 3 | J. K. Rowling 
// 020102: 9780807281918 | Harry Potter 2 | J. K. Rowling

search_books_by_author|Kent Beck 
// 020103: 9780201485677 | Refactoring | Martin Fowler, Kent Beck 

search_books_by_author|Tolkien 
Book not found! 

exit
```