# Video Structured Summary

> Total 7 chapters

## Table of Contents

1. Course Opening and Introduction to JavaScript [00:00-30:28]
2. Locating JS Code Errors by Line Number [30:28-47:00]
3. Getting User Input from HTML Elements [47:00-59:49]
4. Explaining How to Use dataset Data Attributes [59:49-91:49]
5. Explaining Similarities and Differences Between JSON and JS Object Syntax [91:49-95:31]
6. Building the Basic Structure of a Currency Exchange Page [95:31-105:35]
7. Validating the Currency Entered by the User [105:35-111:23]

---

---

## Course Opening and Introduction to JavaScript [00:00-30:28]

### Timeline Narrative

**[00:00-00:17] | Course Opening and Topic Introduction**
- The screen displays the course title, the names "Brian Yu" and "David J. Malan", and their email addresses.
- The instructor stands in front of a wooden background and announces that today's class will turn to the second major programming language of the course, JavaScript.

**[00:17-01:15] | Why JavaScript Is Needed: The Client and Server Model**
- The instructor reviews the basic model of internet communication: the user, or client, sends HTTP requests through a browser such as Chrome or Safari to a web server, and the server processes the request and returns a response, usually an HTML template.
- All previous code, such as Django Web applications, ran on the server side, listening for requests, performing computations, and generating responses.
- JavaScript lets us start writing **client-side code**, code that actually runs in the user's browser.

**[01:15-02:00] | JavaScript's Advantages: Client-side Computation and DOM Manipulation**
- Advantage one: it can perform computations directly on the client, without communicating with the server, which makes it faster.
- Advantage two: it makes web pages more interactive. JavaScript can directly manipulate the **DOM, Document Object Model**, the tree-like hierarchy that represents the content of a web page.
- With JavaScript, we can write code that directly changes the content of a web page.

**[02:00-03:11] | Adding JavaScript to HTML: The script Tag and alert Function**
- To add JavaScript to an HTML page, use the `<script>` tag. The browser interprets the content inside the tag as JavaScript code and runs it.
- First program example: use the `alert` function to display a popup.
```html
<script>
alert('Hello, world!');
</script>
```
- `alert` is a built-in browser function that takes a string argument and displays a popup message in the user's browser.

**[03:11-04:44] | Creating the First JavaScript Page**
- Create a file named `hello.html` with the basic HTML structure:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Hello</title>
</head>
<body>
    <h1>Hello!</h1>
</body>
</html>
```
- Add a `<script>` tag inside `<head>` and write `alert('Hello, world!');`.
- After the page opens, the browser displays the popup "This page says hello world". Once the user clicks the "OK" button, the popup disappears and the original page appears.

**[04:44-06:02] | The Concept of Event-driven Programming**
- The power of JavaScript comes from **event-driven programming**: treating web page interaction as a series of events.
- Event examples include the user clicking a button, choosing from a dropdown list, scrolling a list, submitting a form, and more.
- By adding **event listeners, or event handlers**, we can run a specific block of code or a function when an event occurs.

**[06:02-07:52] | Creating a Function and a Button Click Event**
- Put `alert` inside a custom function:
```html
<script>
function hello() {
    alert('Hello, world!');
}
</script>
```
- Function definition: use the `function` keyword, followed by the function name, parentheses for the parameter list, and braces for the function body.
- Add a button in HTML and bind the function through the `onclick` attribute:
```html
<button onclick="hello()">Click Here</button>
```
- When the button is clicked, the browser calls the `hello()` function and displays the popup.

**[07:52-09:00] | Function Call Syntax and Event Handler Workflow**
- To call a function, write the function name followed by parentheses: `hello()`. Arguments can be passed inside the parentheses.
- Event handler workflow: the button's `onclick` attribute specifies which function should run when the button is clicked, and the function definition specifies exactly what the function does.
- Each button click calls the function again, so the popup appears every time.

**[09:00-10:35] | Overview of JavaScript Language Features and Variables**
- JavaScript has the same kinds of language features as other programming languages, such as Python: data types, including strings, built-in functions such as `alert`, custom functions, and variables.
- Create a new file named `counter.html` to implement a counter.
- Define a variable: use the `let` keyword to declare and initialize it.
```javascript
let counter = 0;
```

**[10:35-12:14] | Counter Function and Variable Operations**
- Define a `count` function that increments the counter and displays a popup:
```javascript
function count() {
    counter++;
    alert(counter);
}
```
- Ways to increment: `counter = counter + 1`, `counter += 1`, and `counter++`, with the shorthand recommended.
- Add a button in HTML and bind the function:
```html
<button onclick="count()">Count</button>
```
- Each time the button is clicked, the counter increases from 0 and the popup shows the current value, such as 1, 2, 3, and so on.

**[12:14-13:04] | From Popups to DOM Manipulation: Updating Web Page Content**
- Using only popups for interaction creates a poor user experience. A better approach is to update the web page content directly.
- JavaScript can manipulate the DOM, Document Object Model, the tree structure that represents all elements on the page.

**[13:04-15:50] | Using querySelector to Select an Element and Change innerHTML**
- Return to `hello.html` and modify the `hello` function: instead of displaying a popup, it changes a page element.
- Use `document.querySelector('h1')` to select the `<h1>` element on the page.
- Change the element's `innerHTML` property to change its content:
```javascript
function hello() {
    document.querySelector('h1').innerHTML = 'Goodbye!';
}
```
- After the button is clicked, "Hello!" on the page becomes "Goodbye!".

**[15:50-17:00] | Implementing a Hello and Goodbye Toggle: Conditional Statements**
- The goal is for each button click to switch between "Hello" and "Goodbye".
- Use a conditional statement, `if` and `else`, to implement it:
```javascript
function hello() {
    if (document.querySelector('h1').innerHTML === 'Hello!') {
        document.querySelector('h1').innerHTML = 'Goodbye!';
    } else {
        document.querySelector('h1').innerHTML = 'Hello!';
    }
}
```
- Use the **strict equality operator** `===` to check whether both the value and type are the same. This is recommended because it avoids type conversion issues.

**[17:00-18:42] | Strict Equality and Loose Equality**
- JavaScript provides two kinds of equality checks:
  - `===`, strict equality: both value and type must match.
  - `==`, loose equality: only the value is checked, and type conversion is allowed.
- `===` is recommended to make sure both type and value match.

**[18:42-21:28] | Optimizing Code: Reducing Repeated querySelector Calls**
- In the current code, `document.querySelector('h1')` is called three times, which is inefficient.
- Optimization approach: store the query result in a variable and query only once.
```javascript
function hello() {
    let heading = document.querySelector('h1');
    if (heading.innerHTML === 'Hello!') {
        heading.innerHTML = 'Goodbye!';
    } else {
        heading.innerHTML = 'Hello!';
    }
}
```

**[21:28-22:36] | Using const to Declare Constants**
- If a variable's value will never be reassigned, use `const` instead of `let`.
- `const` makes sure the variable cannot be accidentally changed, which improves code safety.
```javascript
function hello() {
    const heading = document.querySelector('h1');
    if (heading.innerHTML === 'Hello!') {
        heading.innerHTML = 'Goodbye!';
    } else {
        heading.innerHTML = 'Hello!';
    }
}
```

**[22:36-24:12] | Improving the Counter Program: DOM Updates Instead of Popups**
- Return to `counter.html` and improve the counter by using DOM updates instead of popups.
- Set the initial content of `<h1>` to "0", then update its content to the counter value each time the button is clicked.
```javascript
let counter = 0;

