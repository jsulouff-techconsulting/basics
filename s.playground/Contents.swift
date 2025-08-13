var repition_counter = 0;
let print_counts = 45 // How many times to print the statement

// Will iterate over every number less than 45 starting from zero
for i in 0..<print_counts {
    repition_counter += 1;
    print("There will be 45 of these, starting from 0: " + String(i))
}

print("Ran " + String(repition_counter) + " times.")

var a:UInt8 = 255
//a += 1 //this will crash
// Swift throws an exception for overflows

a -= 1
print(String(a)) // Show that the value has changed

/*
 
 Multi
 Line
 Comment
 
 */


let word:String = "labubu" // A string is a series of characters. Textual data.
let word_2 = "bridge"



let floating_point = 5.333 // A floating point value represents a wide range of real numbers
let fp2 = -2.62

let chara:Character = "b" // A character is a single alphanumeric or symbol. It is a segment of text
let wrong = false