function count() {
    counter++;
    document.querySelector('h1').innerHTML = counter;
}
```
- The page displays the counter value updating in real time, 0 to 1 to 2 to 3, and so on.

**[24:12-26:35] | Adding Conditional Logic: Displaying a Popup Every 10 Counts**
- Add a condition: display a popup when the counter is a multiple of 10.
- Use the modulo operator `%` to determine whether the counter is divisible by 10:
```javascript
function count() {
    counter++;
    document.querySelector('h1').innerHTML = counter;
    if (counter % 10 === 0) {
        alert(`Count is now ${counter}`);
    }
}
```
- Use a **template literal**, backticks `` ` ``, and `${}` syntax to embed variables in a string, similar to Python's f-string.

**[26:35-28:55] | Separating JavaScript from HTML: Using the onclick Attribute**
- The current code writes `onclick="count()"` in HTML, which couples JavaScript with HTML.
- Improvement: select the button in JavaScript with `document.querySelector`, then set its `onclick` attribute.
```javascript
document.querySelector('button').onclick = count;
```
- Note: here `count` is the function name without parentheses. This assigns the function itself to the `onclick` property instead of calling the function.
- Functions can be passed as values. This is a core idea in **functional programming**.

**[28:55-30:28] | Debugging: The JavaScript Console and Common Errors**
- After the modified code runs, clicking the button has no effect.
- Open the browser developer tools, right click in Chrome, choose Inspect, then open the Console tab to view the error message.
- The console displays the error: `Uncaught TypeError: cannot set property 'onClick' of null`.
- Cause of the error: `document.querySelector('button')` returns `null` because the button element does not exist yet when the page loads, since the script runs before the button.
- Solutions will be explained in later parts of the lecture, such as placing the script at the bottom of the page or using the `DOMContentLoaded` event.

### Key Points Summary

This chapter introduces the core concepts of JavaScript as a client-side programming language, including embedding JavaScript code in HTML with the `<script>` tag, using the `alert` function to display popups, defining and calling functions, binding event handlers with the `onclick` attribute, declaring variables with `let` and `const`, manipulating DOM elements with `querySelector` and `innerHTML`, using conditional statements with `if/else`, using the strict equality operator `===`, using template literals, and treating functions as values in functional programming. It ends with a debugging segment that shows how to use the JavaScript console.

![00:00](../总结导出案例/lecture5-720p-en_summary/slides/slide_000.png)
![07:40](../总结导出案例/lecture5-720p-en_summary/slides/slide_024.cropped.png)
![16:30](../总结导出案例/lecture5-720p-en_summary/slides/slide_048.cropped.png)


---

## Locating JS Code Errors by Line Number [30:28-47:00]

### Timeline Narrative

**[30:28-31:00] | Error Location and Analysis**
- The browser console reports an error: `Uncaught TypeError: Cannot set property 'onclick' of null at counter.html:18`
- The error message clearly indicates that the problem comes from line 18 of the `counter.html` file and involves trying to access the `onClick` property of `null`.
- `null` is a special value in JavaScript that means "nothing" or "no object exists".
- View the code on line 18:
```javascript
document.querySelector('button').onclick = count;
```
- The problem is that `document.querySelector('button')` returned `null`, which means it failed to find the `<button>` element on the page.

**[31:00-32:10] | Root Cause: DOM Loading Order**
- The page does contain a `<button>` element, located on line 24:
```html
<button>Count</button>
```
- The browser runs code line by line from top to bottom. When it reaches line 18 of the JavaScript, the `<button>` element on line 24 has not yet been parsed or loaded into the DOM.
- When JavaScript searches for the button, the DOM, Document Object Model, has not finished loading, so it cannot find the element.
- This is part of how browsers work: code runs in order, so if a script runs before it encounters an element, it will not find that element.

**[32:10-33:00] | Solution One: Move the script Tag**
- The first strategy is to move the `<script>` tag to the bottom of `<body>`, making sure all HTML elements are defined first.
- Modified HTML structure:
```html
<body>
    <h1>0</h1>
    <button>Count</button>
    <script>
        document.querySelector('button').onclick = count;
    </script>
</body>
```
- With this structure, when JavaScript runs, the button already exists in the DOM and can be found successfully.

**[33:00-34:10] | Solution Two: Use the DOMContentLoaded Event**
- A more common approach is to add an event listener to the entire `document` object.
- `document` is a built-in JavaScript variable that represents the whole web page document.
- Use `document.addEventListener('DOMContentLoaded', callback)` to listen for the event that fires when the DOM has finished loading.
- The `DOMContentLoaded` event fires after the DOM structure has fully loaded.
- Syntax structure:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    // Code to execute after the DOM has loaded
});
```
- `addEventListener` accepts two arguments: the first is the event name, and the second is the function to execute when the event fires.

**[34:10-35:40] | Using Anonymous Functions**
- The second argument can be an anonymous function, a function without a name.
- Syntax example:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('button').onclick = count;
});
```
- The function has no name because it does not need to be referenced elsewhere.
- The function body is wrapped in braces `{}` and contains all the code that needs to run after the DOM has loaded.
- This syntax is very common in JavaScript.

**[35:40-36:40] | Two Ways to Write Event Listeners**
- You can use `addEventListener` to add a click event:
```javascript
document.querySelector('button').addEventListener('click', count);
```
- You can also use the shorter form:
```javascript
document.querySelector('button').onclick = count;
```
- Both approaches have the same effect, while the shorter form is more concise.
- After using `DOMContentLoaded`, refreshing the page removes the JavaScript error and the counter works correctly.

**[36:40-38:30] | Separating JavaScript into an Independent File**
- Similar to how CSS can be separated into its own file, JavaScript can be separated as well.
- Create a new file named `counter.js` and move the JavaScript code into it:
```javascript
let counter = 0;

function count() {
    counter++;
    document.querySelector('h1').innerHTML = counter;
    if (counter % 10 === 0) {
        alert(`Count is now ${counter}`);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('button').onclick = count;
});
```
- In HTML, use the `src` attribute of the `<script>` tag to reference the external file:
```html
<script src="counter.js"></script>
```
- This keeps the HTML file cleaner, containing only structure and content.

**[38:30-39:30] | Benefits of Separating JavaScript**
- During collaboration, different people can work on the HTML and JavaScript files separately.
- If JavaScript changes often while HTML changes less often, the JS file can be loaded separately.
- Multiple HTML pages can share the same JavaScript file, avoiding repeated code.
- It is convenient to include third-party JavaScript libraries, such as Bootstrap's JS, by adding a `<script>` tag that references the source file.

**[39:30-41:00] | Form Interaction Example**
- Create a more interactive page: the user fills out a form, and JavaScript responds to the input.
- Return to `hello.html` and add a form inside `<body>`:
```html
<body>
    <h1>Hello!</h1>
    <form>
        <input autofocus id="name" placeholder="Name" type="text">
        <input type="submit">
    </form>
</body>
```
- `placeholder="Name"` displays hint text.
- `id="name"` gives the input field a unique identifier so JavaScript can locate it.

**[41:00-42:40] | Handling the Form Submit Event**
- Use `DOMContentLoaded` to make sure the code runs after the DOM has loaded.
- Get the form element and set its `onsubmit` event handler:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('form').onsubmit = function() {
        // Code to execute when the form is submitted
    };
});
```
- Use an anonymous function as the value of the `onsubmit` property.
- When the user submits the form, this function is called automatically.

**[42:40-44:50] | Selector Syntax for querySelector**
- `document.querySelector()` can locate elements with CSS selector syntax.
- Three main selection methods:
  - Tag selector: `document.querySelector('tag')`, gets the first matching tag element.
  - ID selector: `document.querySelector('#id')`, gets the element with the specified ID.
  - Class selector: `document.querySelector('.class')`, gets the element with the specified class.
- This is exactly the same as CSS selector syntax.
- When the page has multiple elements with the same tag, ID or class selectors are more precise.

**[44:50-46:30] | Getting an Input Value and Displaying It**
- Use an ID selector to get the input field:
```javascript
const name = document.querySelector('#name').value;
```
- The `.value` property gets the actual content the user typed in the input field.
- Use `const` to declare the variable because it does not need to be reassigned.
- Use a template string to display the greeting:
```javascript
alert(`Hello, ${name}!`);
```
- Backticks, `` ` ``, wrap the string, and `${}` syntax inserts the variable value.

**[46:30-47:00] | Running the Complete Example**
- Complete code:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('form').onsubmit = function() {
        const name = document.querySelector('#name').value;
        alert(`Hello, ${name}!`);
    };
});
```
- After refreshing the page, type a name such as "Brian" in the input field and click the submit button.
- A warning box appears and displays "Hello, Brian!".
- Type another name such as "David" and submit again, and it displays "Hello, David!".
- This successfully combines event listeners, functions, and querySelector.

### Key Points Summary

This chapter explains how to use browser console error messages to locate problems in JavaScript code. The key is understanding the `null` reference error caused by DOM loading order. It introduces two solutions: move the `<script>` tag to the bottom of `<body>`, or use the `DOMContentLoaded` event to make sure the code runs after the DOM has loaded. It also covers separating JavaScript into an independent file, using `querySelector` with CSS selector syntax to locate elements, getting input values, and responding to user interactions.

![30:30](../总结导出案例/lecture5-720p-en_summary/slides/slide_072.cropped.png)
![37:10](../总结导出案例/lecture5-720p-en_summary/slides/slide_084.png)
![42:20](../总结导出案例/lecture5-720p-en_summary/slides/slide_096.cropped.png)


---

## Getting User Input from HTML Elements [47:00-59:49]

### Timeline Narrative

**[47:00-47:38] | Review and Introduction: From Getting User Input to Changing CSS Styles**
- Reviews previously learned content: using `document.querySelector('#name').value` to get what the user typed in an input field, combined with event listeners and `alert` to create a dynamic response.
- Points out that beyond changing the content of HTML elements, JavaScript can also change CSS style properties by changing an element's `style` property.

**[47:38-48:27] | Creating an Example Page: colors.html**
- Create a new file named `colors.html` with a standard HTML template.
- Add an `<h1 id="hello">Hello!</h1>` heading inside `<body>`, along with three buttons: `<button>Red</button>`, `<button>Blue</button>`, and `<button>Green</button>`.
- Open the page in the browser. It displays the large heading "Hello!" and three buttons, but the buttons do not have functionality yet.

**[48:27-49:16] | Adding JavaScript Event Listeners and Assigning IDs to Buttons**
- Add a `<script>` tag to the page and use `document.addEventListener('DOMContentLoaded', function() { ... })` to make sure the code runs after the DOM has loaded.
- Assign a unique ID to each button so it can be referenced in JavaScript:
```html
<button id="red">Red</button>
<button id="blue">Blue</button>
<button id="green">Green</button>
```

**[49:16-50:36] | Writing a Click Event Handler Function for Each Button**
- Use `document.querySelector('#red').onclick = function() { ... }` to add a click event to the red button.
- Inside the function, change the heading color with `document.querySelector('#hello').style.color = 'red';`.
- Use double slashes `//` to add comments, e.g. `// Change font color to red`.
- Write similar code for the blue and green buttons:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    // Change font color to red
    document.querySelector('#red').onclick = function() {
        document.querySelector('#hello').style.color = 'red';
    }
    // Change font color to blue
    document.querySelector('#blue').onclick = function() {
        document.querySelector('#hello').style.color = 'blue';
    }
    // Change font color to green
    document.querySelector('#green').onclick = function() {
        document.querySelector('#hello').style.color = 'green';
    }
});
```

**[50:36-51:45] | Demonstrating the Effect**
- After refreshing the page, the default heading is black.
- Click the red button and the heading becomes red; click the blue button and the heading becomes blue; click the green button and the heading becomes green.
- The demonstration shows that clicking a button triggers an event listener, runs the function, gets the H1 element whose ID is `hello`, and changes its `style.color` property.

**[51:45-52:29] | Code Repetition and an Optimization Idea**
- The current code has repetition: three buttons require almost identical code, which is poor design.
- Proposed improvement: combine the three event listeners into one function and change the color based on the button's instruction.
- Core question: when a button is clicked, how can the button know which color the text should become?

**[52:29-53:26] | Introducing Data Attributes**
- Solution: add custom data attributes to HTML elements.
- Data attribute format: start with `data-`, followed by a custom name, e.g. `data-color`.
- Add a data attribute to each button:
```html
<button data-color="red">Red</button>
<button data-color="blue">Blue</button>
<button data-color="green">Green</button>
```
- With data attributes, JavaScript can access `button.dataset.color` to get the corresponding color value.

**[53:26-54:31] | Using querySelectorAll to Get All Buttons**
- `document.querySelector` returns only the first matching element.
- Use `document.querySelectorAll` to return an array-like collection, a NodeList, of all matching elements.
- Example: `document.querySelectorAll('button')` returns a NodeList containing the three buttons.
- Test in the browser console:
```javascript
document.querySelector('button')
// Returns the first button: <button data-color="red">Red</button>

document.querySelectorAll('button')
// Returns NodeList(3): [button, button, button]
```

**[54:31-56:11] | JavaScript Array Basics**
- Demonstrate array operations in the console:
```javascript
const names = ["Harry", "Ron", "Hermione"];
names[0];  // "Harry"
names[1];  // "Ron"
names[2];  // "Hermione"
names.length;  // 3
```
- Array indexing starts at 0. Use square brackets `[]` to access elements, and the `length` property to get the array length.

**[56:11-57:24] | Iterating over Buttons with forEach**
- The NodeList returned by `querySelectorAll` supports the `forEach` method.
- `forEach` takes a function as an argument and runs that function once for each element in the array.
- Syntax: `document.querySelectorAll('button').forEach(function(button) { ... })`
- During iteration, the `button` parameter represents the button element currently being processed.

**[57:24-59:49] | Complete Optimized Code Implementation**
- In the `forEach` callback function, add a click event handler to each button:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('button').forEach(function(button) {
        button.onclick = function() {
            document.querySelector('#hello').style.color = button.dataset.color;
        };
    });
});
```
- Code execution flow:
  1. After the page finishes loading, the `DOMContentLoaded` event fires.
  2. `document.querySelectorAll('button')` gets all buttons.
  3. `forEach` iterates over each button and adds an `onclick` event handler to each one.
  4. When a button is clicked, the code gets the element with ID `hello` and sets its color to `button.dataset.color`, the value of the button's `data-color` attribute.
- Through data attributes, each button carries its own color information. There is no need to write separate event handling code for each button, which allows code reuse.

### Key Points Summary

This chapter demonstrates how to use JavaScript to get HTML elements and change their CSS style properties. It focuses on using `querySelectorAll` and `forEach` to iterate over multiple elements, and using HTML data attributes to attach custom data to elements for more efficient, maintainable code. The core learning goals include understanding how to change CSS through the `style` property, mastering the difference between `querySelectorAll` and `querySelector`, learning how to iterate over a NodeList with `forEach`, and using data attributes to store and access information related to elements.

![47:00](../总结导出案例/lecture5-720p-en_summary/slides/slide_108.cropped.png)
![51:10](../总结导出案例/lecture5-720p-en_summary/slides/slide_116.cropped.png)
![54:30](../总结导出案例/lecture5-720p-en_summary/slides/slide_124.cropped.png)


---

## Explaining How to Use dataset Data Attributes [59:49-91:49]

### Timeline Narrative

**[59:49-60:17] | Using the dataset Property to Simplify Event Handling**
- Background: previously, separate event handler functions were written for each color button, red, blue, and green, which made the code redundant.
- Goal: use HTML `data-*` attributes and JavaScript's `dataset` object to combine three event handler functions into one general function.
- Specific implementation: add the `data-color` attribute to the HTML buttons, use `button.dataset.color` in JavaScript to get the corresponding color value, and set the text color of the `#hello` element.
- Code example:
```html
<button data-color="red">Red</button>
<button data-color="blue">Blue</button>
<button data-color="green">Green</button>
```
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('button').forEach(function(button) {
        button.onclick = function() {
            document.querySelector('#hello').style.color = button.dataset.color;
        }
    });
});
```
- Effect: no matter which button is clicked, the color changes correctly and the amount of code is greatly reduced.

**[60:17-61:21] | Debugging with the JavaScript Console**
- Background: developers need to understand variable state and DOM element selection results at runtime.
- Goal: demonstrate how to use the browser JavaScript console for live debugging and variable modification.
- Specific actions:
  - Open the console with F12 and directly enter `counter = 27` to change the variable value.
  - The page does not update immediately, but the next time the `count` function is triggered, it increments from the modified value, 27, to 28.
  - Use `document.querySelector` to test which element a selector returns.
- Conclusion: the console is a powerful tool for debugging programs, verifying variable values, and checking selector results.

**[61:21-62:29] | Arrow Function Syntax**
- Background: ES6 introduced a more concise way to define functions.
- Goal: introduce arrow functions as shorthand for the traditional `function` keyword.
- Syntax rules:
  - No parameters: `() => { ... }`
  - One parameter: `button => { ... }`, with parentheses optional.
  - Multiple parameters: `(a, b) => { ... }`
- Example comparison:
```javascript
// Traditional syntax
document.querySelectorAll('button').forEach(function(button) { ... });

// Arrow function syntax
document.querySelectorAll('button').forEach(button => { ... });
```
- Explanation: the left side of the arrow contains the input parameters, and the right side contains the function body code.

**[62:29-65:46] | Using a Dropdown Menu, select, Instead of Buttons**
- Background: when there are many options, a group of buttons is less concise than a dropdown menu.
- Goal: change the color selector from three buttons to a single `<select>` dropdown menu, and learn the `onchange` event and the `this` keyword.
- HTML structure:
```html
<select>
    <option value="black">Black</option>
    <option value="red">Red</option>
    <option value="blue">Blue</option>
    <option value="green">Green</option>
</select>
```
- JavaScript implementation:
```javascript
document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('select').onchange = function() {
        document.querySelector('#hello').style.color = this.value;
    }
});
```
- Key concepts:
  - `onchange` event: fires when the dropdown menu selection changes.
  - `this` keyword: inside an event handler function, `this` points to the element that triggered the event, here the `<select>`.
  - `this.value`: gets the `value` attribute of the currently selected option.
- Effect: when the user chooses a different color, the heading text color changes in real time.

**[65:46-66:29] | Overview of Common Event Types**
- Background: JavaScript supports many types of user interaction events.
- Goal: list common event types to prepare for building more complex applications later.
- Event list:
  - `onclick`: mouse click
  - `onmouseover`: mouse hover
  - `onkeydown`: keyboard key pressed down
  - `onkeyup`: keyboard key released
  - `onload`: page or element finished loading
  - `onblur`: element loses focus
- Explanation: developers can listen for these events and write response functions to create rich user interactions.

**[66:29-68:08] | Building a To-do List Application, HTML Structure**
- Background: start building a pure JavaScript to-do list application.
- Goal: build the HTML skeleton with a title, a task list container, and a form.
- HTML code:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tasks</title>
</head>
<body>
    <h1>Tasks</h1>
    <ul id="tasks"></ul>
    <form>
        <input id="task" placeholder="New Task" type="text">
        <input type="submit">
    </form>
</body>
</html>
```
- Explanation: `<ul id="tasks">` is used to dynamically display the task list, and the form is used to enter and submit new tasks.

**[68:08-70:03] | Form Submit Event Handling and console.log Debugging**
- Background: we need to capture the form submit event and get the task content entered by the user.
- Goal: add an event listener, prevent the default form submission behavior, and output the input value to the console.
- JavaScript code:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('form').onsubmit = () => {
        const task = document.querySelector('#task').value;
        console.log(task);
        // Stop form from submitting
        return false;
    }
});
```
- Key points:
  - `document.querySelector('#task').value`: gets the current value of the input field.
  - `console.log(task)`: outputs the task content to the console for debugging.
  - `return false`: prevents the form's default submission behavior, page refresh, and enables client-side handling.

**[70:03-72:19] | Dynamically Creating and Adding DOM Elements**
- Background: printing only to the console is not enough. The task needs to actually appear on the page.
- Goal: use `document.createElement` to create a new list item and add it to the DOM with `appendChild`.
- Code implementation:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('form').onsubmit = () => {
        const task = document.querySelector('#task').value;
        const li = document.createElement('li');
        li.innerHTML = task;
        document.querySelector('#tasks').appendChild(li);
        // Stop form from submitting
        return false;
    }
});
```
- Step explanation:
  1. `document.createElement('li')`: creates a new `<li>` element.
  2. `li.innerHTML = task`: sets the user's task text as the content of the list item.
  3. `document.querySelector('#tasks').appendChild(li)`: adds the new list item to the end of `<ul id="tasks">`.
- Effect: after the form is submitted, the new task immediately appears on the page.

**[72:19-73:20] | Clearing the Input Field**
- Background: after a task is submitted, the input field still contains the previous text, which is a poor user experience.
- Goal: automatically clear the input field after submission.
- Code change:
```javascript
document.querySelector('#task').value = '';
```
- Complete code snippet:
```javascript
document.querySelector('form').onsubmit = () => {
    const task = document.querySelector('#task').value;
    const li = document.createElement('li');
    li.innerHTML = task;
    document.querySelector('#tasks').appendChild(li);
    document.querySelector('#task').value = '';
    return false;
}
```
- Effect: after the task is submitted, the input field immediately becomes empty, making it easy to enter the next task.

**[73:20-75:00] | Disabling the Submit Button, Initial State**
- Background: the user might submit an empty string, causing an empty list item to appear.
- Goal: disable the submit button by default to prevent empty submissions.
- Steps:
  1. Add an `id` attribute to the submit button: `<input id="submit" type="submit">`
  2. Set the initial disabled state in JavaScript:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('#submit').disabled = true;
    // ... Other code
});
```
- Effect: after the page loads, the submit button is gray and cannot be clicked.

**[75:00-76:39] | Enabling the Submit Button Based on Input, onkeyup Event**
- Background: when the user starts typing, the submit button should be enabled.
- Goal: listen for the keyboard key release event, `onkeyup`, and enable the button when the input field has content.
- Code implementation:
```javascript
document.querySelector('#task').onkeyup = () => {
    document.querySelector('#submit').disabled = false;
};
```
- Effect: as soon as the user presses and releases any key in the input field, the submit button becomes available.

**[76:39-77:06] | Disabling the Button Again After Submission**
- Background: after a task is submitted, the button should become disabled again.
- Goal: at the end of the form submit handler, set the button back to disabled.
- Code change:
```javascript
document.querySelector('form').onsubmit = () => {
    const task = document.querySelector('#task').value;
    const li = document.createElement('li');
    li.innerHTML = task;
    document.querySelector('#tasks').appendChild(li);
    document.querySelector('#task').value = '';
    document.querySelector('#submit').disabled = true;
    return false;
};
```
- Effect: after submission, the button immediately turns gray until the user types again.

**[77:06-78:33] | Conditional Optimization: Disable the Button When Input Is Empty**
- Background: if the user enters text and then deletes all of it, the button remains enabled and can still submit an empty task.
- Goal: add a condition to the `onkeyup` event so the button is enabled only when the input field length is greater than 0.
- Optimized code:
```javascript
document.querySelector('#task').onkeyup = () => {
    if (document.querySelector('#task').value.length > 0) {
        document.querySelector('#submit').disabled = false;
    } else {
        document.querySelector('#submit').disabled = true;
    }
};
```
- Effect: when the input field has content, the button is enabled; when the content is empty, the button is disabled, fully preventing empty submissions.

**[78:33-79:10] | Summary of JavaScript Interaction Capabilities**
- Background: the to-do list application demonstrates several kinds of JavaScript interaction.
- Summary of capabilities:
  - Responding to user input, keyboard events.
  - Dynamically adding DOM elements, `createElement` and `appendChild`.
  - Changing element styles and properties, `style.color` and `disabled`.
- Conclusion: JavaScript turns a page from static content into a dynamic interactive application.

**[79:10-80:47] | Using setInterval for Automatic Counting**
- Background: the previous counter required the user to manually click a button to increment it.
- Goal: use `setInterval` to make the counter increment automatically every second, without user action.
- Code implementation:
```javascript
let counter = 0;
function count() {
    counter++;
    document.querySelector('h1').innerHTML = counter;
}
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('button').onclick = count;
    setInterval(count, 1000);
});
```
- Explanation:
  - `setInterval(count, 1000)`: runs the `count` function once every 1000 milliseconds, or 1 second.
  - Manual button clicks can still trigger `count`, working alongside the automatic timer.
- Use cases: countdown timers, real-time clocks, and other features that need periodic updates.

**[80:47-82:38] | Introducing localStorage for Data Persistence**
- Background: after the page refreshes, the counter resets to 0 and the state is lost.
- Goal: use `localStorage` to store data in the browser and keep state across page visits.
- Core API:
  - `localStorage.getItem(key)`: gets the stored value by key name.
  - `localStorage.setItem(key, value)`: stores a key-value pair.
- Explanation: `localStorage` stores data in the user's browser. Even if the page is closed and opened again, the data remains.

**[82:38-84:41] | Refactoring the Counter with localStorage**
- Background: the counter needs to remember its previous value.
- Goal: read the counter value from `localStorage` when the page loads, and update storage after each increment.
- Refactored code:
```javascript
if (!localStorage.getItem('counter')) {
    localStorage.setItem('counter', 0);
}

function count() {
    let counter = localStorage.getItem('counter');
    counter++;
    document.querySelector('h1').innerHTML = counter;
    localStorage.setItem('counter', counter);
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('button').onclick = count;
});
```
- Key logic:
  1. On first load, if `localStorage` does not contain the `counter` key, initialize it to 0.
  2. Each time the button is clicked, get the current value from `localStorage`, increment it, then update the page and storage.
- Problem: after refreshing the page it displays 0, but after clicking the button the value is correct, because the page initially displays a hard-coded 0.

**[84:41-86:53] | Fixing the Display Issue When the Page Loads**
- Background: when the page loads, `<h1>` displays a hard-coded 0, which does not match the actual stored value.
- Goal: after the DOM has loaded, immediately read the value from `localStorage` and update the page display.
- Fix code:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('h1').innerHTML = localStorage.getItem('counter');
    document.querySelector('button').onclick = count;
});
```
- Effect: after refreshing the page, `<h1>` directly displays the value stored in `localStorage`, such as 28, instead of showing 0.
- Verification: in Chrome developer tools under Application > Local Storage, you can see the `counter` key and its value.

**[86:53-88:09] | Review of JavaScript Data Types**
- Background: this chapter has covered several JavaScript data types.
- Goal: summarize the data types encountered so far and prepare to introduce object types.
- Data type list:
  - Integers, such as counter values.
  - Strings, such as task text.
  - HTML elements, obtained with `querySelector`.
  - Arrays, such as the NodeList returned by `querySelectorAll`.
  - Functions, which can be assigned to variables.
- Explanation: functions are first-class citizens in JavaScript and can be assigned and passed like other values.

**[88:09-89:30] | JavaScript Objects**
- Background: objects are one of the most useful data types in JavaScript.
- Goal: demonstrate object creation and property access, analogous to Python dictionaries.
- Create an object:
```javascript
let person = {
    first: 'Harry',
    last: 'Potter'
};
```
- Property access methods:
  - Dot notation: `person.first` gives `"Harry"`.
  - Bracket notation: `person['first']` gives `"Harry"`.
- Explanation: an object is a collection of key-value pairs. Keys are called properties, and values can be any data type.

**[89:30-91:49] | Introducing API and JSON**
- Background: objects are very useful for data exchange.
- Goal: introduce the concepts of API, Application Programming Interface, and JSON, JavaScript Object Notation.
- Core concepts:
  - API: a standardized way for services to communicate by sending requests and receiving structured data.
  - JSON: a lightweight data exchange format based on JavaScript object syntax. It is human-readable and machine-parseable.
- JSON example, representing flight information:
```json
{
    "origin": "New York",
    "destination": "London",
    "duration": 415
}
```
- Explanation: JSON requires key names to be wrapped in double quotes, while JavaScript object key names can omit quotes.
- Use cases: Web applications get data from external services such as weather or maps through APIs, and the data format is usually JSON.

### Key Points Summary

1. The `dataset` property and arrow functions simplify event handling by combining several similar event handler functions into one general function.
2. Form event handling, dynamic DOM element creation and insertion, input field clearing, and other core interaction techniques were used to build a complete to-do list application.
3. The `onkeyup` event and conditional logic enable intelligent submit button enabling and disabling, improving the user experience.
4. `setInterval` provides periodic function calls, and `localStorage` provides browser-side data persistence so the counter state remains after page refreshes.
5. JavaScript object syntax was introduced, along with JSON's important role as a data exchange format in API communication.

![60:30](../总结导出案例/lecture5-720p-en_summary/slides/slide_133.cropped.png)
![70:10](../总结导出案例/lecture5-720p-en_summary/slides/slide_150.cropped.png)
![85:20](../总结导出案例/lecture5-720p-en_summary/slides/slide_167.cropped.png)


---

## Explaining Similarities and Differences Between JSON and JS Object Syntax [91:49-95:31]

### Timeline Narrative

**[91:49-92:12] | Comparing JSON and JS Object Syntax**
- The presenter points out that in a JavaScript object, key names can be written without quotes. For example, you can write `origin: "New York"` directly instead of `"origin": "New York"`. JSON, JavaScript Object Notation, requires key names to be wrapped in double quotes. This is the key syntax difference between the two.
- JSON syntax is very similar to JavaScript object syntax. JavaScript can directly parse JSON data and convert it into JavaScript objects. Other programming languages, such as Python, can also parse JSON data, which makes JSON a cross-language data exchange format.
- The screen shows a basic JSON object example:
```json
{
  "origin": "New York",
  "destination": "London",
  "duration": 415
}
```

**[92:13-92:52] | JSON Supports Nested Structures**
- One major advantage of JSON is that it can represent complex data structures. Values can be not only strings or numbers, but also arrays, lists, or nested JavaScript objects.
- The presenter uses flight information as an example to explain how to expand simple string values into nested objects: change `origin` from the string `"New York"` into an object containing the `city` and `code` properties, and do the same for `destination`.
- The screen shows a JSON example with nested structure:
```json
{
  "origin": {
    "city": "New York",
    "code": "JFK"
  },
  "destination": {
    "city": "London",
    "code": "LHR"
  },
  "duration": 415
}
```

**[92:53-93:27] | JSON Data Exchange Conventions and the API Concept**
- The presenter emphasizes that the key to JSON data exchange is that both communicating sides must agree on the data structure in advance, including key names, value types, and the overall structure. The receiving side writes programs based on that agreement to parse and use the data.
- Introduces the concept of an API, Application Programming Interface: online services provide data through APIs, and that data is usually returned in JSON format so machines can read and process it.
- Currency exchange rates are used as an example: exchange rates change in real time, and by calling an online exchange rate API to get the latest data in JSON format, we can develop a real-time currency exchange application.

**[93:28-94:13] | JSON Data Structure Returned by a Currency Exchange Rate API**
- The presenter shows a typical JSON object structure returned by an exchange rate API. It contains a `base` key, representing the base currency, and a `rates` key, containing exchange rates for different currencies.
- The screen shows sample data:
```json
{
  "rates": {
    "EUR": 0.907,
    "JPY": 109.716,
    "GBP": 0.766,
    "AUD": 1.479
  },
  "base": "USD"
}
```
- This structure means that with U.S. dollars, USD, as the base, it provides exchange rates for euros, EUR, Japanese yen, JPY, British pounds, GBP, and Australian dollars, AUD. The presenter notes that this structure is not the only possible standard, but it is a convenient and common way to organize the data.

**[94:14-94:46] | Actually Calling the Exchange Rate API**
- The presenter demonstrates how to actually call the exchange rate API: visit `https://api.exchangeratesapi.io/latest?base=USD`, using the GET parameter `base=USD` to specify U.S. dollars as the base currency.
- The screen shows the process of entering this URL in the browser address bar and the raw JSON data returned. Although the returned data looks messy because it is not formatted with indentation, its structure is exactly the same as the example shown earlier.

**[94:47-95:31] | Parsing the Actual Returned JSON Data**
- The screen shows a snippet of the JSON data actually returned by the API, containing many currency exchange rates:
```json
{"rates": {
"CAD":1.327819685,"HKD":7.7633372717,"ISK":125.5112242116,
"PHP":50.7288921203,"DKK":6.7913296374,"HUF":306.0619830955,
"CZK":22.6238298646,"GBP":0.7710169954,"RON":4.3310915205,
"SEK":9.5928383168,"IDR":13633.3818049623,"INR":71.1483231846,
"BRL":4.2309370172,"RUB":63.1259656457,"HRK":6.7766063801,
"JPY":109.851858584,"THB":31.0797055349,"CHF":0.9738253204,
"EUR":0.9088430428,"MYR":4.1215123148,"BGN":1.7775152231,
"TRY":5.9880032718,"CNY":6.968644915,"NOK":9.205489412,"NZD":1.5444878669,
"ZAR":14.8166863583,"USD":1.0,"MXN":18.6178315005,"SGD":1.3844406071,
"AUD":1.4797782423,"ILS":3.4327001727,"KRW":1183.1136962647,
"PLN":3.858129601}, "base": "USD", "date": "2020-02-06"}}
```
- The data contains a `base` key with the value `"USD"`, a `date` key with the value `"2020-02-06"`, and a `rates` object that contains exchange rates for dozens of currencies against the U.S. dollar. The presenter points out that simply accessing this URL through an HTTP request provides these real-time exchange rate data for use in an application.

### Key Points Summary

This chapter compares the similarities and differences between JSON and JavaScript object syntax, focusing on the fact that JSON requires key names to be wrapped in double quotes while JS objects can omit them. Nested structure examples show JSON's ability to represent complex data. The chapter also introduces the API concept and uses a currency exchange rate API to demonstrate how to get real-time data in JSON format through HTTP requests, laying the foundation for later data-driven application development.

![92:10](../总结导出案例/lecture5-720p-en_summary/slides/slide_186.cropped.png)
![94:30](../总结导出案例/lecture5-720p-en_summary/slides/slide_189.png)
![95:10](../总结导出案例/lecture5-720p-en_summary/slides/slide_192.cropped.png)


---

## Building the Basic Structure of a Currency Exchange Page [95:31-105:35]

### Timeline Narrative

**[95:31-95:54] | Creating a Basic HTML File**
- Create a new file named `currency.html`.
- Add the standard HTML structure, set the title to "Currency Exchange", and leave the `<body>` tag temporarily empty.
- The core goal is to write JavaScript code that gets external data through a Web request.

**[95:55-96:28] | Introducing the Ajax Concept**
- Review: all previous JavaScript code ran only in the local browser and did not communicate with external servers.
- Introduce Ajax, asynchronous JavaScript: after the page loads, JavaScript can still send additional Web requests to get more information from its own server or a third-party server.
- Goal of this example: the page sends an asynchronous request to get current currency exchange rate data.

**[96:29-97:31] | Sending a Request with the fetch Function**
- Run code after the `DOMContentLoaded` event.
- Use the modern built-in JavaScript `fetch` function to send a Web request.
- The request URL is: `https://api.exchangeratesapi.io/latest?base=USD`
- This URL uses the query parameter `base=USD` to specify U.S. dollars as the base currency.
- To understand how an API works, read its documentation to learn the URL parameters and returned data structure.

**[97:32-98:50] | Handling Promises and Converting the Response**
- `fetch` returns a JavaScript Promise object, which represents a result that will be returned in the future but not necessarily immediately.
- Use the `.then()` method to handle the Promise: when the request returns a response, execute the callback.
- In the first `.then()`, convert the response to JSON format: `.then(response => response.json())`
- Use arrow function shorthand: omit braces and the `return` keyword, writing `response => response.json()` directly.
- The second `.then()` receives the converted JSON data. For now, it only prints it to the console with `console.log(data)`.

**[98:51-99:45] | Simplifying Arrow Function Syntax**
- For a simple function that only transforms input to output, the syntax can be simplified further.
- Omit braces and `return`, writing `response => response.json()` directly.
- Complete code structure:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    fetch('https://api.exchangeratesapi.io/latest?base=USD')
        .then(response => response.json())
        .then(data => {
            console.log(data);
        });
});
```

**[99:46-100:15] | Viewing the Returned Data**
- Open `currency.html`; the page is blank.
- In the JavaScript inspector, check the console output and see the returned JavaScript object.
- After expanding the object, you can see exchange rate data for many currencies, such as the rate for exchanging 1 U.S. dollar into other currencies.

**[100:16-101:13] | Extracting a Specific Exchange Rate**
- Returned data structure: a JavaScript object containing the `rates` key, whose value is a nested object.
- Inside the `rates` object, you can access a corresponding exchange rate through a currency code such as `EUR`.
- Code implementation: `const rate = data.rates.EUR;` gets the USD to EUR exchange rate.

**[101:14-101:56] | Displaying the Exchange Rate on the Page**
- Use `document.querySelector('body').innerHTML = rate;` to write the exchange rate value into the page.
- After refreshing the page, it displays a number like `0.908843`, meaning 1 U.S. dollar is approximately 0.91 euros.
- Use a template string to make the display friendlier: `` `1 US dollar is equal to ${rate} euros` ``

**[101:57-102:25] | Formatting Number Display**
- The default display has too many decimal places, so use the `.toFixed()` method to keep three decimal places.
- Code: `rate.toFixed(3)`, which rounds the exchange rate to three decimal places.
- Final display: "1 US dollar is equal to 0.909 euros"

**[102:26-102:49] | Understanding the Asynchronous Request Flow**
- The whole process is asynchronous: request the latest exchange rate data, then after the data arrives, JavaScript inserts it into the page.
- This implements API communication: get JSON-formatted data and use it to update HTML page content.

**[102:50-103:46] | Adding a User Interaction Form**
- To let the user choose which currency to convert to, add a form inside `<body>`.
- Add an input field: `<input id="currency" placeholder="Currency" type="text">`
- Add a submit button: `<input type="submit" value="Convert">`
- Add a result display area: `<div id="result"></div>`

**[103:47-104:11] | Binding the Form Submit Event**
- Instead of running `fetch` immediately, trigger it when the form is submitted.
- Get the form element: `document.querySelector('form')`
- Set the `onsubmit` event handler, and add `return false` at the end of the function to prevent the form from actually submitting.
- Execute the fetch request inside the event handler function.

**[104:12-105:35] | Dynamically Getting the Currency Entered by the User**
- In the `.then()` callback of `fetch`, get the user input: `const currency = document.querySelector('#currency').value;`
- Use a variable to access the corresponding exchange rate: `data.rates[currency]`, using bracket syntax because the currency code is a variable.
- Complete code structure:
```javascript
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('form').onsubmit = function() {
        fetch('https://api.exchangeratesapi.io/latest?base=USD')
            .then(response => response.json())
            .then(data => {
                const currency = document.querySelector('#currency').value;
                const rate = data.rates[currency];
                document.querySelector('body').innerHTML = `1 USD is equal to ${rate} ${currency}`;
            });
        return false;
    };
});
```

### Key Points Summary

This chapter introduces how to use JavaScript's `fetch` function to send asynchronous HTTP requests and get real-time currency exchange rate data from an external API. By handling Promise objects and chaining `.then()` calls, the response data is converted to JSON format and the needed information is extracted. The chapter ultimately builds an interactive currency exchange page that lets the user enter a target currency code and dynamically displays the real-time exchange rate between U.S. dollars and that currency.


---

## Validating the Currency Entered by the User [105:35-111:23]

### Timeline Narrative

**[105:35-106:15] | Understanding undefined and Object Property Access**
- The presenter raises the core problem: the currency entered by the user is either valid or invalid.
- Explains that in JavaScript, accessing an object property that does not exist returns `undefined`.
- Demonstrates with an example: `let person = {first: 'Harry', last: 'Potter'};`. Accessing `person.first` returns `"Harry"`, accessing `person.last` returns `"Potter"`, but accessing `person.middle` returns `undefined`.
- Points out that `undefined` and `null` have similar meanings but slightly different use cases.

**[106:16-107:04] | Implementing Currency Validation Logic**
- Add a conditional check in the code: `if (rate !== undefined)`. If the exchange rate exists, update the result.
- Update the result display to: `1 USD is equal to ${rate}`, with the currency name displayed dynamically.
- Add an `else` branch: `document.querySelector('#result').innerHTML = 'Invalid currency.';`
- Complete code logic:
```javascript
.then(data => {
    const currency = document.querySelector('#currency').value;
    const rate = data.rates[currency];
    if (rate !== undefined) {
        document.querySelector('#result').innerHTML = `1 USD is equal to ${rate.toFixed(2)}`;
    } else {
        document.querySelector('#result').innerHTML = 'Invalid currency.';
    }
});
```

**[107:05-107:58] | Feature Demonstration and Validation**
- Open the `currency.html` page, enter `EUR`, and click Convert. It displays `1 USD equal to 0.909 euros`.
- Enter `GBP` and click Convert. It displays `1 USD equal to 0.771 pounds`.
- Enter `JPY` and click Convert. It displays `1 USD equal to 109.852 Japanese yen`.
- Each form submission sends another API request and gets the latest exchange rate.
- Enter the invalid currency `foo` and click Convert. The page displays `Invalid currency.`
- Enter `USD` itself, and it displays `1 USD is equal to 1 USD`.

**[107:59-109:08] | Optimization: Handling Case Sensitivity**
- It is discovered that entering lowercase `eur` is judged as an invalid currency.
- Checking the data returned by the API shows that all currency codes are uppercase letters, such as `CAD`, `HKD`, `EUR`, and so on.
- Solution: after getting the user input, call the `.toUpperCase()` method.
- Modified code:
```javascript
const currency = document.querySelector('#currency').value.toUpperCase();
const rate = data.rates[currency];
```
- Demonstration effect: after entering lowercase `euro`, the conversion still works correctly.

**[109:09-110:15] | Adding Error Handling**
- Points out that network requests may fail due to unpredictable situations, such as API downtime or API changes.
- Add a `.catch()` method at the end of the Promise chain to handle errors.
- Complete code structure:
```javascript
fetch('https://api.exchangeratesapi.io/latest?base=USD')
.then(response => response.json())
.then(data => {
    const currency = document.querySelector('#currency').value.toUpperCase();
    const rate = data.rates[currency];
    if (rate !== undefined) {
        document.querySelector('#result').innerHTML = `1 USD is equal to ${rate.toFixed(2)}`;
    } else {
        document.querySelector('#result').innerHTML = 'Invalid currency.';
    }
})
.catch(error => {
    console.log('Error:', error);
});
```
- Error handling makes sure that if the program crashes, the specific error information can be viewed in the console.

**[110:16-111:23] | Summary and Outlook**
- Summarizes the feature that has been built: a complete web page that can communicate with an external API, get information, and update the page.
- Emphasizes JavaScript's core capabilities: client-side code execution, DOM manipulation, and event handling.
- Interactive web pages are implemented through event listeners, such as clicks, scrolling, and key presses.
- Previews that the next section will continue deeper into JavaScript and build more interesting user interfaces.

### Key Points Summary

This chapter implements validation for the currency entered by the user by checking whether the corresponding currency code exists in the data returned by the API, where a returned `undefined` means invalid. It also adds case conversion with `.toUpperCase()` and error handling with `.catch()`. The final result is a complete currency exchange web page that can dynamically get real-time exchange rates and give feedback to the user.
